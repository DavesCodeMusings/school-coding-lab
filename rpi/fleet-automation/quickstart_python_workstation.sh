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

echo "Configuring for Python and MicroPython development work."
download https://raw.githubusercontent.com/DavesCodeMusings/school-coding-lab/main/rpi/fleet-automation/install_ansible.sh
download https://raw.githubusercontent.com/DavesCodeMusings/school-coding-lab/main/rpi/fleet-automation/configure_python_workstation.yml
download https://raw.githubusercontent.com/DavesCodeMusings/school-coding-lab/main/rpi/fleet-automation/deploy_code_server.yml
download https://raw.githubusercontent.com/DavesCodeMusings/school-coding-lab/main/rpi/fleet-automation/download_code_samples.yml
bash ./install_ansible.sh
ansible-playbook ./configure_python_workstation.yml
ansible-playbook ./deploy_code_server.yml
ansible-playbook ./download_code_samples.yml

echo -n "Everything is done but the reboot. Restart now [y/N]? "
read REPLY
if [ "$REPLY" == "Y" ] || [ "$REPLY" == "y" ]; then
  sudo shutdown -r now
fi
