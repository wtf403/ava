#!/usr/bin/env bash

ARCH=$(uname -m)

case "$ARCH" in
x86_64)
  BINARY_URL="https://github.com/wtf403/ava/raw/main/twitter/linux-x86_64"
  ;;
aarch64)
  BINARY_URL="https://github.com/wtf403/ava/raw/main/twitter/linux-aarch64"
  ;;
*)
  echo "Unsupported architecture: $ARCH"
  exit 1
  ;;
esac

curl -L -o twitter-binary $BINARY_URL
chmod +x twitter-binary

# .service file
cat <<EOF >twitter.service
[Unit]
Description=Twitter Service

[Service]
ExecStart=$(pwd)/twitter-binary
User=$(whoami)

[Install]
WantedBy=multi-user.target
EOF

# .timer file
cat <<EOF >twitter.timer
[Unit]
Description=Run Twitter Service daily at midnight

[Timer]
OnCalendar=*-*-* 00:00:00
Unit=twitter.service

[Install]
WantedBy=timers.target
EOF

sudo mv twitter.service /etc/systemd/system/
sudo mv twitter.timer /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable twitter.timer
sudo systemctl start twitter.timer
