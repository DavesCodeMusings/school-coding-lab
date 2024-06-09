echo "Checking for Ansible."
if [ "$(command -v ansible-playbook)" == "" ]; then
  echo "Installing the Ansible automation software package..."
  sudo apt-get update && sudo apt-get install -y ansible
else
  echo "Ansible is already installed. Nice!"
fi
