# Building a Student Developer Machine on Raspberry Pi
This page details the steps for setting up a Raspberry Pi board for MicroPython development using Visual Studio Code and the MPRemote VS Code extension. Some knowledge of Raspberry Pi is assumed, but most steps should have plenty of detail for the first time user. The steps are geared toward reusing older generations of donated Raspberry Pi hardware. The procedure is tested on a 32-bit Raspberry Pi 2 with 1G of RAM, but model 3 and above is preferred.

The steps here will require the following:
* A PC or Mac with a Micro SD card slot (or appropriate adapter.)
* A network connection (WiFi or RJ-45, depending on model of Raspberry Pi.)
* Access to the internet.

> If your Raspberry Pi hardware was donated and you're not sure what you've got, see the page for [how to identify your Raspberry Pi](identify_rpi.md).

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

#### The OS Customization General Tab
Careful consideration of the information on the General tab can make your life much easier, so don't skip it.

1. _Set hostname_ determines what the machine will be called. It can be almost anything you want, but it should be no more than a dozen or so alphanumeric characters and it must be unique (i.e. you can't name everything raspberrypi.)
2. _Set username and password_ is used to create the first user account. This account is allowed to run `sudo` commands. Make the username something generic, like admin or supervisor, rather than a person's name. You can add individual accounts for people later on. Make the password something not easily guessed.
3. _Configure wireless LAN_ will ger you automatically connected to the network you specify. Don't forget to set the country code in addition to the SSID and password.
4. _Set locale settings_ makes sure you're in the right time zone and your clock is correct. It also ensures you don't get strange characters from your keyboard by configuring for your language.

Once the information is entered, you have the option to save it. This makes it faster to create multiple Micro SD cards if you have more than one Pi.

### Raspberry Pi Imager Screenshots
If a picture is worth a thousand words, this section is money in the bank. These screenshots give some examples of what to expect while using the Raspberry Pi Imager. Choices shown are for the older Raspberry Pi 2 hardware. If you're using a 2nd generation Pi 3 or later, you'll want to select a 64-bit OS.

![Imager App on Windows](../images/Imager%20App%20on%20Windows.png)

_Figure 1: Finding the app (Windows OS example)_

___

![Imager Start-Up](../images/Imager%20Start-Up.png)

_Figure 2: Raspberry Pi Imager started up and awaiting your choices_

___

![Imager Choose Device](../images/Imager%20Choose%20Device.png)

_Figure 3: Choosing a device of Raspberry Pi 2_

___

![Imager Choose OS](../images/Imager%20Choose%20OS.png)

_Figure 4: Choosing a 32-bit OS for Raspbery Pi 2_

___

![Imager Choose Storage](../images/Imager%20Choose%20Storage.png)


_Figure 5: Choosing the Micro SD card_

___

![Imager OS Customization General](../images/Imager%20OS%20Customization%20General.png)

_Figure 6: The General tab of customization (CTRL + SHIFT + X)_

___

![Imager OS Customization Services](../images/Imager%20OS%20Customization%20Services.png)

_Figure 7: The Services tab for enabling Secure Shell (SSH) connections if desired_

___

![Imager OS Customization Options Leave Default](../images/Imager%20OS%20Customization%20Options%20Leave%20Default.png)

_Figure 8: Default options showing the Micro SD will be ejected when writing is finished_

___

![Imager Writing](../images/Imager%20Writing.png)

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
4. Reboot the system when finished with `sudo shutdown -r now`

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

## Optionally Enabling Remote Access
You can skip this if you'll always be using a keyboard, mouse, and monitor with your Raspberry Pi. But if you think you might need to access the Pi from another machine, see the [guide for setting up remote access](remote_access.md).

## Next Steps
Congratulations on getting your Raspberry Pi configured. And give yourself an extra pat on the back if you upcycled an older, discarded Pi for this purpose.

Now you're ready to explore MicroPython programming on microcontrollers.

[Move on to the microcontroller labs](labs/index.md)
