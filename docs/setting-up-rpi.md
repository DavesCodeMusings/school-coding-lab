# Building a Student Developer Machine on Raspberry Pi
This page details the steps for setting up a Raspberry Pi board for MicroPython development using Visual Studio Code and the MPRemote VS Code extension. Some knowledge of Raspberry Pi is assumed, but most steps should have plenty of detail for the first time user. The steps are geared toward reusing older generations of donated Raspberry Pi hardware. The procedure is tested on a 32-bit Raspberry Pi 2 with 1G of RAM, but model 3 and above is preferred.

The steps here will require the following:
* A PC or Mac with a Micro SD card slot (or appropriate adapter.)
* A network connection (WiFi or RJ-45, depending on model of Raspberry Pi.)
* Access to the internet.

## Creating a Raspberry Pi OS Micro SD Card
Raspberry Pi Operating System installation is different than a typical PC or Mac. The procedure for Raspberry Pi is to write an operating system image to a Micro SD card and then use the Micro SD card to boot the device. This requires the following steps:

1. Installing and running the Raspberry Pi Imager tool.
2. Configuring Raspberry Pi Imager options.
3. Writing the OS image.

### Installing and Running the Raspberry Pi Imager
You may skip this step if Raspberry Pi Imager is already installed.

1. Visit https://www.raspberrypi.com/software/ to download the version of the tool for your operating system.
2. Install the tool by double-clicking the installer file.
3. To run the tool, find Raspberry Pi Imager in the list of installed applications for your PC.

If this isn't your first experience with Raspberry Pi Imager, go ahead and scroll down to the section entitled [Booting Your Raspberry Pi](https://github.com/DavesCodeMusings/mpremote-vscode/wiki/Setting-Up-Raspberry-Pi-OS-for-MPRemote-Visual-Studio-Code#booting-your-raspberry-pi).

