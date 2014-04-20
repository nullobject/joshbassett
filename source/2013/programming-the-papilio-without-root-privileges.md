---
title: Programming The Papilio Without Root Privileges
date: 2013-09-22
---

**Having** to run the [Papilio programmer](https://github.com/GadgetFactory/Papilio-Loader/tree/master/papilio-prog) utility as root is undesirable. I wanted to be able to access the Papilio USB device from my unprivileged user account in order to program my [Papilio Pro](http://papilio.cc/index.php?n=Papilio.PapilioPro) board. Fortunately this can be achieved easily with a udev rule file and a couple of group ownership tweaks.

## Add your user account to the *dialout* group

Firstly, you need to ensure that your user account is a member of the *dialout* group:

    $ sudo usermod -a -G dialout `whoami`

You will also need to log out and log back in for your group memberships to be updated.

## Change the group of the Papilio programmer binary

Secondly, you need to change the group ownership of the Papilio programmer to *dialout*:

    $ sudo chgrp dialout /usr/local/bin/papilio-prog

## Add a udev rules file

Lastly, you need to add a udev rules file for the Papilio. This rule instructs the udev system that the Papilio USB device should be owned by the *dialout* group when it is connected.

Create the file `/etc/udev/rules.d/papilio.rules`:

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", GROUP="dialout"

You will then need to disconnect and reconnect your Papilio board for the new rules to be applied.

## Profit

You should now be able to run the Papilio programmer from your unprivileged user account:

    $ papilio-prog -c
    Using built-in device list
    JTAG chainpos: 0 Device IDCODE = 0x24001093 Desc: XC6SLX9

    ISC_Done       = 1
    ISC_Enabled    = 0
    House Cleaning = 1
    DONE           = 1
