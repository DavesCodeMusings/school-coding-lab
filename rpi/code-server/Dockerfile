# Start with code-server container from linuxserver.io
FROM lscr.io/linuxserver/code-server:latest

# Add Python support
RUN apt-get update && apt-get install -y \
  python3 \
  pylint \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*
