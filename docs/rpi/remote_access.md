# Accessing Your Raspberry Pi from Another Machine
Most of the time, you'll use a keyboard, mouse and monitor to access the computer you're using. But, you don't have to. You can also interact with a computer like the Raspberry Pi using a remote access client. We'll look at two methods of remote access, Virtual Network Computing (VNC) and Secure Shell (SSH).

## Using VNC to Access Your Desktop
The advantage of VNC is, it's nearly identical to the experience of sitting in front of you monitor and keyboard. The drawback is, you need a VNC client installed on the computer you want to use to access the Raspberry Pi.

On Windows, you can install VNC Viewer from RealVNC to access your Raspberry Pi. If you're using a Chromebook, you're out of luck. Technically, you can use Chromebook's Linux Mode to install a VNC client, but if you had access to Linux Mode on your Chromebook, you probably wouldn't be building a Raspberry Lab.

To use VNC on your Raspberry Pi, you'll need to enable it first.
1. Open a terminal window.
2. Type the command: `sudo raspi-config` and hit Enter.
3. Choose _Interface Options_
4. Choose _VNC_
5. Say _Yes_ to enable.

> Note: VNC can use a different screen size than your regular monitor. To change it, use `sudo raspi-config` look under _Display Options_.

## Using Secure Shell to Access a Terminal
The terminal window we've been using so much in the set up of your Raspberry Pi is also available remotely. It's more primative with no graphical desktop, but it does offer some flexibility. One big advantage is using a web-based Secure Shell terminal.

