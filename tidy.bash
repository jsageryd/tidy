#!/bin/bash

# tidy.bash
#
# Recursively removes content from directories which
# has not been modified since N days or N minutes.
# Also removes empty directories or directory structures, regardless of age.
#
# tidy_path[n] is path without trailing slash.
# tidy_time[n] is 'time +N' for N days, or 'min +N' for N minutes.

# Note: time +2 means "more than 2 days", e.g. 3 days old or older.

# Log to syslog
logger -t Tidy "Tidying directories..."

unset tidy_path tidy_time

# ----------------------------------------
# Array of paths to tidy and their times
# ----------------------------------------

# Delete received files after 14 days
tidy_path[0]="$HOME/Downloads/received"
tidy_time[0]='time +14'

# Delete web downloads after 1 day
tidy_path[1]="$HOME/Downloads/web"
tidy_time[1]='time +1'

# Delete files on desktop after 7 days
tidy_path[2]="$HOME/Desktop"
tidy_time[2]='time +7'

# ----------------------------------------

i=0
while [ "$i" -lt "${#tidy_path[@]}" ]
do
  if [ ! -z "${tidy_path[$i]}" ] && [ ! -z "${tidy_time[$i]}" ]; then
    # Remove files
    find ${tidy_path[$i]} -mindepth 1 -m${tidy_time[$i]} -delete > /dev/null 2>&1

    # Remove any empty directories regardless of their timestamp
    find ${tidy_path[$i]} -mindepth 1 -d -type d -exec rmdir {} \; > /dev/null 2>&1
  fi
  let i+=1
done
