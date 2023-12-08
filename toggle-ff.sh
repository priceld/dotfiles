#!/bin/bash

BASE_URL="https://mylearn.int.bbpd.io"
FF_BASE_URL="$BASE_URL/learn/api/v1/featureFlags"
COOKIE_JAR="$HOME/.config/toggle-flag/cookies.txt"
XSRF_TOKEN=""

# Function to log in to Learn. The result we care about is saving cookies to the cookie jar.
login() {
	local USERNAME="administrator"
	local PASSWORD="changeme"
	local LOGIN_URL="$BASE_URL/webapps/login/"
	local NONCE_KEY="blackboard.platform.security.NonceUtil.nonce.ajax"

	# Extract the nonce value from the login page.
	local NONCE=$(curl -s -c "$COOKIE_JAR" "$LOGIN_URL" | grep -m 1 "name=\"$NONCE_KEY\"" | sed -n 's/.*value="\(.*\)".*/\1/p')

	# POST request to log in
	curl -s -b "$COOKIE_JAR" -c "$COOKIE_JAR" -X POST \
		--data-urlencode "user_id=$USERNAME" \
		--data-urlencode "password=$PASSWORD" \
		--data-urlencode "login=Sign In" \
		--data-urlencode "action=login" \
		--data-urlencode "new_loc=" \
		--data-urlencode "$NONCE_KEY=$NONCE" \
		"$LOGIN_URL" \
		-o /dev/null
}

get_xsrf_token() {
	# GET request to obtain an XSRF token
	local XSRF_URL="$BASE_URL/learn/api/v1/utilities/xsrfToken"
	local XSRF_OUTPUT=$(mktemp)
	local XSRF_RESULT=$(curl -s -b "$COOKIE_JAR" -c "$COOKIE_JAR" "$XSRF_URL" -o "$XSRF_OUTPUT" -w "%{http_code}")
	if [ "$XSRF_RESULT" != "200" ]; then
		echo 1>&2 "Unable to get XSRF Token"
		exit 1
	fi
	cat "$XSRF_OUTPUT" | jq -r .xsrfToken
}

ensure_login() {
	if [ -n "$XSRF_TOKEN" ]; then
		# We already have and XSRF token so we've already logged in.
		return 0
	fi
	XSRF_TOKEN=$(get_xsrf_token)
	if [ $? -ne 0 ]; then
		echo "Attempting to log in..."
		login
	fi

	XSRF_TOKEN=$(get_xsrf_token)
	if [ $? -ne 0 ]; then
		echo "Giving up!"
		exit 1
	fi
}

set_flag() {
	local FLAG_KEY="$1"
	local FLAG_VALUE="$2"

	JSON_PAYLOAD="{\"flagKey\":\"$FLAG_KEY\",\"flagValue\":\"$FLAG_VALUE\"}"
	PUT_URL="$FF_BASE_URL/$FLAG_KEY"

	curl -s -b "$COOKIE_JAR" -c "$COOKIE_JAR" -X PUT -H "X-Blackboard-XSRF: $XSRF_TOKEN" -H "Content-Type: application/json" -d "$JSON_PAYLOAD" "$PUT_URL"
}

get_flags() {
	echo $(curl -s -b "$COOKIE_JAR" -c "$COOKIE_JAR" -H "X-Blackboard-XSRF: $XSRF_TOKEN" "$FF_BASE_URL" | jq -r .results[].flagDefinition.flagKey)
}

# Function to display usage/help message
show_help() {
	echo "Usage: $0 [OPTIONS] flagKey flagValue"
	echo "OPTIONS:"
	echo "  --help           Display this help message"
	echo "  --clean          Delete the cookie jar (if exists) and exit"
	echo "  --interactive    Run the script in interactive mode. When used flagKey"
	echo "                   and flagValue are ignored."
	echo "flagKey           The key of the feature flag to modify"
	echo "flagValue         The new value for the feature flag (true or false)"
}

# Check for the presence of --help
if [[ "$1" == "--help" ]]; then
	show_help
	exit 0
fi

# Check if the script is called with "--clean" to delete the cookie jar
if [ "$1" == "--clean" ]; then
	echo "Cleaning the cookie jar..."
	rm "$COOKIE_JAR"
	exit 0
fi

FLAG_KEY="$1"
FLAG_VALUE="$2"

if [[ "$1" == "--interactive" ]]; then
	ensure_login
	FLAG_KEY=$(echo $(get_flags) | tr " " "\n" | fzf --height=~10)
	FLAG_VALUE=$(echo "true false" | tr " " "\n" | fzf --height=~10)
fi

if [[ -z "$FLAG_KEY" || -z "$FLAG_VALUE" ]]; then
	echo "Invalid usage. Expected flagKey and flagValue. Use --help for usage information."
	exit 1
fi

ensure_login
set_flag "$FLAG_KEY" "$FLAG_VALUE"
