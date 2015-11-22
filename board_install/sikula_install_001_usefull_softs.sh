#!/bin/sh
SIKULA_INSTALL_SCRIPT=1 ./sikula_install.sh || exit 1

# Install usefull software
# ========================

pacman -Sy
pacman -S vim socat i2c-tools screen gnu-netcat python3 alsa-utils cgdb
