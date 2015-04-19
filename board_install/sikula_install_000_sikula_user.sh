#!/bin/sh
SIKULA_INSTALL_SCRIPT=1 ./sikula_install.sh || exit 1

# Create sikula user
# ==================

useradd -m sikula -G wheel
echo -e "robotpass\nrobotpass" | passwd sikula
