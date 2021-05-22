nsm-scripts
===========

various scripts to supplement non session manager (NSM) usage.

requirements: nsmd, pyliblo

**INSTALL.sh** - exports NSM startup settings to `$HOME/.xsessionrc` in Debian based distributions and creates links for the scripts in a specified bin path. Formely it was exporting to `"$HOME/.profile` and that might still be a good option if .xsessionrc is not working for a reason on a specific system. See info links below.

**start-nsm** - called from `$HOME/.xsessionrc`. starts NSM with the given settings with a log outputted at `/tmp/nsmd.log`.

**nsm-create-default** - creates and opens a unique empty session. Useful if you want to noodle and decide you like what you hear.

**nsm-save** - sends a save signal to all apps in the session. Make a keybinding for this.

**nosm** - unsets `$NSM_URL` and runs a specified application.

**seq24-nsm** - fakes nsm support in seq24. use with nsm-proxy and SIGUSR1.



More information about Xsession, .xsessionrc and .profile:

https://wiki.debian.org/Xsession
https://www.debian.org/doc/manuals/debian-reference/ch07.en.html#_starting_the_x_window_system
https://help.ubuntu.com/community/EnvironmentVariables#A.2BAH4-.2F.profile
https://wiki.archlinux.org/title/Xprofile
