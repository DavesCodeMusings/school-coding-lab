# Managing a Fleet of Raspberry Pis
This document shows how to manage multiple Raspberry Pi hosts in a lab installation. It relies on [Ansible automation](https://docs.ansible.com/ansible/latest/) on a Raspberry Pi configured as a WiFi access point to get the job done. You'll still have the task of flashing microSD cards using the Raspberry Pi Imager. But after that step, most everyting else is automated.

The steps in this document assume you are familiar with using the Raspberry Pi Imager to create a single Raspberry Pi running the latest version of Raspberry Pi OS.

## Understanding School Network Limitations
Internet access in schools is very different than the simple connection you experience at home or on your mobile phone. Quite often it will require an individual username and password to sign in. Many times, web sites we take for granted are blocked by web filters. Because of this, the School Coding Lab is designed to operate as an island, disconnected from the internet entirely.

## Creating a Lab Network
The first step in separating the lab from the school network is to create our own WiFi router. We'll create a device similar to what you might have at home, but instead of buying something from NetGear or TP-Link, we'll use a Raspberry Pi. This functionality is built into the latest version of Raspberry Pi OS and only requires a little bit of configuration to get it working.

The next step is to use the Raspberry Pi WiFi Access Point (herein lovingly referred to as PiFi) as a central place to manage our remaining Raspberry Pis with Ansible automation.

## Configuring the PiFi Access Point
We'll start with a Raspberry Pi 3 or better and flash it with Raspberry Pi OS Lite. We'll use a short shell script to install Ansible. Then, we'll use an Ansible Playbook to do the rest of the configuration.

### Creating the OS Image
Use Raspberry Pi Imager to prepare a microSD card with Raspberry Pi OS Lite (64-bit). This will be almost exactly like the [process of setting up a Raspberry Pi as a student developer workstation](https://davescodemusings.github.io/school-coding-lab/rpi/fresh_install.html), but it won't need to graphical desktop environment. So the Operating System selection will be different.

In place of Raspberry Pi OS (64-bit), you'll want to select _Raspberry Pi OS (other)_ and then choose _Raspberry Pi OS Lite (64-bit)_ from the sub-menu.

Continue on with the remaining steps and boot the Pi.

### First Login
When you've got the Pi attached to a monitor and keyboard, you won't see the familiar Raspberry Pi OS desktop. Instead you'll be looking at a text-based prompt asking you to log in. Use the username and password you set up in the Raspberry Pi Imager's option's General tab.

Once you've logged in, find the IP address with the command: `ifconfig wlan0`

Take note of the result.

```
pi login: admin
Password:

$ ifconfig wlan0
wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.116  netmask 255.255.255.0  broadcast 192.168.1.255
```
_Figure 1: An example of logging in to find an IP address of 192.168.1.116_

### Testing Secure Shell
Having you WiFi router attached to a monitor and keyboard is not the way it's usually done. Normally, access is through Secure Shell. Now that you know the IP address of the Pi, try connecting from another machine with an SSH client. Troubleshoot any problems before moving on.

```
> ssh admin@192.168.1.116
admin@192.168.1.116's password:
Linux pi3 6.6.20+rpt-rpi-v8 #1 SMP PREEMPT Debian 1:6.6.20-1+rpt1 (2024-03-07) aarch64

admin@pi:~ $
```
_Figure 2: A successful SSH connection_

### Attaching a USB Serial Console Cable
Secure Shell doesn't work if there's no IP address to connect to. This can happen if the machine is malfunctioning. Most of the time, you can hook up a monitor and keyboard to figure out what's wrong. But, the normal state of a WiFi Access Point is to operate without a monitor and keyboard.

To avoid being stuck with no access, Raspberry Pi OS has the ability to use a serial console. Adafruit has an excellent tutorial on [setting up a serial console on Raspberry Pi](https://learn.adafruit.com/adafruits-raspberry-pi-lesson-5-using-a-console-cable/).

You can skip the bits about using raspi-config or editing config.txt. The Ansible automation will take care of all these tasks. All you need to do is wire the cable and install drivers on the remote machine.

>If this sounds too complex and you want to just stick with using a monitor and keyboard in a pinch, that's fine too. However, the automation will still enable serial console regardless of it being wired or not. This will not cause a problem.

### Installing Ansible
The Ansible package is installed from the Raspberry Pi OS repository using a simple shell script you can find at:

https://github.com/DavesCodeMusings/school-coding-lab/blob/fleet/rpi/fleet/install_ansible.sh

1. Copy the contents of the script to your Raspberry Pi and save it as _install_ansible.sh_
2. Run the script with the command `bash install_ansible.sh`

See below for an example. 

```
admin@pi:~$ nano install_ansible.sh
admin@pi:~$ bash install_ansible.sh
Installing the Ansible automation software package.
```
