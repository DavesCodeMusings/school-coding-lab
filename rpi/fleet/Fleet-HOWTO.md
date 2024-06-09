# Managing a Fleet of Raspberry Pis
This document shows how to manage multiple Raspberry Pi hosts in a lab installation. It relies on [Ansible automation](https://docs.ansible.com/ansible/latest/) on a Raspberry Pi configured as a WiFi access point to get the job done. You'll still have the task of flashing microSD cards using the Raspberry Pi Imager. But after that step, most everyting else is automated.

The steps in this document assume you are familiar with using the Raspberry Pi Imager to create a single Raspberry Pi running the latest version of Raspberry Pi OS.

## Understanding School Network Limitations
Internet access in schools is very different than the simple connection you experience at home or on your mobile phone. Quite often it will require an individual username and password to sign in. Many times, web sites we take for granted are blocked by web filters. Because of this, the School Coding Lab is designed to operate as an island, disconnected from the internet entirely.

## Creating an Isolated Lab Network
The first step in separating the lab from the school network is to create our own WiFi router. We'll create a device similar to what you might have at home, but instead of buying something from NetGear or TP-Link, we'll use a Raspberry Pi. This functionality is built into the latest version of Raspberry Pi OS and only requires a little bit of configuration to get it working.

The next step is to use the Raspberry Pi WiFi Access Point (herein lovingly referred to as PiFi) as a central place to manage the remaining Raspberry Pis in our fleet with Ansible automation.

## Configuring the PiFi Access Point
We'll start with a Raspberry Pi 3 or better and flash it with Raspberry Pi OS Lite. We'll use a short shell script to install Ansible. Then, we'll use an Ansible Playbook to do the rest of the configuration.

### Creating the OS Image
Use Raspberry Pi Imager to prepare a microSD card with Raspberry Pi OS Lite (64-bit). This will be almost exactly like the [process of setting up a Raspberry Pi as a student developer workstation](https://davescodemusings.github.io/school-coding-lab/rpi/fresh_install.html), but it won't need to graphical desktop environment. So the Operating System selection will be different.

In place of Raspberry Pi OS (64-bit), you'll want to select _Raspberry Pi OS (other)_ and then choose _Raspberry Pi OS Lite (64-bit)_ from the sub-menu.

___

![Raspberry Pi OS Lite](Imager%20Choose%20OS%20Lite.png)

_Figure 1: Choosing Raspberry Pi OS Lite in Raspberry Pi Imager_

___

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
_Figure 2: An example of logging in to find an IP address of 192.168.1.116_

### Testing Secure Shell
Having you WiFi router attached to a monitor and keyboard is not the way it's usually done. Normally, access is through Secure Shell. Now that you know the IP address of the Pi, try connecting from another machine with an SSH client. Troubleshoot any problems before moving on.

```
> ssh admin@192.168.1.116
admin@192.168.1.116's password:
Linux pi3 6.6.20+rpt-rpi-v8 #1 SMP PREEMPT Debian 1:6.6.20-1+rpt1 (2024-03-07) aarch64

admin@pi:~ $
```
_Figure 3: A successful SSH connection_

### Attaching a USB Serial Console Cable
Secure Shell doesn't work if there's no IP address to connect to. This can happen if the machine is malfunctioning. Most of the time, you can hook up a monitor and keyboard to figure out what's wrong. But, the normal state of a WiFi Access Point is to operate without a monitor and keyboard.

To avoid being stuck with no access, Raspberry Pi OS has the ability to use a serial console. Adafruit has an excellent tutorial on [setting up a serial console on Raspberry Pi](https://learn.adafruit.com/adafruits-raspberry-pi-lesson-5-using-a-console-cable/).

**Be safe and power down the Pi before attaching the cable!**

You can skip the bits about using raspi-config or editing config.txt. The Ansible automation will take care of all these tasks. All you need to do is wire the cable and install drivers on the remote machine.

>If this sounds too complex and you want to just stick with using a monitor and keyboard in a pinch, that's fine too. However, the automation will still enable serial console regardless of it being wired or not. This will not cause a problem.

### Installing Ansible
The Ansible package is installed from the Raspberry Pi OS repository using a simple shell script you can find at:

https://github.com/DavesCodeMusings/school-coding-lab/blob/fleet/rpi/fleet/install_ansible.sh

1. Copy the contents of the script to your Raspberry Pi and save it as _install_ansible.sh_
2. Run the script with the command `bash install_ansible.sh`

See below for an example. 

```
admin@pi:~$ wget https://raw.githubusercontent.com/DavesCodeMusings/school-coding-lab/main/rpi/fleet/install_ansible.sh
admin@pi:~$ bash install_ansible.sh
Installing the Ansible automation software package...
```
_Figure 4: Installing Ansible with the script_

### Setting Up the Pi as an Access Point
This part involves several steps. They are all automated by Ansible. However, there is a reboot in the middle of set-up. So you will need to log in and run the automation twice.

The example below shows how to run it.

```
admin@pi:~$ wget https://raw.githubusercontent.com/DavesCodeMusings/school-coding-lab/main/rpi/fleet/configure_wifi_ap.yml
admin@pi:~$ ansible-playbook configure_wifi_ap.yml
```
_Figure 5: Running the Ansible playbook_

Here's an example of what you will see for the first run:

```
admin@pi:~$ ansible-playbook configure_wifi_ap.yml
[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that
the implicit localhost does not match 'all'

PLAY [Configure Raspberry Pi as WiFi Access Point] *****************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]

TASK [Enable serial console] ***************************************************
changed: [localhost]

TASK [Shutdown for switchover to serial console] *******************************

Broadcast message from root@pi3 on pts/1 (Sun 2024-06-09 10:13:41 CDT):

The system will power off now!
```
_Figure 5: Running up until system shutdown for attaching serial cable_

At this point, the system will restart and you'll need to log in again. Serial console will be available, so use that if you've wired the cable to the GPIO header. You may need to tap Enter once or twice to get a login prompt. This is normal with serial consoles.

After logging in and running the automation a second time, you'll see something like this:

```
$ ansible-playbook configure_wifi_ap.yml
[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that
the implicit localhost does not match 'all'

PLAY [Configure Raspberry Pi as WiFi Access Point] *****************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]

TASK [Enable serial console] ***************************************************
ok: [localhost]

TASK [Shutdown for switchover to serial console] *******************************
skipping: [localhost]

TASK [Update apt cache] ********************************************************
ok: [localhost]

TASK [Install web-based Secure Shell] ******************************************
changed: [localhost]

TASK [Install web server] ******************************************************
changed: [localhost]

TASK [Set up WiFi access point connection] *************************************
changed: [localhost]

TASK [Delete WiFi station connection] ******************************************
changed: [localhost]

TASK [Set hostname to match SSID] **********************************************
changed: [localhost]

TASK [Restart to activate changes] *********************************************

Broadcast message from root@pi3 on pts/0 (Sun 2024-06-09 10:17:01 CDT):

The system will reboot now!
```
_Figure 6: Continuing with WiFi access point setup_

After this second restart, you'll no longer be able to use the old IP address for Secure Shell. This is where the serial cable (or alternatively, a monitor and keyboard) is handy.

Power up the Pi, log in, and get the new IP address as shown below.

```
pifi login: admin
Password:
Linux pifi 6.6.20+rpt-rpi-v8 #1 SMP PREEMPT Debian 1:6.6.20-1+rpt1 (2024-03-07) aarch64

admin@pifi:~$ ifconfig wlan0
wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.42.0.1  netmask 255.255.255.0  broadcast 10.42.0.255
```
_Figure 7: The Pi's new IP address_

## Testing the PiFi Access Point Functionality
To make sure everything is working as expected, let's take a quick look at what you can and cannot do on a this isolated student network.

First connect a Chromebook, Windows, Mac, or Linux laptop to the PiFi access point. How you do this depends on your particular device, but it's usually a matter of selecting the access point name (PiFi) from a list and entering the default password (P@ssw0rd) to get connected.

>If you're wondering where the name and password came from, take a look toward the top of _configure_wifi_ap.yml_ in the _vars:_ section.

It might take a second to get connected. And your laptop might complain that there's no internet access. This is by design. We are creating an isolated network.

Once connected, get the IP address assigned to your Chromebook or laptop. On Windows, it looks similar to this:

```
PS > ipconfig | findstr "IPv4"
   IPv4 Address. . . . . . . . . . . : 10.42.0.66
```
_Figure 8: Finding the Windows client IP address_

If your remote computer shows a WiFi connection and an IP address, things are working great.

## Testing Connection to the PiFi's Raspberry Pi OS
There are several ways to access the Raspberry Pi serving as a WiFi access point. Normally, you'll only need to do this when performing maintenance, but it's good to test now.

Of all the options, only the USB serial cable will work all the time. The other methods require you to first connect to the PiFi network.

Try each of the following to make sure they work from your remote device:

1. Secure Shell from a command prompt. (i.e. `ssh admin@10.42.0.1`)
2. Secure Shell from the browser (i.e. `http:\\10.42.0.1:4200`)
3. Serial console with the USB to serial cable.

Note anything not working and troubleshoot as needed.

## Testing the PiFi Web Server
One of the steps in the the Ansible automation involves installing a web server called Nginx (pronounced engine-X). This is not a requirement for WiFi access point functionality, but it can be useful for distributing files.

Test it by going to `http://10.42.0.1` in a web browser on any machine connected to the PiFi network. You should see a message that says, _Welcome to nginx!_"

```
Welcome to nginx!

If you see this page, the nginx web server is successfully installed and working. Further configuration is required.

For online documentation and support please refer to nginx.org.
Commercial support is available at nginx.com.

Thank you for using nginx.
```
_Figure 9: Nginx test page_

## Connecting Your Fleet of Student Developer Workstations
With the PiFi access point now up and running, you can begin changing the WiFi connections for the rest of the Raspberry Pis to use the PiFi SSID and password. This will ensure the Raspberry Pis can interact with each other, but not connect to sites outside of the classroom.

With Ansible installed on the PiFi device and all of the student workstations connected to it, you can automate any changes that need to be made. But there are some limitations due to not being connected to the internet. This deficit is particuarly evident when trying to install software packages from Raspberry Pi OS repositories.

## Next Steps: Automation
Another glaring limitation of an isolated network is having to use IP addresses all the time instead of names like we're used to. To remedy this, we can use a centralized list of hostname to IP address associations, called a _hosts_ file. One of the first automation tasks is to make sure all the Raspberry Pis have the same copy of the hosts file.
