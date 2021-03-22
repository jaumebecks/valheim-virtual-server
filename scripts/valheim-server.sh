#!/bin/sh
apt update && apt -y upgrade
add-apt-repository multiverse
dpkg --add-architecture i386
apt update
apt install -y steamcmd
useradd --create-home --shell /bin/bash --password steam steam
sudo -u steam -H sh -c "ln -s /usr/games/steamcmd /home/steam/steamcmd;
/home/steam/steamcmd +login anonymous +force_install_dir /home/steam/valheimserver +app_update 896660 validate +exit;
cat > /home/steam/valheimserver/start_valheim.sh << ValheimScript
#!/bin/bash
export templdpath=\\\$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:\\\$LD_LIBRARY_PATH
export SteamAppId=892970
./valheim_server.x86_64 \\\\
    -name \\\$VALHEIM_SERVER_NAME \\\\
    -port 2456 \\\\
    -world \\\$VALHEIM_SERVER_WORLD \\\\
    -password \\\$VALHEIM_SERVER_PASSWORD \\\\
    -public 1 \\\\
    -nographics \\\\
    -batchmode
export LD_LIBRARY_PATH=\\\$templdpath
ValheimScript
cat > /home/steam/check_log.sh << LogsScript
journalctl --unit=valheimserver --reverse
LogsScript
"

chmod +x /home/steam/valheimserver/start_valheim.sh
chmod +x /home/steam/check_log.sh

cat > /etc/systemd/system/valheimserver.service << ValheimServerService
[Unit]
Description=Valheim Server
Wants=network-online.target
After=syslog.target network.target nss-lookup.target network-online.target

[Service]
Type=simple
Restart=on-failure
RestartSec=5
StartLimitInterval=60s
StartLimitBurst=3
User=steam
Group=steam
ExecStartPre=/home/steam/steamcmd +login anonymous +force_install_dir /home/steam/valheimserver +app_update 896660 validate +exit
ExecStart=/home/steam/valheimserver/start_valheim.sh
EnvironmentFile=/vagrant/.env
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s INT $MAINPID
WorkingDirectory=/home/steam/valheimserver
LimitNOFILE=100000

[Install]
WantedBy=multi-user.target
ValheimServerService

systemctl daemon-reload
systemctl start valheimserver
systemctl status --no-pager valheimserver
systemctl enable valheimserver
