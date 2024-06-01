# How to Identify Your Raspberry Pi Model Number
Somebody found out you're doing a Raspberry Pi lab. They know a guy, who knows a kid, who's got a drawer full of old Pis at home. Those Pis are now in a box and it's sitting on your desk.

As you begin to question the life choices that led you here, you might be wondering, _Is that box of Pis even any good?_

Read on and find out.

## Visual Inspection
You can tell a lot about the generation of Raspberry Pi just by looking at it. All recent boards have the model number silkscreened under the GPIO header (the double row of pins on the top edge.) The one in the picture below is a Raspberry Pi 3 Model B V1.2.

![Raspberry Pi 3 Photo](images/Raspberry_Pi_3.jpg)

_Public Domain Image of Raspberry Pi 3_

___

Most modern Raspberry Pis are about the size of a credit card and look like the photo with a few minor differences in the HDMI and USB port arrangement. If the board you're looking at is quite a bit smaller, has fewer than four USB ports, or has fewer than four mounting holes, it probably won't be suitable.

The notable exception is the Raspberry Pi 400 which is a computer built into a red and white keyboard. It's less common, but if you've got one, hang on to it. It can do everything a Raspberry Pi 4 can do.

## Software Inspection
Alternatively, you can find out about the Raspberry Pi model from the Raspberry Pi OS terminal prompt. Honestly, it's easier just to read the silkscreening on the board, but if you're so inclined, read on.

You'll need to use a Micro SD card with Raspberry Pi OS for this.

1. Attach the Pi to power, keyboard, mouse, and monitor.
2. Boot and start a terminal.
3. Display the contents of the file: /proc/cpuinfo
4. Take note of the last few lines. 

Here's an example of a Raspberry Pi 3 like the one in the photo:
```
$ cat /proc/cpuinfo
[output removed for brevity]
Hardware        : BCM2835
Revision        : a020d3
Serial          : 000000decafc0fee
Model           : Raspberry Pi 3 Model B Plus Rev 1.2
```

For more detailed information, cross-reference with the list in this article: https://www.raspberrypi-spy.co.uk/2012/09/checking-your-raspberry-pi-board-version/
