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
tidy_path[0]='/Users/j/Downloads/received'
tidy_time[0]='time +14'

# Delete web downloads after 1 day
tidy_path[1]='/Users/j/Downloads/web'
tidy_time[1]='time +1'

# Delete files on desktop after 7 days
tidy_path[2]='/Users/j/Desktop'
tidy_time[2]='time +7'

# Delete files from Dropbox/Public/1h after 1 hour
tidy_path[3]='/Users/j/Dropbox/Public/1h'
tidy_time[3]='min +60'

# Delete files from Dropbox/Public/2h after 2 hours
tidy_path[4]='/Users/j/Dropbox/Public/2h'
tidy_time[4]='min +120'

# Delete files from Dropbox/Public/24h after 24 hours
tidy_path[5]='/Users/j/Dropbox/Public/24h'
tidy_time[5]='min +1440'

# Delete files from Dropbox/Public/48h after 48 hours
tidy_path[6]='/Users/j/Dropbox/Public/48h'
tidy_time[6]='min +2880'

# Delete files from Dropbox/Public/7d after 7 days
tidy_path[7]='/Users/j/Dropbox/Public/7d'
tidy_time[7]='time +7'

# Delete files from Dropbox/Public/14d after 14 days
tidy_path[8]='/Users/j/Dropbox/Public/14d'
tidy_time[8]='time +14'

# Delete files from Dropbox/Public/30d after 30 days
tidy_path[9]='/Users/j/Dropbox/Public/30d'
tidy_time[9]='time +30'

# Delete files from Dropbox/Public/90d after 90 days
tidy_path[10]='/Users/j/Dropbox/Public/90d'
tidy_time[10]='time +90'

# Remove empty folders from Dropbox/Public (and any files older than 90 days)
tidy_path[11]='/Users/j/Dropbox/Public'
tidy_time[11]='time +90'

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
