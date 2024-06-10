#! /bin/bash

# Modify touchpad
synclient FingerLow=5 FingerHigh=5 VertScrollDelta=10 HorizScrollDelta=50 VertTwoFingerScroll=0 HorizTwoFingerScroll=0 CircularScrolling=1 PalmDetect=1 TouchpadOff=1

# Turn on disable touchpad when typing
#syndaemon -d -i 5 -t -K

# Mount Google Drive
rclone mount gdrive: gdrive
