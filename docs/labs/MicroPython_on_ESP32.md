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

## Installing MicroPython with ESPTool
Preparing your microcontroller to run MicroPython involves copying a file called a _binary image_ to the _flash ram_ of your microcontroller. This process is called _flashing_. Flashing your ESP32C3 is done using _esptool.py_ on your Raspberry Pi development host.

Here's how the process works:
1. Start by finding the [MicroPython binary image](https://micropython.org/download/ESP32_GENERIC_C3/). It should have already been downloaded by your lab coordinator.
2. Change directory (cd) to where the image is located so when you type the command `ls` it appears in the directory listing.
3. Erase the ESP32C3 flash RAM with the command: `esptool.py --chip esp32c3 --port /dev/ttyUSB0 erase_flash`
4. Write the MicroPython to the ESP32C3 using: `esptool.py --chip esp32c3 --port /dev/ttyUSB0 write_flash -z 0x0 ESP32_GENERIC_C3-20240602-v1.23.0.bin` ; where _ESP32_GENERIC_C3-20240602-v1.23.0.bin_ is the name of the binary image you found in step 1.

Here's an example of a successful flash with esptool.py:

```
$ cd Downloads

$ ls
ESP32_GENERIC_C3-20240602-v1.23.0.bin  hello.py  hw_specs.py

$ esptool.py --chip esp32c3 --port /dev/ttyUSB0 erase_flash
esptool.py v4.7.0
Serial port /dev/ttyUSB0
Connecting....
Chip is ESP32-C3 (QFN32) (revision v0.4)
Features: WiFi, BLE
Crystal is 40MHz
MAC: dc:da:0c:d2:48:1c
Uploading stub...
Running stub...
Stub running...
Erasing flash (this may take a while)...
Chip erase completed successfully in 12.4s
Hard resetting via RTS pin...

$ esptool.py --chip esp32c3 --port /dev/ttyUSB0 write_flash -z 0x0 ESP32_GENERIC_C3-20240602-v1.23.0.bin
esptool.py v4.7.0
Serial port /dev/ttyUSB0
Connecting....
Chip is ESP32-C3 (QFN32) (revision v0.4)
Features: WiFi, BLE
Crystal is 40MHz
MAC: dc:da:0c:d2:48:1c
Uploading stub...
Running stub...
Stub running...
Configuring flash size...
Flash will be erased from 0x00000000 to 0x00197fff...
Compressed 1667600 bytes to 1000925...
Wrote 1667600 bytes (1000925 compressed) at 0x00000000 in 89.6 seconds (effective 148.8 kbit/s)...
Hash of data verified.
Leaving...
Hard resetting via RTS pin...
```

If the output from your Raspberry Pi development host looks similar to what's shown above, congratulations! You have successfully flashed MicroPython onto your ESP32C3 microcontroller. This step is one of the more difficult tasks. Fortunately, it only has to be done once on each microcontroller.

From here on out, we'll be concentrating on writing MicroPython programs.

## Running MicroPython with MPRemote
After preparing the microcontroller with MicroPython, you're ready to start running programs.

### Hello World
The first program in nearly any programming language course is Hello World. It's not very fancy. It simply shows the message _Hello World_ on the screen. Running Hello World on the ESP32C3 microcontroller is done with the help of a program called MPRemote.

Here's how it works.
1. Start by locating the _hello.py_ program. It should be in the same directory where you found the MicroPython binary image.
2. Change directory (cd) to where hello.py is.
3. Run the program with the command: `mpremote run hello.py`

If all goes well, you should see the output below.

```
$ mpremote run hello.py
Hello World!
```

So what just happened here? The hello.py program is located on the Raspberry Pi, but it ran on the ESP32C3 microcontroller with the help of the `mpremote run` command.

It's just a regular Python program, so you could run hello.py on the Raspberry Pi as well. The example below shows what that would look like.

```
$ python3 hello.py
Hello World!
```

Both mpremote and python3 produced the same results on the screen: _Hello World_. So how do you know it really ran on the ESP32C3 microcontroller and not on the Raspberry Pi?

### Hardware Specs
The next program will show CPU, RAM, and flash memory. It's called _hw_specs.py_ and it only runs on microcontrollers.

Running on the microcontroller should look something like this:

```
$ mpremote run hw_specs.py
CPU:       esp32
Speed:    160MHz
RAM:       197KB
Flash:       4MB
MicroPy:  1.23.0
```

Running directly on the Raspberry Pi gives an error.

```
$ python3 hw_specs.py
Traceback (most recent call last):
  File "/home/student/Downloads/hw_specs.py", line 2, in <module>
    from machine import freq
ModuleNotFoundError: No module named 'machine'
```

>The _machine_ module in the error above is what causes it to fail. Only microcontrollers use the machine module. We'll learn more about modules in the upcoming labs.

## Next Steps
Now that you have MicroPython flashed onto your microcontroller and you know how to run programs with _mpremote_, you're ready to start writing your own programs.

You'll use a code editor called Visual Studio Code. Many times you'll see its name shortened as _VS Code_. In the next lab, you'll learn how to use VS Code in your Raspberry Pi development environment.
