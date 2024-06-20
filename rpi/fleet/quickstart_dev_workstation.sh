#!/bin/bash

###
### Non-interactive configuration of Raspberry Pi workstation.
###

# Download something from the web and save it locally.
# For example: 'download https://www.gnu.org/software/bash/manual/bash.txt'
download () {
  test -z $1 && exit 1
  SAVE_AS=$(basename $1)
  wget -O $SAVE_AS $1
  if [ $? -ne 0 ]; then
    echo "Something went wrong. Are you connected to the internet?"
    exit 2
  fi
}

# Install differently depending on if system has a GUI desktop or not.
DEFAULT_TARGET=$(systemctl get-default)
if [ "$DEFAULT_TARGET" == "graphical.target" ]; then
  echo "Configuring for interactive desktop use."
  download https://github.com/DavesCodeMusings/school-coding-lab/raw/main/rpi/fleet/install_ansible.sh
  download https://github.com/DavesCodeMusings/school-coding-lab/raw/main/rpi/fleet/configure_gui_workstation.yml
  bash ./install_ansible.sh
  ansible-playbook ./configure_dev_workstation.yml
elif [ "$DEFAULT_TARGET" == "multi-user.target" ]; then
  echo "Configuring for web-based remote access."
  download https://github.com/DavesCodeMusings/school-coding-lab/raw/main/rpi/fleet/install_ansible.sh
  download https://github.com/DavesCodeMusings/school-coding-lab/raw/main/rpi/fleet/configure_web_workstation.yml
  bash ./install_ansible.sh
  ansible-playbook ./configure_web_workstation.yml
else
  echo "Unable to determine if system role is desktop or web-based."
  exit 3
fi

echo -n "Everything is done but the reboot. Restart now [y/N]? "
read REPLY
if [ "$REPLY" == "Y" ] || [ "$REPLY" == "y" ]; then
  sudo shutdown -r now
fi