### Understanding the Raspberry Pi Imager
If this is your first time using Raspberry Pi Imager, learn more about it by reading and watching the short video on the [Raspberry Pi Imager announcement page](https://www.raspberrypi.com/news/raspberry-pi-imager-imaging-utility/). Keep in mind there have been improvements made to the tool since the video was published, so things will look slightly different. This differences will be highlighted in the procedure below.

### Selecting the Appropriate Options for the Raspberry Pi Imager
There are three things you must choose to create a Micro SD card for use with your Raspberry Pi. There is also a fourth grouping of options that will pre-configure the system for you.

1. Choose the Raspberry Pi device. Because there are several generations of Raspberry Pi, it's important to get this right.
2. Choose an Operating System. In all cases, you will want Raspberry Pi OS. 32-bit or 64-bit depends on the generation of Raspberry Pi hardware.
3. Choose the storage device. This is the easiest step. It is the Micro SD card on your system and is often the only device in the list.
4. Choose additional configuration options. Press CTRL + SHIFT + X to bring up the super secret options page. Visit each tab and fill in as appropriate.

### Raspberry Pi Imager Screenshots
If a picture is worth a thousand words, this section is money in the bank. These screenshots give some examples of what to expect while using the Raspberry Pi Imager. Choices shown are for the older Raspberry Pi 2 hardware. If you're using a 2nd generation Pi 3 or later, you'll want to select a 64-bit OS.

![Imager App on Windows](images/Imager%20App%20on%20Windows.png)

_Figure 1: Finding the app (Windows OS example)_

___

![Imager Start-Up](images/Imager%20Start-Up.png)

_Figure 2: Raspberry Pi Imager started up and awaiting your choices_

___

![Imager Choose Device](images/Imager%20Choose%20Device.png)

_Figure 3: Choosing a device of Raspberry Pi 2_

___

![Imager Choose OS](images/Imager%20Choose%20OS.png)

_Figure 4: Choosing a 32-bit OS for Raspbery Pi 2_

___

![Imager Choose Storage](images/Imager%20Choose%20Storage.png)


_Figure 5: Choosing the Micro SD card_

___

![Imager OS Customization General](images/Imager%20OS%20Customization%20General.png)

_Figure 6: The General tab of customization (CTRL + SHIFT + X)_

___

![Imager OS Customization Services](images/Imager%20OS%20Customization%20Services.png)

_Figure 7: The Services tab for enabling Secure Shell (SSH) connections if desired_

___

![Imager OS Customization Options Leave Default](images/Imager%20OS%20Customization%20Options%20Leave%20Default.png)

_Figure 8: Default options showing the Micro SD will be ejected when writing is finished_

___

![Imager Writing](images/Imager%20Writing.png)

_Figure 9: Raspberry Pi Imager writing after all options have been selected_

## Booting Your Raspberry Pi
After writing the Raspberry Pi OS image, you can remove the Micro SD card from your PC and insert it into the slot on the Raspberry Pi.

1. Ensure the Raspberry Pi is not plugged into power.
2. Insert the Micro SD card into the slot taking care to orient it the correct way.
3. Attach an HDMI monitor with the appropriate cable for your device (standard or micro HDMI).
4. Plug in an appropriate power supply for your device (Official Raspberry Pi or Canakit power supplies are a good choice.)
5. Watch the monitor for signs of life.

Booting could take several minutes the first time. If you see a Raspberry Pi Desktop logo on the monitor, things are moving in the right direction. Just be patient.

## Initial Update of the Operating System
Staying current on Operating System updates is key to maintaining a stable and secure environment. This step shows how to update Raspberry Pi OS using command-line tools. This can either be done by opening a command prompt from the Raspberry Pi Desktop or you can use Secure Shell (SSH) from a remote machine to do this.

The first update can take a significant amount of time, particularly on older Raspberry Pi models. After the first update, establish a habit of weekly updates. This will not only keep your OS secure, it will shorten the time required for each update.

1. Open a command prompt (either from the desktop or using SSH.)
2. Update the list of available software with `sudo apt-get update`
3. Install any available upgrades with `sudo apt-get upgrade`
4. Reboot the system when finished.

A successful update will look like the following example, though much of the output has been trimmed for brevity.

```
$ sudo apt-get update
Reading package lists... Done

$ sudo apt-get upgrade
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
Do you want to continue? [Y/n] y

$ sudo shutdown -r now
The system will reboot now!
```

## Installing MPRemote for MicroPython
This section will concentrate on installing the MPRemote command-line tool that the MPRemote Visual Studio extension will use. The steps here assume you have Raspberry Pi OS installed and have applied the latest updates for the Raspberry Pi OS. If you haven't done that, see the sections above.

All steps are shown using command-line, either from a terminal launched from the Raspberry Pi desktop or from a Secure Shell (SSH) connection.

1. Install the pipx python package tool with the command `sudo apt-get install pipx`
2. Install mpremote using pipx with the command `pipx install mpremote`
3. Ensure mpremote can be run easily using the command `pipx ensurepath`
4. Re-apply login settings with `source ~/.bashrc`
5. Test with the command `mpremote` (This will give an error, because no MicroPython device is plugged in, but that's okay.)

Successful installation and testing will look like the example below.

```
$ sudo apt-get install pipx
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
Do you want to continue? [Y/n] y

$ pipx install mpremote
  installed package mpremote 1.22.0, installed using Python 3.11.2
  These apps are now globally available
    - mpremote

$ pipx ensurepath
Success!

$ source ~/.bashrc

$ mpremote
failed to access /dev/ttyUSB0 (it may be in use by another program)
```

The failure message is due to no MicroPython device being plugged into USB. This is okay to ignore for now.

## Optionally Installing ESPTool
If you're using Espressif ESP32 devices as your microcontrollers, ESPTool provides the ability to flash their firmware with MicroPython. It's installed with pipx, similar to the way MPRemote is installed.

```
$ pipx install mpremote
  installed package mpremote 1.22.0, installed using Python 3.11.2
  These apps are now globally available
    - esp_rfc2217_server.py
    - espefuse.py
    - espsecure.py
    - esptool.py
```

## Installing Visual Studio Code
Visual Studio Code installation is similar to installing other system software on Raspberry Pi OS. The command is simply:

```
sudo apt-get install code
```

For additional information about installing, see this guide for Visual Studio Code on Raspberry Pi OS:

https://code.visualstudio.com/docs/setup/raspberry-pi

For tutorials on how to use VS Code, see the Getting Started videos.

https://code.visualstudio.com/docs/getstarted/introvideos

## Installing the MPRemote VS Code Extension
You have the option of installing from within Visual Studio Code, or you can install from the Raspberry Pi OS command-line.

Use the following commands to install and verify extensions:
* For MPRemote: `code --install-extension DavesCodeMusings.MPRemote`
* To verify what extensions are installed: `code --list-extensions`

An example of a successful command-line installation of extensions is shown here.

```
$ code --install-extension DavesCodeMusings.MPRemote
Installing extensions...
Installing extension 'davescodemusings.mpremote'...
Extension 'davescodemusings.mpremote' v1.21.11 was successfully installed.

$ code --list-extensions
davescodemusings.mpremote
```

>## Optionally Enabling VNC Connection
>VSCode is a graphical user interface (GUI) program. If you want to use it remotely (i.e. without the monitor, keyboard, and mouse attached tot he Pi) you can enable remote access with VNC.
>
>The following guide on raspberrypi.com explains how to do it:
>
>https://www.raspberrypi.com/documentation/computers/remote-access.html#enable-the-vnc-server-on-the-command-line

## Next Steps
Congratulations on getting your Raspberry Pi configured for MicroPython development using Visual Studio Code. And give yourself an extra pat on the back if you upcycled an older, discarded Pi for this purpose.

Now you're ready to explore MicroPython programming on microcontrollers.

Information about MicroPython can be found on their web site:

https://micropython.org/

Documentation for Espressif's ESP32C development board is here:

https://docs.espressif.com/projects/esp-idf/en/latest/esp32c3/hw-reference/esp32c3/user-guide-devkitc-02.html

Happy Coding!
