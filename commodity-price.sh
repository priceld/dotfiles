#! /usr/bin/env bash

URL="https://www.andersonsgrain.com/locations/in/dunkirk/"

DATA_DIR="$HOME/.config/commodity-checker"

if [[ ! -d $DATA_DIR ]]; then
	mkdir $DATA_DIR
fi

# Checks the current bid for the given commodity (Soybean or Corn)
# Prints the bid and delta separated by a comma.
check-bid() {
	local COMMODITY="$1"

	local result=$(/opt/homebrew/bin/xidel --silent $URL --xpath3 "//div[@class='CashBids']//table[descendant::caption[contains(.,'$COMMODITY')]]/tbody/tr[1]/td[@data-col='bid' or @data-col='change']/text()")
	echo $result | sed 's/ /,/'
}
BID=$(check-bid "Soybean")
echo "$(date -Iseconds),$BID" >>$DATA_DIR/bids.txt

# I set up this script to run on a schdule using crontab. Here's my current config:
#
# At every 30th minute past every hour from 8 through 17 on every day-of-week
# from Monday through Friday in October, November, December, January, and
# February.
#*/30 8-17 * 10,11,12,1,2 1-5 /Users/Logan.Price/work/dotfiles/commodity-check.sh
