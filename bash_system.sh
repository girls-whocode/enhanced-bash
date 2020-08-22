#!/usr/bin/env bash
# title					:BASHRC System
# description			:This is a start up script to make your bash experience useful
# author				:Jessica Brown
# date					:2019-12-20
# version				:4
# usage					:After install, just open a terminal
# notes					:This script is self installing
# bash_version	:4.1.5(1)-release
# ==============================================================================
# TODO:
#	1. Right now it is check if the directory extists then files should be expected
#	   this should change to check for files
#	2. Check screen width for small screens (like cell phones)

# SCRIPTNAME
# ------------------------------------------------------
# Will return the name of the script being run
# ------------------------------------------------------
scriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
libLocation="${scriptPath}/lib"
modLocation="${scriptPath}/modules"
orLocation="${scriptPath}/overrides"
thmLocation="${scriptPath}/themes"
logsLocation="${scriptPath}/logs"
logFile="startup.log"
archiveLocation=$(getent passwd "$USER" | cut -d: -f6)"/.backup"
dirjumpfolder=${libLocation}/dirjump/
directory_list=${libLocation}/dirjump/directory_list
last_dir_remove=${libLocation}/dirjump/last_dir_remove
bashsystemVersion="4.0.1 l2m1"
prompt_theme="pureblack"

dirjump_command="d"
history_size=15

# TIMESTAMPS
# ------------------------------------------------------
# Prints the current date and time in a variety of formats:
# ------------------------------------------------------
now=$(LC_ALL=C date +"%m-%d-%Y %r")        				# Returns: 06-14-2015 10:34:40 PM
logtime=$(LC_ALL=C date +"%Y-%m-%d %H:%M:%S")			# Returns: 2015-06-14 20:34:40
datestamp=$(LC_ALL=C date +%Y-%m-%d)       				# Returns: 2015-06-14
hourstamp=$(LC_ALL=C date +%r)             				# Returns: 10:34:40 PM
timestamp=$(LC_ALL=C date +%Y%m%d_%H%M%S)  				# Returns: 20150614_223440
today=$(LC_ALL=C date +"%m-%d-%Y")         				# Returns: 06-14-2015
longdate=$(LC_ALL=C date +"%a, %d %b %Y %H:%M:%S %z")	# Returns: Sun, 10 Jan 2016 20:47:53 -0500
gmtdate=$(LC_ALL=C date -u -R | sed 's/\+0000/GMT/')	# Returns: Wed, 13 Jan 2016 15:55:29 GMT

# THISHOST
# ------------------------------------------------------
# Will print the current hostname of the computer the script
# is being run on.
# ------------------------------------------------------
thisHost=$(hostname)

bind -x '"\ec":"clear"' # Alt-C clears screen
bind -x '"\er":"reload"' # Alt-R reloads environment
bind -x '"\ev":"ver"' # Alt-V show Distro and version information
bind -x '"\ew":"who"' # Alt-W show who information
bind -x '"\eOP":"commands"' # F1 will display help system
bind -x '"\eh":"commands"' # Alternitive (Alt-H) for help if F1 is not available
bind -x '"\eOQ":"splashscreen"' # F2 will display the spashscreen
bind -x '"\es":"splashscreen"' # Alternitive (Alt-S) for splashscreen if F2 is not available

if [ -f "${libLocation}/lib_utils" ]; then
	source "${libLocation}/lib_utils"
else
	echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[ERROR]:[Failed referencing the file \"lib_util\". Exiting.]" >> ${logsLocation}/${logFile}
fi

# Source each library file in the lib folder
for library in ${libLocation}/lib_*; do
	if [ -f ${library} ]; then
		source ${library} 
		echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[SUCCESS]:[Loading ${library}]" >> ${logsLocation}/${logFile}
	else
		echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[ERROR]:[Loading ${library}]" >> ${logsLocation}/${logFile}
	fi
done

# Source each module in the modules folder
if [ -d ${modLocation} ]; then
	for module in ${modLocation}/mod_*; do 
		if [ -f ${module} ]; then
			source ${module}
			echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[SUCCESS]:[Loading ${module}]" >> ${logsLocation}/${logFile}
		else
			echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[ERROR]:[Loading ${module}]" >> ${logsLocation}/${logFile}
		fi
	done
else
	echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[INFO]:[No modules to load]" >> ${logsLocation}/${logFile}
fi

# Look for an overrides folder
if [ -d ${orLocation} ]; then
    for overrides in ${orLocation}/or_*; do 
        if [ -f ${overrides} ]; then
			source ${overrides}
			echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[SUCCESS]:[Loading ${overrides}]" >> ${logsLocation}/${logFile}
		else
			echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[ERROR]:[Loading ${overrides}]" >> ${logsLocation}/${logFile}
		fi
    done
else
	echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[INFO]:[No overides to load]" >> ${logsLocation}/${logFile}
fi

if [ -d ${thmLocation} ]; then
	if [ -f ${thmLocation}/thm_${prompt_theme} ]; then
		source ${thmLocation}/thm_${prompt_theme}
		echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[SUCCESS]:[Loading ${thmLocation}/thm_${prompt_theme}]" >> ${logsLocation}/${logFile}
	else
		echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[ERROR]:[Loading ${thmLocation}/thm_${prompt_theme}]" >> ${logsLocation}/${logFile}
		
		# The theme was not found, so load the default prompt
		if [ "$color_prompt" = yes ]; then
    		PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
		else
    		PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
		fi
	fi
else
	echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[INFO]:[No overides to load]" >> ${logsLocation}/${logFile}
fi

# If you already use the number 0-9 as aliases,
# feel free to comment out or delete these.
# You can still use <dirjump_command> <dir path number>
# to jump through the dir history
# Source: https://unix.stackexchange.com/a/203160/307359
i=0

alias "$dirjump_command"="dirjump"
while [ $i -le $history_size ]; do
	alias $i="$dirjump_command $i"
	i=`expr $i + 1`
done

__preload
chkUpdate