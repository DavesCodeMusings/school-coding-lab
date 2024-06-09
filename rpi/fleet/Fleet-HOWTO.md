# Managing a Fleet of Raspberry Pis
This document shows how to manage multiple Raspberry Pi hosts in a lab installation. It relies on [Ansible automation](https://docs.ansible.com/ansible/latest/) on a Raspberry Pi configured as a WiFi access point to get the job done. You'll still have the task of flashing microSD cards using the Raspberry Pi Imager. But after that step, most everyting else is automated.

The steps in this document assume you are familiar with using the Raspberry Pi Imager to create a single Raspberry Pi running the latest version of Raspberry Pi OS.

## Understanding School Network Limitations
Internet access in schools is very different than the simple connection you experience at home or on your mobile phone. Quite often it will require an individual username and password to sign in. Many times, web sites we take for granted are blocked by web filters. Because of this, the School Coding Lab is designed to operate as an island, disconnected from the internet entirely.

## Creating a Lab Network
The first step in separating the lab from the school network is to create our own WiFi router. We'll create a device similar to what you might have at home, but instead of buying something from NetGear or TP-Link, we'll use a Raspberry Pi. This functionality is built into the latest version of Raspberry Pi OS and only requires a little bit of configuration to get it working.

The next step is to use the Raspberry Pi WiFi Access Point (herein lovingly referred to as PiFi) as a central place to manage our remaining Raspberry Pis with Ansible automation.

## Configuring the PiFi Access Point

