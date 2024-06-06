# Getting Started with MicroPython on ESP32
In this lab you will get familiar with installing MicroPython on the ESP32 microcontroller and creating your first MicroPython program.

For this lab, you will need the following:
* A Raspberry Pi development workstation
* An ESP32C3 devkit microcontroller
* A USB Micro-B cable attaching the ESP32C3 to the Raspberry Pi

## Verifying Your Development Host
Log into the Raspberry Pi with the username and password given by your lab coordinator. Verify the needed programs are installed by running the commands listed below.
* `esptool.py --help`
* `mpremote --help`

If your Raspberry Pi development host is set up correctly, you should see help output for each command similar to what's shown below. If you see _command not found_ or another error, contact your lab coordinator for help.

```
$ esptool.py --help
usage: esptool [-h]

$ mpremote --help
mpremote -- MicroPython remote control
```

>Note: Only the first line of the help output is shown for brevity. Actual output will be several lines.

## Installing MicroPython
Preparing your microcontroller to run MicroPython involves copying a file called a _binary image_ to the _flash ram_ of your microcontroller. This process is called _flashing_. Flashing your ESP32C3 is done using _esptool.py_ on your Raspberry Pi development host.

Here's how the process works:
1. Start by finding the [MicroPython binary image](https://micropython.org/download/ESP32_GENERIC_C3/). It should have already been downloaded by your lab coordinator.
2. Change directory (cd) to where the image is located so when you type `ls` it appears in the directory listing.
3. Erase the ESP32C3 flash RAM with the command: `esptool.py --chip esp32c3 --port /dev/ttyUSB0 erase_flash`
4. Write the MicroPython to the ESP32C3 using: `esptool.py --chip esp32c3 --port /dev/ttyUSB0 write_flash -z 0x0 esp32c3-20220117-v1.23.0.bin` ; where _esp32c3-20220117-v1.23.0.bin_ is the name of the binary image you found in step 1.

Here's an example of a successful flash with esptool.py:

```
$ cd Downloads

$ ls
esp32c3-20220117-v1.23.0.bin

$ esptool.py --chip esp32c3 --port /dev/ttyUSB0 erase_flash
TODO: Add output

$ esptool.py --chip esp32c3 --port /dev/ttyUSB0 write_flash -z 0x0 esp32c3-20220117-v1.23.0.bin
TODO: Add output
```



TODO:
* upload with mpremote
* boot.py vs. main.py
* Testing with boot/main project that prints a message from each file
