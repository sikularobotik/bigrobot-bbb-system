#!/bin/sh
SIKULA_INSTALL_SCRIPT=1 ./sikula_install.sh || exit 1

# Install void autorun scripts
# ============================

cat << EOF > /usr/lib/systemd/system/sikula_autorun.service
[Unit]
Description=Run autorun script for sikula

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/root/autorun/autorun.sh

[Install]
WantedBy=multi-user.target
EOF

systemctl enable sikula_autorun.service

mkdir -p /root/autorun/
pacman -S tmux


cat << EOF > /root/autorun/autorun.sh
#!/bin/bash
tmux_session=sikula
autorum_dir=/root/autorun/

cd \$autorum_dir

tmux new-session -s "\$tmux_session" -d \$autorum_dir/panel_topleft.sh
tmux split-window -t "\$tmux_session" -h \$autorum_dir/panel_topright.sh
tmux split-window -t "\$tmux_session" -v \$autorum_dir/panel_bottomright.sh
tmux select-pane -t "\$tmux_session" -L
tmux split-window -t "\$tmux_session" -v \$autorum_dir/panel_bottomleft.sh
EOF

chmod +x /root/autorun/autorun.sh

cat << EOF > /root/autorun/panel_topleft.sh
#!/bin/bash
echo \$0
/bin/bash # Start interactive shell, otherwise the panel closes
EOF

chmod +x /root/autorun/panel_topleft.sh

cp /root/autorun/panel_topleft.sh /root/autorun/panel_topright.sh
cp /root/autorun/panel_topleft.sh /root/autorun/panel_bottomright.sh
cp /root/autorun/panel_topleft.sh /root/autorun/panel_bottomleft.sh

echo "Connect to autorun scripts with ** sudo tmux attach -t sikula **" >> /etc/motd
