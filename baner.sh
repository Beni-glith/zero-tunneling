#!/bin/bash

BANNER_URL="https://raw.githubusercontent.com/kcepu877/zero-tunneling/main/baner.txt"
BANNER_PATH="/etc/baner.txt"

# Warna
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}▶ Mengunduh banner terbaru...${NC}"
wget -q "$BANNER_URL" -O "$BANNER_PATH"

if [ -f "$BANNER_PATH" ]; then
    echo -e "${GREEN}✅ Banner berhasil diunduh ke $BANNER_PATH${NC}"

    echo -e "${GREEN}▶ Mengatur banner untuk SSH...${NC}"
    grep -q "^Banner" /etc/ssh/sshd_config && \
        sed -i "s|^Banner .*|Banner $BANNER_PATH|" /etc/ssh/sshd_config || \
        echo "Banner $BANNER_PATH" >> /etc/ssh/sshd_config

    echo -e "${GREEN}▶ Mengatur banner untuk Dropbear...${NC}"
    sed -i 's|^DROPBEAR_BANNER=.*|DROPBEAR_BANNER="/etc/banner.txt"|' /etc/default/dropbear

    echo -e "${GREEN}▶ Restarting layanan SSH dan Dropbear...${NC}"
    systemctl restart ssh >/dev/null 2>&1 || service ssh restart
    systemctl restart dropbear >/dev/null 2>&1 || service dropbear restart

    echo -e "${GREEN}✅ Banner aktif untuk SSH & Dropbear.${NC}"
else
    echo -e "${RED}❌ Gagal mengunduh banner.${NC}"
fi
