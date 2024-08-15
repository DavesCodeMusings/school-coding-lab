#!/bin/bash

###
### Non-interactive configuration of Raspberry Pi workstation.
###

# Shell script and Ansible playbooks in the order they should be run.
AUTOMATION_LIST="
  install_ansible.sh
  install_system_services.yml
  configure_users.yml
  install_dev_software.yml
  download_code_samples.yml
  install_web_server.yml
  download_lab_guides.yml
  install_docker.yml
  deploy_code_server.yml
  configure_access_point.yml
"
BASE_URL="https://raw.githubusercontent.com/DavesCodeMusings/school-coding-lab/main/rpi/fleet-automation"

# Function to download something from the web and save it locally.
# For example: 'download https://www.gnu.org/software/bash/manual/bash.txt'
download () {
  test -z $1 && exit 1
  SAVE_AS=$(basename $1)
  wget -O $SAVE_AS $1
  if [ $? -ne 0 ]; then
    echo "ERROR: Unable to download $SAVE_AS"
    echo "Are you connected to the internet?"
    exit 1
  fi
}

# Function to run an automation shell script or Ansible playbook.
# For example: 'run config.sh' or 'run configure_something.yml'
run () {
  test -z $1 && exit 2
  EXTENSION=${FILE##*.}
  if [ "$EXTENSION" == "sh" ]; then
    bash $FILE
    if [ $? -ne 0 ]; then
      echo "ERROR: Shell script $FILE had a problem."
      exit 2
    fi
  elif [ "$EXTENSION" == "yml" ]; then
    ansible-playbook $FILE
    if [ $? -ne 0 ]; then
      echo "ERROR: Ansible playbook $FILE had a problem."
      exit 2
    fi
  else
    echo "ERROR: Unrecognized automation file type: $FILE"
  fi
}


# Fetch the playbooks from the GitHub repository as a first step. If there
# are problems dowloading, the script will stop here before making changes.
for FILE in $AUTOMATION_LIST; do
  echo "INFO: Downloading automation script: $FILE"
  download $BASE_URL/$FILE
done

# Get hostname from script parameter or create one based on CPU serial number
# and export as an environment variable for use by automation scripts.
if [ "$1" != "" ]; then
  HOSTNAME=$1
else
  UNIQUE_ID=$(awk -F: '/Serial/ { print substr($NF, length($NF)-5, 6) }' /proc/cpuinfo)
  HOSTNAME="pi-$UNIQUE_ID"
fi
echo "INFO: Using $HOSTNAME as the name for this Raspberry Pi."
export HOSTNAME

# Run the automation.
for FILE in $AUTOMATION_LIST; do
  echo "INFO: Running automated configuration task: $FILE"
  run $FILE
done

echo "INFO: System restart."
echo -n "Everything is done but the reboot. Restart now [y/N]? "
read REPLY
if [ "$REPLY" == "Y" ] || [ "$REPLY" == "y" ]; then
  sudo shutdown -r now
fi
