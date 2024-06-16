# Creating an Isolated Lab Network
Internet access in schools is very different than the simple connection you experience at home or on your mobile phone. Quite often it will require an individual username and password to sign in. Many times, web sites we take for granted are blocked by web filters. Because of this, the School Coding Lab is designed to operate as an island, disconnected from the internet entirely.

The steps in this document assume you are familiar with using the Raspberry Pi Imager to create a single Raspberry Pi running the latest version of Raspberry Pi OS.

## Understanding the Raspberry Pi as a WiFi Access Point
When it comes to computing power, the WiFi router in your home is not much different than a Raspberry Pi. Because the Raspberry Pi has WiFi built in, it's pretty easy to turn one into your own short-range WiFi access point. The key difference is, our Raspberry Pi won't provide a connection to the internet. It will only be for our lab devices.

We'll start with a Raspberry Pi 3 or better and a fresh copy of Raspberry Pi OS Lite. Then, we'll use some automation to do the rest of the configuration.

> &#128161; The smaller, cheaper Raspberry Pi Zero 2 W can also makes an excellent WiFi access point.

### Creating the OS Image
Use Raspberry Pi Imager to prepare a microSD card with Raspberry Pi OS Lite (64-bit). This will be almost exactly like the [process of setting up a Raspberry Pi as a student developer workstation](https://davescodemusings.github.io/school-coding-lab/rpi/fresh_install.html), but it won't need a graphical desktop environment. So the Operating System selection will be different.

In place of Raspberry Pi OS (64-bit), you'll want to select _Raspberry Pi OS (other)_ and then choose _Raspberry Pi OS Lite (64-bit)_ from the sub-menu.

___

![Raspberry Pi OS Lite](../../images/Imager%20Choose%20OS%20Lite.png)

_Figure 1: Choosing Raspberry Pi OS Lite in Raspberry Pi Imager_

___

Continue on with the remaining steps in the [first-time setup  document](https://davescodemusings.github.io/school-coding-lab/rpi/fresh_install.html) and boot the Pi.

### First Login
When you've got the Pi attached to a monitor and keyboard, you won't see the familiar Raspberry Pi OS desktop. Instead you'll be looking at a text-based prompt asking you to log in. Use the username and password you set up in the Raspberry Pi Imager's option's General tab.

> &#128338; The first boot takes about three minutes. The Raspberry Pi logo will show on the monitor a few times during the process.

Once you've logged in, find the IP address of the Pi with the command: `ifconfig wlan0`

Take note of the result.

Below is an example how it might look on the monitor.

```
pi login: admin
Password:

$ ifconfig wlan0
wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.116  netmask 255.255.255.0  broadcast 192.168.1.255
```
_Figure 2: An example of logging in to find an IP address of 192.168.1.116_

### Logging in with Secure Shell
Having you WiFi router attached to a monitor and keyboard is not the way things are usually done. Normally, access is over the network from a laptop or PC. Now that you know the IP address of the Pi, try connecting from another machine's command prompt. Troubleshoot any problems before moving on.

An example is shown below.

```
PS C:\> ssh admin@192.168.1.116
admin@192.168.1.116's password:
Linux pi3 6.6.20+rpt-rpi-v8 #1 SMP PREEMPT Debian 1:6.6.20-1+rpt1 (2024-03-07) aarch64

admin@pi:~ $
```
_Figure 3: A successful SSH connection to Raspberry Pi from Windows_

After logging in, you're ready to start configuring the Pi as a WiFi access point.

### Setting Up the Pi as an Access Point
The setup process is automated just like the Raspberry Pi developer workstation. However, it will shut down the system before setup is complete. This is so you can disconnect power and attach a USB serial cable.

The automation script for creating a Raspberry Pi WiFi access point is available from:

[https://github.com/DavesCodeMusings/school-coding-lab/raw/main/rpi/fleet/quickstart_wifi_ap.sh](https://github.com/DavesCodeMusings/school-coding-lab/raw/main/rpi/fleet/quickstart_wifi_ap.sh)

The example below shows how to run the automated setup.

```
admin@pi:~$ wget https://github.com/DavesCodeMusings/school-coding-lab/raw/main/rpi/fleet/quickstart_wifi_ap.sh
admin@pi:~$ bash ./quickstart_wifi_ap.sh
```
_Figure 4: Running the automated script_

Below is some of the output you will see during the first run. Many lines have been trimmed for brevity.

```
admin@pi:~ $ bash ./quickstart_wifi_ap.sh
Checking for Ansible.
Installing the Ansible automation software package...
...
Unpacking ansible (7.3.0+dfsg-1) ...
...
Setting up ansible (7.3.0+dfsg-1) ...
...
[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that
the implicit localhost does not match 'all'

PLAY [Configure Raspberry Pi as WiFi Access Point] *****************************
...
TASK [Shutdown for switchover to serial console] *******************************

Broadcast message from root@pi on pts/1 (Sun 2024-06-16 09:47:47 CDT):

The system will power off now!
```

_Figure 5: Running up until system shutdown for attaching serial cable_

### Attaching the USB Serial Console Cable
Adafruit has an excellent tutorial on [setting up a serial console on Raspberry Pi](https://learn.adafruit.com/adafruits-raspberry-pi-lesson-5-using-a-console-cable/). You can skip the bits about using raspi-config or editing config.txt. The automation will take care of all these tasks. All you need to do is wire the cable and install drivers on the remote machine.

>If all this seems too complex and you want to just stick with using a monitor and keyboard, that's fine too. However, the automation will still enable serial console regardless of it being wired or not. This will not cause a problem.

**Be safe and unplug power from the Pi before attaching the serial cable!**

### Continuing Access Point Setup from the Serial Console
After attaching the serial cable, plug the USB end into your laptop and power up the Pi. The system will restart and you'll need to log in again. Serial console will be available, so use that to log in. You may need to tap Enter once or twice to get a login prompt. This is normal with serial consoles.

Once logged in, finish up the remaining tasks by running the automation script a second time using the same command as before: `bash ./quickstart_wifi_ap.sh`

```
pi login: admin
Password:
Linux pi3 6.6.20+rpt-rpi-v8 #1 SMP PREEMPT Debian 1:6.6.20-1+rpt1 (2024-03-07) aarch64

admin@pi:~ $ bash ./quickstart_wifi_ap.sh
```
_Figure 6: Running again after attaching the serial cable_

The second run should look something like this:

```
admin@pi:~$ bash ./quickstart_wifi_ap.sh
...
Checking for Ansible.
Ansible is already installed. Nice!
[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that
the implicit localhost does not match 'all'

PLAY [Configure Raspberry Pi as WiFi Access Point] *****************************
...
PLAY RECAP *********************************************************************
localhost                  : ok=21   changed=13   unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

Everything is done but the reboot. Restart now [y/N]? y

The system will reboot now!
```
_Figure 7: Continuing with WiFi access point setup_

After this second restart, you'll no longer be able to use the old IP address for Secure Shell. This is where the serial cable (or alternatively, a monitor and keyboard) is handy.

After the kernel debug messages roll by, log in and get the new IP address as shown below.

```
pifi login: admin
Password:
Linux pifi 6.6.20+rpt-rpi-v8 #1 SMP PREEMPT Debian 1:6.6.20-1+rpt1 (2024-03-07) aarch64

admin@pifi:~$ ifconfig wlan0
wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.42.0.1  netmask 255.255.255.0  broadcast 10.42.0.255
```
_Figure 8: The Pi's new IP address_

## Testing the PiFi Access Point Functionality
To make sure everything is working as expected, take a quick look at what you can and cannot do on a this isolated student network.

First connect a Chromebook, Windows, Mac, or Linux laptop to the PiFi access point. How you do this depends on your particular device, but it's usually a matter of selecting the access point name (PiFi) from a list and entering the default password (P@ssw0rd) to get connected.

>If you're wondering where the name and password came from, take a look toward the top of _configure_wifi_ap.yml_ in the _vars:_ section.

It might take a second to get connected. And your laptop might complain that there's no internet access. This is by design. We are creating an isolated network.

Once connected, the next task is to get the IP address assigned to your Chromebook or laptop. On Windows, it looks similar to this:

```
PS C:\> ipconfig | findstr "IPv4"
   IPv4 Address. . . . . . . . . . . : 10.42.0.66
```
_Figure 9: Finding the Windows client IP address_

If your remote computer shows an active WiFi connection and an IP address starting with the same three groups of numbers as the PiFi IP address, things are working great.

## Testing Logins to the PiFi's Raspberry Pi OS
There are several ways to access the Raspberry Pi serving as a WiFi access point. Normally, you'll only need to do this when performing maintenance, but it's good to ensure it works now.

Of all the options, only the USB serial cable will work all the time. The other methods depend on you first connecting to the PiFi network.

Try each of the following to make sure they work from your remote device:

1. Secure Shell from a command prompt. (i.e. `ssh admin@10.42.0.1`)
2. Secure Shell from the web browser. (i.e. `https:\\10.42.0.1:4200`)
3. Serial console with the USB to serial cable.

Note anything not working and troubleshoot as needed.

>Remember, for any method other than serial cable, the remote machine first needs to be attached to the PiFi access point.

## Connecting Your Student Developer Workstations
With the PiFi access point now up and running, you can begin changing the WiFi connections for the rest of the Raspberry Pis to use the PiFi SSID and password. This will ensure the Raspberry Pis can interact with each other, but not connect to sites outside of the classroom.

## Reconnecting to the Internet
With the PiFi in access point mode, there's no connection the the internet. This can cause a problem when trying to do things like installing new software.  But, the old _preconfigured_ connection set up by Raspberry Pi Imager still exists. If you need to switch back, you can. To see what mode you're in and switch between them, use the example commands shown below.

```
admin@pifi:~$ nmcli connection
NAME                UUID                                  TYPE      DEVICE
pifi                1413b9e8-9107-4abc-a781-80221325788b  wifi      wlan0
lo                  452ec766-f3b7-46bf-b8ea-9dfaa81a4e40  loopback  lo
preconfigured       56a42244-64c4-4249-bdd5-10a70c84b56c  wifi      --

admin@pifi:~$ sudo nmcli connection up preconfigured
Connection successfully activated

admin@pifi:~$ sudo nmcli connection up pifi
Connection successfully activated
```
_Figure 10: Switching WiFi connections_

## Next Steps
With the Raspberry Pi access point up and running, any labs involving WiFi can now connect to the PiFi.
