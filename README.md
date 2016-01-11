# CTO

1. Build it
2. Flash zip

## BUILD IT

The bootstrap script should have everything you need.  Run the `cyanogen`
function.

You should end up with a bunch of .img and .zip files.

## FLASH ZIP

Copy the .zip files to your local machine.  The last time I built it, I ended
up with two zip files:

* `cm-11-20160111-UNOFFICIAL-mystul.zip`
* `cm_mystul-ota-6f4c050da4.zip`

`diff` tells me that they're identical.

### BOOTING INTO RECOVERY

1. Hold power and volume-down until you get into the HBOOT screen.
2. Go to `FASTBOOT`
3. Press down.  `FASTBOOT USB` should show.
4. On your computer, do `fastboot erase cache` and then `fastboot flash
   recovery <name of rom>.img`
5. On the phone, select `POWER DOWN`.
6. The phone will shut down.  Wait about five seconds.  Now, hold power and
   volume-down until you get to the HBOOT screen again.
7. On the phone, select `RECOVERY`.

### SIDELOADING THE ZIP

1. Once you're in recovery, do a factory reset.
2. There should be an option like "install zip".  Pick it, then on the computer
   run `adb sideload cm_mystul-ota-6f4c050da4.zip`.

That's it?  The camera works now.

# INSTALLING OPENGAPPS

I sideloaded them through ClockworkMod Recovery, but Cyanogen wouldn't boot
until I cleared the cache.  (I cleared the cache through another boot to
recovery).
