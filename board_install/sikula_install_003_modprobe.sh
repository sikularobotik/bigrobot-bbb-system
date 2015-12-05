#!/bin/sh
SIKULA_INSTALL_SCRIPT=1 ./sikula_install.sh || exit 1

# Automatic module loading
# ========================

cat << EOF > /etc/modules-load.d/ti_am335x_adc.conf
# Load ti_am335x_adc.ko at boot
ti_am335x_adc
EOF
