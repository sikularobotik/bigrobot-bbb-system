#!/bin/sh
SIKULA_INSTALL_SCRIPT=1 ./sikula_install.sh || exit 1

# Install ifplugd and enables it
# ==============================
# It starts a DHCP request on Ethernet cable plug

pacman -S ifplugd
systemctl enable ifplugd@eth0.service
