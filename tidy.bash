#!/bin/bash

# tidy.bash
#
# Recursively removes content from directories which
# has not been modified since N days or N minutes.
#
# tidy_path[n] is path without trailing slash.
# tidy_time[n] is 'time +N' for N days, or 'min +N' for N minutes.

# Note: time +2 means "more than 2 days", e.g. 3 days old or older.

# Log to syslog
logger "Tidying directories..."

unset tidy_path tidy_time

# ----------------------------------------
# Array of paths to tidy and their times
# ----------------------------------------

# Delete received files after 14 days
tidy_path[0]='/Users/j/Downloads/received'
	tidy_time[0]='time +14'

# Delete web downloads after 1 day
tidy_path[1]='/Users/j/Downloads/web'
	tidy_time[1]='time +1'

# Delete files on desktop after 7 days
tidy_path[2]='/Users/j/Desktop'
	tidy_time[2]='time +7'

# ----------------------------------------

i=0
while [ "$i" -lt "${#tidy_path[@]}" ]
do
	[ ! -z "${tidy_path[$i]}" ] && [ ! -z "${tidy_time[$i]}" ] && find ${tidy_path[$i]} -mindepth 1 -m${tidy_time[$i]} -delete
	let i+=1
done
