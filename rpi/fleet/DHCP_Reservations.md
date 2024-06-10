# DHCP Reservations
Having to use an IP address to access the Raspberry Pis on the network is tedious. Not knowing which Pi has a particular IP address at any given moment makes it even worse. 
The first step to making the situation better is to ensure each Raspberry Pi always gets the same IP address.

This is done using [DHCP reservations](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol).

The DHCP server used for the Raspberry Pi OS WiFi access point is called dnsmasq. In this document, we'll look at how to configure dnsmasq to honor DHCP reservations and give each host the same IP address every time.

## Finding the Configuration Directory
Looking at how the dnsmasq service is running will give us some clues how to configure it.

Start by examining the options used with dnsmasq.

```
admin@pifi:~# ps -ef | grep dnsmasq
nobody       681     503  0 19:22 ?        00:00:00 /usr/sbin/dnsmasq --conf-fil
e=/dev/null --no-hosts --keep-in-foreground --bind-interfaces --except-interface
=lo --clear-on-reload --strict-order --listen-address=10.42.0.1 --dhcp-range=10.
42.0.10,10.42.0.254,60m --dhcp-leasefile=/var/lib/NetworkManager/dnsmasq-wlan0.l
eases --pid-file=/run/nm-dnsmasq-wlan0.pid --conf-dir=/etc/NetworkManager/dnsmas
q-shared.d
```

What can we tell from this? Some highlights include:
1. --conf-file; It's set to dev/null, so there's no configuration file being used.
2. --listen-address; This is the IP address for our host's wifi (wlan0).
3. --dhcp-range; These are the IPs being assigned to clients.
4. --dhcp-leasefile; This is where connected clients are recorded.
5. --conf-dir; This is where configuration changes can be made.

All of these options are controlled by NetworkManager and are not easy to override. Though most are fine for purposes of a small-time isolated school lab.

The last option, --conf-dir, gives the location of a directory where configuration will be loaded from.

## Finding the Available Options
Searching the internet brings up a pretty good guide to configuring dnsmasq over at [HowToGeek](https://www.howtogeek.com/devops/how-to-run-a-local-network-dhcp-server-with-dnsmasq/). Most of it can be glossed over, because dnsmasq is already configured on our system. We just want to know how to do DHCP reservations.

Reservations are covered in the section entitled _Setting Up Static IPs_. Skipping down to the relevant information shows the following configuration line:

```
dhcp-host=ab:cd:ef:12:34:56,example-host,192.168.0.10,infinite
```

Adjusting this to our purposes might look something like this:

```
dhcp-host=ab:cd:ef:12:34:56,rpi03,10.42.0.11,infinite
```

This will tell dnsmasq to always assign the IP address of 10.42.0.11 to rpi03, whose hardware address is ab:cd:ef:12:34:56.

Great. So what is this hardware address and where does it come from?

## Finding the MAC Address
The terms _hardware address_ and _Media Access Control (MAC) address_ are synonymous. The address they refer to is nearly always expressed as six pairs of two-digit hexadecimal numbers separated by colons or dashes. That makes it pretty easy to spot.

Look at the information for the wireless adapter found in the output of `ifconfig wlan0` below.

```
admin@pifi:~$ ifconfig wlan0
wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.42.0.1  netmask 255.255.255.0  broadcast 10.42.0.255
        inet6 fe80::f4d3:4ebd:9ed6:3a11  prefixlen 64  scopeid 0x20<link>
        ether b8:27:eb:05:d5:64  txqueuelen 1000  (Ethernet)
        RX packets 440  bytes 34679 (33.8 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 330  bytes 27871 (27.2 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

The line starting with _ether_ is followed by six pairs of two-digit hexadecimal numbers. That's the MAC address.

## Putting It All Together
We have the dnsmasq configuration directory. We have the format for adding a reservation. We even have the MAC address for the host we want to reserve an IP address for. Now it's time to configure dnsmasq.

The steps are as follows:
1. Change directory to /etc/NetworkManager/dnsmasq-shared.d
2. Creae a new file called _reservations_
3. Add a line in the correct format and save the file.

All of this will need to be done as the root user. Here's how:

```
admin@pifi:~$ sudo su -
root@pifi:~# cd /etc/NetworkManager/dnsmasq-shared.d/
root@pifi:/etc/NetworkManager/dnsmasq-shared.d# nano reservations
```

Start with _dhcp-host=_ then add the following comma-separated values:
1. The MAC address for your host
2. Its hostname
3. An address in the dhcp range (e.g. 10.42.0.11)
4. And finally the lease time of _infinite_

Save this file. Then, verify it looks like the example below.

```
root@pifi:/etc/NetworkManager/dnsmasq-shared.d# cat reservations
dhcp-host=2d:ec:af:c0:ff:ee,stemmy,10.42.0.34,infinite
```

## Reboot and Test
dnsmasq won't pick up the new configuration until it's restarted. The easiest way to do this is simply rebooting the PiFi access point.

```
admin@pifi:~$ sudo shutdown -r now
The system will reboot now!
```

Once the PiFi is back up and running, try connecting with the client that has a reservation. If you don't get the reserved IP address right away, don't panic. It might be waiting for an old one to expire and this can take up to an hour with the way dnsmasq is configured.

## Next Steps
Once one host is getting its reserved address, follow the same procedure to add a line for each remaining Pi on your network.
