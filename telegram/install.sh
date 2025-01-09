#!/usr/bin/env bash

ARCH=$(uname -m)

case "$ARCH" in
x86_64)
  BINARY_URL="https://github.com/wtf403/ava/raw/main/telegram/linux-x86_64"
  ;;
aarch64)
  BINARY_URL="https://github.com/wtf403/ava/raw/main/telegram/linux-aarch64"
  ;;
*)
  echo "Unsupported architecture: $ARCH"
  exit 1
  ;;
esac

curl -L -o telegram-binary $BINARY_URL
chmod +x telegram-binary

# run it first time

# .service file
cat <<EOF >telegram.service
[Unit]
Description=Telegram Service

[Service]
ExecStart=$(pwd)/telegram-binary
User=$(whoami)

[Install]
WantedBy=multi-user.target
EOF

# .timer file
cat <<EOF >telegram.timer
[Unit]
Description=Run Telegram Service daily at midnight

[Timer]
OnCalendar=*-*-* 00:00:00
Unit=telegram.service

[Install]
WantedBy=timers.target
EOF

sudo mv telegram.service /etc/systemd/system/
sudo mv telegram.timer /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable telegram.timer
sudo systemctl start telegram.timer
