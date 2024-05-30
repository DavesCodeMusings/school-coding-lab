# How to Identify the Raspberry Pi Model Number
Somebody found out you're doing a Raspberry Pi lab. They know a guy, who knows a kid, who's got a drawer full of old Pis at home. Those Pis are now in a box and it's sitting on your desk.

As you begin to question the life choices that led you here, you might be wondering, _Is that box of Pis even any good?_

Read on and find out.

## Visual Inspection
You can tell a lot about the generation of Raspberry Pi just by looking at it. All recent boards have the model number silkscreened under the GPIO header (the double row of pins on the top edge.) The one in the picture below is a Raspberry Pi 3 Model B.

![Raspberry Pi 3 Photo](images/Raspberry_Pi_3.jpg)

_Public Domain image of Raspberry Pi 3_

___

Most modern Raspberry Pis are about the size of a credit card and look like the photo with a few minor differences in the HDMI and USB port arrangement. If the board you're looking at is quite a bit smaller or has fewer than four USB ports, it probably won't be suitable.

The notable exception is the Raspberry Pi 400 which is a computer built into a red and white keyboard. It's less common, but if you've got one, hang on to it. It can do everything a Raspberry Pi 4 can do.

## Software Inspection
You'll need to use a Micro SD card with Raspberry Pi OS for this.

1. Attach the Pi to power, keyboard, mouse, and monitor.
2. Boot and start a terminal.
3. Display the contents of the file: /proc/cpuinfo
4. Take note of the last few lines. 

Here's an example of an older Raspberry Pi 2
```
$ cat /proc/cpuinfo
[output removed for brevity]
Hardware        : BCM2835
Revision        : a21041
Serial          : 0000000077b30e4e
Model           : Raspberry Pi 2 Model B Rev 1.1
```

For more detailed information, cross-reference with the list in this article: https://www.raspberrypi-spy.co.uk/2012/09/checking-your-raspberry-pi-board-version/
