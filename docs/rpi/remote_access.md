# Accessing Your Raspberry Pi from Another Machine
Most of the time, you'll use a keyboard, mouse and monitor to access the Raspberry Pi computer you're using. But, you don't have to. You can also interact with it using a remote access client. We'll look at two methods of remote access, Virtual Network Computing (VNC) and Secure Shell (SSH).

## Finding Your Raspberry Pi's IP Address
No matter which remote access method you choose, you'll need to know how to find your Raspberry Pi on the network. For this, you'll need its IP address. Advanced users can use the command `ifconfig` or `ip addr` in a terminal window to find the IP address. But the easy way is to simply hover the mouse pointer over the up/down arrow in the upper right corner of the Raspberry Pi OS desktop.

___

![IP Address](../images/IP_Address.png)
 
_Figure 1: IP Address Shown on Raspberry Pi OS Desktop_

___

## Using VNC to Access Your Desktop
The advantage of VNC is, it's nearly identical to the experience of sitting in front of your monitor and keyboard. The drawback is, it requires a VNC client to be installed on the computer you want to use to access the Raspberry Pi. On Windows, Mac, or Linux, you can install VNC Viewer from RealVNC to access your Raspberry Pi. If you're using a Chromebook, you're out of luck.

>Technically, you can use Chromebook's Linux Mode to install a Linux-based VNC client, but if you had access to Linux Mode on your Chromebook, you probably wouldn't be building a Raspberry Lab.

To access your Raspberry Pi with VNC, you'll need to enable the VNC server on your Pi first.
1. Open a terminal window.
2. Type the command: `sudo raspi-config` and hit Enter.
3. Choose _Interface Options_
4. Choose _VNC_
5. Say _Yes_ to enable.

VNC can use a different screen size than your regular monitor, if you want. If you find text and icons are too small to be legible when accessing the Pi desktop through VNC, change the _VNC Resolution_ under _Display Options_ in raspi-config.

## Using Secure Shell to Access a Terminal
The terminal window we've been using so much in the set up of your Raspberry Pi is also available remotely. It's more primative, with no graphical desktop, but the advantage is access via Secure Shell almost always works.

Almost.

Like VNC, you'll need a client program to access your Raspberry Pi via Secure Shell. With Windows, Linux, and Mac machines, this capability is built into the operating system. Just open a terminal window and type `ssh <IP_ADDRESS>`; where <IP_ADDRESS> is replaced by the actual IP address of your Raspberry Pi.

On Chromebooks with restricted Linux Mode, things are more difficult. (Are you sensing a theme here?) For Chromebooks, Secure Shell is only available when you have Linux Mode access. To work around this limitation, we'll need to make SSH available through a web browser. This is covered next.

>If you used the Raspberry Pi Imager to write your Micro SD card and checked the box for Enable SSH on the Services tab of OS Customization, Secure Shell server is already running on the Pi. If you skipped this step, use `sudo raspi-config` and look under _Interface Options_ for _SSH_ and activate it there.

## Secure Shell in a Web Browser
With the help of some software on the Raspberry Pi, you can access Secure Shell in a browser tab. Even Chromebooks will let you use a web browser, so this should give you remote access to your Raspberry Pi, just without the graphical desktop.

The software package that enables Secure Shell in a browser is called _shellinabox_ and it can be installed with the command `sudo apt-get install shellinabox`.

Once it's installed, it should start up automatically and you can access Secure Shell using a web browser address similar to:

```
https://<IP_ADDRESS>:4200
```

Be sure to replace <IP_ADDRESS> with the actual IP address of your Raspberry Pi, but keep the :4200 part as-is.

When you press Enter, you'll be asked for a username and password. Once you're logged in, your browser will look similar to the screenshot below.

___

![Shell in a Box](../images/Shell_in_a_box.png)

_Figure 2: Shell in a Box, in a Browser_

___

## Next Steps
Remote access is handy for running administrative tasks without having to be sitting at the machine. With Secure Shell access to the Raspberry Pi, you also have the option of automating system tasks from a central management machine. This is an advanced topic, but is worth learning if you're trying to manage more than a handful of Raspberry Pis. If you're interested, take a look at [Ansible Community Edition](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).
