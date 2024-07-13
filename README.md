# School Coding Lab
_Creating a student development environment on the cheap!_

What you'll find here is a combination of documentation and code, and it's all about building a computing environment for hands-on learning.

* If you already have a development machine and some microcontrollers, go straight to [the microcontroller labs](https://davescodemusings.github.io/school-coding-lab/micropython/) and start coding.
* If you've got a box of donated Raspberry Pi parts and want to build a coding lab in your school, start with the [documentation](https://davescodemusings.github.io/school-coding-lab/) to discover how it all works.
* If you want to know why this repository exists, read about [my motivation](MOTIVATION.md).

Otherwise, read on to find out more about the project.

## What is it?
With a Raspberry Pi 3 or better and an inexpensive ESP32C3 microcontroller, this project aims to build a self-contained, easy to use coding lab suitible for school maker spaces.

## How does it work?
A Raspberry Pi is configured as a WiFi access point. Students attach to it like any guest network. But, with the Raspberry Pi access point, there's no connection to the internet. Instead, it's preloaded development tools like Python and Visual Studio Code. There are also tools for running MicroPython programs on ESP32 microcontrollers, as well as code samples and lab manuals for MicroPython development. Students are able to code in a safe environment that won't run afoul of school network access restrictions.

## Okay, but what about some technical details?
For those wanting to set this up, here's what you're in for:
* [Ansible](https://docs.ansible.com/ansible/latest/index.html) automation is used to take a stock [Raspberry Pi OS Lite](https://www.raspberrypi.com/software/) installation and configure it quickly and easily.
* [MicroPython](https://docs.micropython.org/en/latest/reference/) tools are installed to manage coding on [ESP32 miscrocontrollers](https://www.espressif.com/en/products/socs/esp32).
* [Visual Studio Code](https://code.visualstudio.com/) is deployed in its web-based form using [Code Server](https://hub.docker.com/r/linuxserver/code-server) running in a Docker container.
* [Nginx](https://nginx.org/en/) web server is installed to host lab manuals locally.
* A [Network Manager](https://www.networkmanager.dev/) access point profile is configured to make each Raspberry Pi its own WiFi island.

## What about copying?
Documentation and code samples included in this repository are released to the public domain. Use, modify, or remix to your heart's content.

For the code-server-python Docker image available here, please refer to the following licensing:
* The [code-server license](https://github.com/coder/code-server/blob/main/LICENSE)
* The [Python license](https://docs.python.org/3/license.html)

While both code-server and Python are open-source licenses, they are not public domain.
