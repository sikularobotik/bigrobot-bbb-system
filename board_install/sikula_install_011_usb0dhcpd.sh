#!/bin/sh
SIKULA_INSTALL_SCRIPT=1 ./sikula_install.sh || exit 1

# Install softs to act as dhcp server on usb0
# ===========================================

# Charge g_ether at startup
#--------------------------

echo -e "# Charger g_ether.ko au démarrage\ng_ether" > /etc/modules-load.d/g_ether.conf

# Install dhcp server
#--------------------

pacman -S dhcp

# DHCPd configuration
#--------------------

cat << EOF > /etc/dhcpd.conf
# dhcpd.conf

default-lease-time 600;
max-lease-time 7200;

subnet 192.168.2.0 netmask 255.255.255.0 {
	range 192.168.2.10 192.168.2.20;
}
EOF

# Start DHCPd at boot
#--------------------

systemctl enable dhcpd4.service

# Static IP configuration
#------------------------

mkdir /etc/conf.d
cat << EOF > /etc/conf.d/network@usb0
address=192.168.2.1
netmask=24
broadcast=192.168.2.255
EOF

# Static IP service
#------------------

cat << EOF > /etc/systemd/system/network@.service
[Unit]
Description=Network connectivity (%i)
Wants=network.target
Before=network.target
BindsTo=sys-subsystem-net-devices-%i.device
After=sys-subsystem-net-devices-%i.device

[Service]
Type=oneshot
RemainAfterExit=yes
EnvironmentFile=/etc/conf.d/network@%i

ExecStart=/usr/bin/ip link set dev %i up
ExecStart=/usr/bin/ip addr add \${address}/\${netmask} broadcast \${broadcast} dev %i

ExecStop=/usr/bin/ip addr flush dev %i
ExecStop=/usr/bin/ip link set dev %i down

[Install]
WantedBy=multi-user.target
EOF

# Enable Static IP servcie at boot
#---------------------------------

systemctl enable network@usb0.service

