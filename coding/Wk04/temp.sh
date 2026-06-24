#!/bin/dash

temporary_dir=$(mktemp -d)
# shellcheck disable=SC2064
trap "rm -r $temporary_dir" EXIT

cd "$temporary_dir" || exit 1

## xargs passes seq 1 1000 as args to command following after xargs
## touch creates file if doesn't exist 
# seq 1 1000|xargs touch

echo "$temporary_dir"

echo -n "ready to rm?"

read -r answer