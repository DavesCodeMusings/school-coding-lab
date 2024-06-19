FROM lscr.io/linuxserver/code-server:latest
LABEL org.opencontainers.image.source = "https://github.com/DavesCodeMusings/school-coding-lab"
RUN apt-get update && apt-get install -y \
  python3 \
  pylint \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*
# Allow pre-installed extensions to be found by linking directory.
RUN ln -s /config/extensions /config/.local/share/code-server/extensions
# Preinstall Python extension
RUN /app/code-server/bin/code-server --install-extension ms-python.python
EXPOSE 8443
