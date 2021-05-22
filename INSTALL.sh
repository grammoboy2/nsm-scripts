#!/usr/bin/env bash
# 
# This will add some NSM settings to your .xsessionrc in Debian based distributions and create symlinks for the scripts in your bin. There are three options:
# - specify NSM_PORT, NSM_DIR and INSTALL_DIR_NSM_SCRIPTS ahead of time
# - edit them here
# - leave them at their defaults
# - some combination of the aforementioned
#
# e.g. INSTALL_DIR_NSM_SCRIPTS=/home/foo/bin NSM_DIR=/home/foo/bar NSM_PORT=1234 ./INSTALL.sh

#to make testing easier, add a else
if [[ -z "$INSTALL_DIR_NSM_SCRIPTS" ]]; then
	INSTALL_DIR_NSM_SCRIPTS="$HOME/bin"
	echo "$INSTALL_DIR_NSM_SCRIPTS"
else
	echo "INSTALL_DIR_NSM_SCRIPTS not empty. Overwrite"
	echo "Current: $INSTALL_DIR_NSM_SCRIPTS"
	INSTALL_DIR_NSM_SCRIPTS="$HOME/bin"
	echo "New: $INSTALL_DIR_NSM_SCRIPTS"
fi

if [[ -z "$NSM_DIR" ]]; then
    NSM_DIR="$HOME/NSM\ Sessions"
	echo "$NSM_DIR"
else
	echo "NSM_DIR not empty, overwrite"
	echo "Current: $NSM_DIR"
	NSM_DIR="$HOME/NSM\ Sessions"
	echo "New: $NSM_DIR"
fi

if [[ -z "$NSM_PORT" ]]; then
    NSM_PORT=18440
	echo "$NSM_PORT"
else
	echo "NSM_PORT not empty, overwite"
	echo "Current: $NSM_PORT"
	NSM_PORT=18440
	echo "New: $NSM_PORT"
fi

if [[ -e "$HOME/.xsessionrc" ]]; then #check if file exist
	echo "Writing settings to $HOME/.xsessionrc"
	printf "%s\n%s\n%s\n%s\n%s\n" "# NSM settings" "export NSM_PORT=18440" "export NSM_URL=osc.udp://$HOSTNAME:$NSM_PORT/" "export NSM_DIR=$NSM_DIR" "bash $INSTALL_DIR_NSM_SCRIPTS/start-nsm" >> "$HOME/.xsessionrc" 
else
	echo "File $HOME/.xsessionrc doesn't exist, add the file please. Aborting now."; 
	exit 0
fi

cd scripts || { echo "ERROR: no 'scripts' folder. Can't make the symlinks to $INSTALL_DIR_NSM_SCRIPTS"; exit; }
echo "cd scripts"
for i in *; do
	rm "$INSTALL_DIR_NSM_SCRIPTS/$i" 
	echo "rm $INSTALL_DIR_NSM_SCRIPTS/$i" 
	ln -s "$PWD/$i" "$INSTALL_DIR_NSM_SCRIPTS"
	echo "ln -s $PWD/$i $INSTALL_DIR_NSM_SCRIPTS"; 
done
