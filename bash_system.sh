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
#	1. Currently it checks if the directory extists then files should be expected
#	   this should change to check for files instead
#	2. Check screen width for small screens (like cell phones) with terminal
#	DONE - 3. dirjump needs to become a module, not a library.
#	DONE - 4. Mixture of dirjump variables located in this file, they should be moved to the dirjump module.
#	DONE - 5. Looking over this code, it looks as if the lib_utils library is loaded twice
#	DONE - 6. Clean up script for easier to find and read, this should be just a controller
#	          to load each of the libraries, modules and overrides.
#	DONE - 7. Variables should be loaded from a library file, except path locations
#	DONE - 8. Create a config file for users to easily change custom variables

scriptLocation="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
libLocation="${scriptLocation}/lib"
modLocation="${scriptLocation}/modules"
orLocation="${scriptLocation}/overrides"
thmLocation="${scriptLocation}/themes"
logsLocation="${scriptLocation}/logs"
userHomeLocation=$( getent passwd "${USER}" | cut -d: -f6 )
archiveLocation="${scriptLocation}/.backup"

if [ -f "${scriptLocation}/ebash.conf" ]; then
	source "${scriptLocation}/ebash.conf"
fi

# Load the Lib Utils for logging functions, I am aware it is loaded again in the next block
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

__preload
