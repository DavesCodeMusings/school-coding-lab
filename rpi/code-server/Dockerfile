FROM lscr.io/linuxserver/code-server:latest
LABEL org.opencontainers.image.source = "https://github.com/DavesCodeMusings/school-coding-lab"
# Make the default 'abc' user name a little more friendly.
RUN sed -i -e 's/abc/student/g' /etc/passwd
RUN sed -i -e 's/abc/student/g' /etc/group
RUN sed -i -e 's/abc/student/g' /etc/s6-overlay/s6-rc.d/init-adduser/run
RUN sed -i -e 's/abc/student/g' /etc/s6-overlay/s6-rc.d/svc-code-server/run
RUN sed -i -e 's/abc/student/g' /etc/s6-overlay/s6-rc.d/init-code-server/run
RUN sed -i -e 's/abc/student/g' /etc/s6-overlay/s6-rc.d/init-crontab-config/run
RUN sed -i -e 's/abc/student/g' /etc/s6-overlay/s6-rc.d/svc-cron/run
# Change the port since 8443 implies TLS encrypted, but it's actually not.
RUN sed -i -e 's/8443/8000/g' /etc/s6-overlay/s6-rc.d/svc-code-server/run
# Add support for Python
RUN apt-get update && apt-get install -y \
  python3 \
  python3-pip \
  pylint \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*
# No need for this since package conflicts are highly unlikely in this configuration.
RUN rm /usr/lib/python3.*/EXTERNALLY-MANAGED
# Add support for ESP32 microcontrollers and MicroPython
RUN pip3 install esptool mpremote
# Preinstall Python VS Code extension.
RUN /app/code-server/bin/code-server --extensions-dir /config/extensions --install-extension ms-python.python
EXPOSE 8000
