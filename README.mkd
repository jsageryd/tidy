Housekeeping script
===================

This is a script to automatically remove expired content from specified directories.
Deletes any file older than set limit.


Usage
------------------

1. Configure paths and expiry time in `tidy.bash`.

2. Set the correct path to `tidy.bash` in `tidy.plist`.

3. Copy `tidy.plist` into `/Library/LaunchDaemons/`.

4. `chown root:wheel /Library/LaunchDaemons/tidy.plist`.

5. Reboot or load manually using `launchctl`.


Disclaimer
------------------

I take no responsibility for this script should it cause any harm.
