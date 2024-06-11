#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Usage: $0 <package>"
  exit 1
fi
package=$1
shift
# This echo is important. The custom compiler plugin (ultratsc) uses it to
# correctly map files to their packages.
echo "Building $package"

ts_config=tsconfig.build.json
if [ ! -z "$1" ]; then
  ts_config=$1
  shift
fi

ts_config_path=$package/$ts_config
if [ ! -f "$ts_config_path" ]; then
  echo "File not found: '$ts_config_path' in $(pwd)"
  exit 1
fi

# I wish I could use `yarn build` or `nx` here, but I have to tell tsc not to
# print colored output.
yarn exec tsc --pretty false -p $ts_config_path $*

