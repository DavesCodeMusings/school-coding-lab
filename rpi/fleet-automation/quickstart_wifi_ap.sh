#!/bin/bash

# Download and run automation for creating a wireless access point.

check_download_error () {
  if [ $1 != 0 ]; then
    echo "Something went wrong. Are you connected to the internet?"
  fi
}

wget -O install_ansible.sh https://github.com/DavesCodeMusings/school-coding-lab/raw/main/rpi/fleet/install_ansible.sh
check_download_error $?

wget -O configure_wifi_ap.yml https://github.com/DavesCodeMusings/school-coding-lab/raw/main/rpi/fleet/configure_wifi_ap.yml
check_download_error $?

bash install_ansible.sh

ansible-playbook configure_wifi_ap.yml

echo -n "Everything is done but the reboot. Restart now [y/N]? "
read REPLY
if [ "$REPLY" == "Y" ] || [ "$REPLY" == "y" ]; then
  sudo shutdown -r now
fi
