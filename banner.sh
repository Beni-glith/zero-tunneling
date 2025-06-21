#!/bin/bash

# Warna
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}▶ Mengunduh banner...${NC}"
wget -q https://raw.githubusercontent.com/kcepu877/zero-tunneling/main/banner.txt -O banner.txt

if [ -f banner.txt ]; then
    echo -e "${GREEN}✅ Banner berhasil diunduh.${NC}"
    echo -e "${GREEN}▶ Menampilkan banner:${NC}"
    echo ""
    cat banner.txt
    echo ""

    # Opsional: Simpan sebagai motd
    echo -e "${GREEN}▶ Menyimpan banner ke /etc/motd...${NC}"
    sudo cp banner.txt /etc/motd
    echo -e "${GREEN}✅ Banner akan muncul setiap login SSH.${NC}"
else
    echo -e "${RED}❌ Gagal mengunduh banner.${NC}"
fi
