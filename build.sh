#!/bin/bash
set -e

# Pastikan payload.sh executable & dikompres
chmod +x payload.sh
bzip2 -kf payload.sh

# Hitung jumlah baris header (untuk 'skip')
HEADER=$(cat << 'EOF'
#!/bin/sh
skip=20
set -C
umask=`umask`
umask 77
tmpfile=`mktemp /tmp/bebadtmp.XXXXXX` || exit 1
if tail -n +$skip "$0" | bzip2 -cd >> $tmpfile; then
  umask $umask
  chmod 700 $tmpfile
  prog=`basename "$0"`
  if ln -T $tmpfile "/tmp/$prog" 2>/dev/null; then
    trap 'rm -f $tmpfile "/tmp/$prog"; exit $res' 0
    (sleep 5; rm -f $tmpfile "/tmp/$prog") 2>/dev/null &
    /tmp/"$prog" ${1+"$@"}; res=$?
  else
    trap 'rm -f $tmpfile; exit $res' 0
    (sleep 5; rm -f $tmpfile) 2>/dev/null &
    $tmpfile ${1+"$@"}; res=$?
  fi
else
  echo "Cannot decompress $0"; exit 1
fi; exit $res
EOF
)

# Sesuaikan skip jika header bertambah/berkurang
echo "$HEADER" > installer.sh

# Tambahkan payload
cat payload.sh.bz2 >> installer.sh
chmod +x installer.sh

echo "✔ Built installer.sh"
