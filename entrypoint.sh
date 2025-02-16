#!/bin/bash
# Start D-Bus
service dbus start

# Start Xvfb (virtual display)
Xvfb :1 -screen 0 1920x1020x24 &
export DISPLAY=:1

# Start VNC server
export USER=root && vncserver :1 -geometry 1920x1080 -depth 24

export XDG_SESSION_PATH=/tmp/.session

# Start Ghidra in the foreground
/opt/ghidra/support/launch.sh debug Ghidra 768M "" ghidra.GhidraRun

# Keep the container running (fallback)
tail -f /dev/null
