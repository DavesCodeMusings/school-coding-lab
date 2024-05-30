**Work in Progress**

_VS Code extension are not working properly on non-x86 hardware like Raspberry Pi, so none of this will work until that's sorted._

# Installing Visual Studio Code
Part of what makes Visual Studio Code so popular is its ability to run add-ons called extensions. So in addition to installing VS Code, this document will detail how to install two extensions: one for MicroPython, and the other for ESP32 microcontrollers.

There is quite a bit of work to do to get everything installed and going, so take a moment to ponder how much you love VS Code or if Thonny might be "good enough".

If you decide to proceed, all of this is done from a command prompt in a terminal window (or a Secure Shell session.)

## Make sure your system is up-to-date
If you haven't installed operating system updates recently, do that now to make sure your OS is running its latest patches.
After installing updates, a reboot will ensure all the latest versions are running. The example below shows how.

```
$ sudo apt-get update
Reading package lists... Done

$ sudo apt-get upgrade
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Calculating upgrade... Done

$ sudo shutdown -r now
The system will reboot now!
```

> Note: some of the output has been trimmed for brevity

## Install VS Code
The process for installing Visual Studio Code is very similar to installing operating system updates. But rather than the _upgrade_ keyword, you use _install_ and the name of the software package. In this case it's _code_. So the command is: `sudo apt-get install code`

After a bit of text flying by, you'll get the $ prompt back and VS Code is installed. But, don't exit the terminal window yet. There's more work to be done.

## Installing Extensions
There are two extension that will make your ESP32 MicroPython programming life easier. These are: MPRemote and ESPTool. Both are from the publisher DavesCodeMusings.

Visual Studio Code extensions can be installed from inside the VS Code application, but they can also be installed from a command prompt. The command prompt method is shown below.

```
$ code --install-extension DavesCodeMusings.MPRemote
Installing extensions...
Installing extension 'davescodemusings.mpremote'...
Extension 'davescodemusings.mpremote' v1.21.11 was successfully installed.

$ code --install-extension DavesCodeMusings.ESPTool
Installing extensions...
Installing extension 'davescodemusings.esptool'...
Extension 'davescodemusings.esptool' v1.2.0 was successfully installed.

$ code --list-extensions
davescodemusings.esptool
davescodemusings.mpremote
```

## Installing Extension Dependencies
The extension by themselves won't do anything without the similarly named Python packages being available. These are installed with a Python tool called pipx. The procedure is shown below.

```
$ sudo apt-get install pipx
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Do you want to continue? [Y/n] y

$ pipx install mpremote
  installed package mpremote 1.22.0, installed using Python 3.11.2
  These apps are now globally available
    - mpremote

$ pipx install esptool
  installed package esptool 4.7.0, installed using Python 3.11.2
  These apps are now globally available
    - esp_rfc2217_server.py
    - espefuse.py
    - espsecure.py
    - esptool.py

$ pipx ensurepath
Success!
```

At this point, you need to log out of your session or reboot the Raspberry Pi for changes to take effect. If you choose to reboot, remember the command is: `sudo shutdow -r now`

## Testing
Log into your Pi and run VS Code from the application menu.
