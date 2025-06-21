#!/bin/bash

# Hapus .profile lama
rm -rf /root/.profile

# Buat file .profile baru
cat <<EOF >> /root/.profile
if [ "/bin/bash" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi
mesg n || true
welcome
EOF

# Tambah cron job auto_update
cron_file="/etc/cron.d/auto_update"
pekerjaan_cron="15 1 * * * root /usr/local/sbin/auto_update"
if ! grep -Fq "$pekerjaan_cron" "$cron_file" 2>/dev/null; then
    echo "$pekerjaan_cron" > "$cron_file"
fi

# Tambah cron job auto_update2
cron_file="/etc/cron.d/auto_update2"
pekerjaan_cron="15 2 * * * root /usr/local/sbin/auto_update2"
if ! grep -Fq "$pekerjaan_cron" "$cron_file" 2>/dev/null; then
    echo "$pekerjaan_cron" > "$cron_file"
fi

# Tambah cron job backup
cron_file="/etc/cron.d/backup_otomatis"
pekerjaan_cron="15 23 * * * root /usr/local/sbin/backupfile"
if ! grep -Fq "$pekerjaan_cron" "$cron_file" 2>/dev/null; then
    echo "$pekerjaan_cron" > "$cron_file"
fi

# Tambah cron job delete_exp
cron_file="/etc/cron.d/delete_exp"
pekerjaan_cron="0 3 */2 * * root /usr/local/sbin/xp"
if ! grep -Fq "$pekerjaan_cron" "$cron_file" 2>/dev/null; then
    echo "$pekerjaan_cron" > "$cron_file"
fi

# Fungsi menampilkan progress bar
fun_bar() {
    CMD[0]="$1"
    (
        ${CMD[0]} -y >/dev/null 2>&1
        touch /tmp/selesai_update
    ) &
    tput civis
    echo -ne "  \033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m#"
            sleep 0.1s
        done
        [[ -e /tmp/selesai_update ]] && rm /tmp/selesai_update && break
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  Please Wait Loading \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
    tput cnorm
}

# Fungsi update file di /usr/local/sbin
res1() {
    wget https://raw.githubusercontent.com/kcepu877/zero-tunneling/main/Cdy/menu.zip -O menu.zip >/dev/null 2>&1
    7z x -pVPNEXPRESS12345 menu.zip
    chmod +x menu/*
    rm -r /usr/local/sbin
    mkdir /usr/local/sbin
    mv menu/* /usr/local/sbin
    chmod +x /usr/local/sbin/*
    rm -rf menu menu.zip 
}

# Jalankan update
jalankan_update() {
    fun_bar res1
}
jalankan_update

# =======================
# Tambahan: Banner setup
# =======================
#!/bin/bash

function menu() {
  echo ""
  echo "Menjalankan fungsi MENU..."
  # Tambahkan isi menu di sini
  Select_Display  # Langsung kembali ke menu tanpa delay
}

function Select_Display() {
  clear
  echo "1) MENU"
  read -p "Pilih opsi [1]: " hallo
  case $hallo in
    1) clear; menu ;;
    *) clear; menu ;;
  esac
}

# Jalankan awal
Select_Display
