#!/usr/bin/env bash
# 
# This will add some NSM settings to your .xsessionrc in Debian based distributions and create symlinks for the scripts in your bin. There are three options:
# - specify NSM_PORT, NSM_DIR and INSTALL_DIR ahead of time
# - edit them here
# - leave them at their defaults
# - some combination of the aforementioned
#
# e.g. INSTALL_DIR=/home/foo/bin NSM_DIR=/home/foo/bar NSM_PORT=1234 ./INSTALL.sh

if [[ -z "$INSTALL_DIR" ]]; then
    INSTALL_DIR="$HOME/bin"
fi
if [[ -z "$NSM_DIR" ]]; then
    NSM_DIR="$HOME/NSM Sessions"
fi
if [[ -z "$NSM_PORT" ]]; then
    NSM_PORT=18440
fi

if [[ -e "$HOME/.xsessionrc" ]]; then #check if file exist
	echo "Writing settings to $HOME/.xsessionrc"
	echo "# NSM settings
	export NSM_PORT=18440
	export NSM_URL=osc.udp://$HOSTNAME:$NSM_PORT/
	export NSM_DIR=$NSM_DIR
	start-nsm
	"  >> "$HOME/.xsessionrc" 
else
	echo "File $HOME/.xsessionrc doesn't exist, add the file please. Aborting now."; 
	exit 0
fi

cd scripts || echo "ERROR: folder 'scripts' doesn't exist, can't make symlinks to $INSTALL_DIR"; 
echo "cd scripts"
for i in *; do
	echo "rm $INSTALL_DIR/$i"
    rm "$INSTALL_DIR/$i"
	echo "ln -s $PWD/$i $INSTALL_DIR"
    ln -s "$PWD/$i" "$INSTALL_DIR"
done
