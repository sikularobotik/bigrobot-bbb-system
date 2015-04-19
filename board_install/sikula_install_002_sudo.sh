#!/bin/sh
SIKULA_INSTALL_SCRIPT=1 ./sikula_install.sh || exit 1

# wheel group can sudo
# ====================

pacman -S sudo
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
