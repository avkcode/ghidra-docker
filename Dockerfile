FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    wget \
    unzip \
    tightvncserver \
    xfce4 \
    xfce4-goodies \
    dbus \
    xvfb \
    dbus-x11 \
    xfonts-base xfonts-100dpi xfonts-75dpi xfonts-cyrillic \
    && rm -rf /var/lib/apt/lists/*

# Download and install Ghidra
RUN wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.1.2_build/ghidra_10.1.2_PUBLIC_20220125.zip -O /tmp/ghidra.zip && \
    unzip /tmp/ghidra.zip -d /opt && \
    rm /tmp/ghidra.zip && \
    mv /opt/ghidra_10.1.2_PUBLIC /opt/ghidra

# Set up VNC server
RUN mkdir -p /root/.vnc && \
    echo "password" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd && \
    echo '#!/bin/sh' > /root/.vnc/xstartup && \
    echo 'startxfce4 &' >> /root/.vnc/xstartup && \
    chmod +x /root/.vnc/xstartup

# Expose VNC port
EXPOSE 5901

ENV USER=root

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Start D-Bus, VNC server, and Ghidra
CMD ["/entrypoint.sh"]
