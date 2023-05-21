#!/bin/bash
Xvfb $DISPLAY -screen 0 1024x768x16 &
sleep 5
startxfce4 -display $DISPLAY &
x11vnc -forever -nopw -shared -rfbport 5900 -ncache 10 -display $DISPLAY &
websockify --web /usr/share/novnc 6080 localhost:5900
sleep infinity
