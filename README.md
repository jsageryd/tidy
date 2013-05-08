Housekeeping script
===================

This is a script to automatically remove expired content from specified directories.

- Deletes any file older than set limit.
- Deletes empty directories or directory structures, regardless of age.


Usage
------------------

1. Configure paths and expiry time in `tidy.bash`.

2. Edit crontab (`crontab -e`) and add for example:

	0       *       *       *       *       $HOME/Documents/scripts/tidy/tidy.bash

Disclaimer
------------------

I take no responsibility for this script should it cause any harm.
