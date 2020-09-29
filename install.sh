#!/usr/bin/env bash
# title             :Enhanced BASH Backup File System
# description       :A module to backup a directory or file
# author            :Jessica Brown
# date              :2020-01-25
# usage			    :bakup [--help|-h] [directory/|filename.ext]
# notes			    :This install may not work on all systems, please try to install manually!
# bash_version	    :4.4.19(1)-release
# ==============================================================================
version="1.1.0"
thisHost="$(hostname)"
scriptName="$(basename ${0})" # Set Script Name variable
scriptBasename="$(basename ${scriptName} .sh)" # Strips '.sh' from scriptName
scriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
libLocation="${scriptPath}/lib"
modLocation="${scriptPath}/modules"
logsLocation="${scriptPath}/logs"
archiveLocation="${HOME}/.backup"
dirjumpfolder="${libLocation}/dirjump"
directory_list="${libLocation}/dirjump/directory_list"
last_dir_remove="${libLocation}/dirjump/last_dir_remove"
installationLocation="${HOME}/.local/bin/enhanced-bash"

if [ -f "${libLocation}/lib_utils" ]; then
	source "${libLocation}/lib_utils"
else
	echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[ERROR]:[Failed referencing the file \"lib_util\". Exiting.]" >> ${logsLocation}/install.log
fi

# Source each library file in the lib folder
for library in ${scriptPath}/lib/lib_*; do
	if [ -f ${library} ]; then
		source ${library} 
		echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[SUCCESS]:[Loading ${library}]" >> ${logsLocation}/install.log
	else
		echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[ERROR]:[Loading ${library}]" >> ${logsLocation}/install.log
	fi
done

# Source each module in the modules folder
if [ -d ${scriptPath}/modules ]; then
	for module in ${scriptPath}/modules/mod_*; do
		if [ -f ${module} ]; then
			source ${module}
			echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[SUCCESS]:[Loading ${module}]" >> ${logsLocation}/install.log
		else
			echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[ERROR]:[Loading ${module}]" >> ${logsLocation}/install.log
		fi
	done
else
	echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[INFO]:[No modules to load]" >> ${logsLocation}/install.log
fi

# Look for an overrides folder
if [ -d ${scriptPath}/overrides ]; then
    for overrides in ${scriptPath}/overrides/or_*; do
        if [ -f ${overrides} ]; then
			source ${overrides}
			echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[SUCCESS]:[Loading ${overrides}]" >> ${logsLocation}/install.log
		else
			echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[ERROR]:[Loading ${overrides}]" >> ${logsLocation}/install.log
		fi
    done
else
	echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[INFO]:[No overides to load]" >> ${logsLocation}/install.log
fi

if [[ $1 != "--force" ]]; then
	clear
	echo -e "${Red}Notice: ${White}This install script is still under construction, ${Red} DO NOT USE!${txtReset}"
	echo -e "${Silver}There are many things that are not currently completed. Follow these 10 steps to install this program:${txtReset}"
	echo -e "${DeepPink8}Use the ${Silver}--force ${DeepPink8}to force the install and hopfully it won't break your system."
	cursorpos down 2
	cursorpos col 2; echo -e "${Cyan}1. ${Silver}Create the folder: ${Purple}${HOME}/.local/bin${txtReset}"
	cursorpos col 2; echo -e "${Cyan}2. ${Silver}Move the ${Purple}enhanced-bash-script ${Silver}folder to the ${Purple}bin ${Silver}folder.${txtReset}"
	cursorpos col 2; echo -e "${Cyan}3. ${Silver}Rename your .bashrc to .bashrc-org (or whatever you want)${txtReset}"
	cursorpos col 2; echo -e "${Cyan}4. ${Silver}Create a new .bashrc to source the ${Purple}bash_system.sh${txtReset}"
	cursorpos col 2; echo -e "${Cyan}5. ${Silver}Install ${SteelBlue}git, curl, highlight, tput, logrotate${txtReset}"
	cursorpos col 2; echo -e "${Cyan}6. ${Silver}Create the folder: ${Purple}${HOME}/.backup${txtReset}"
	cursorpos col 2; echo -e "${Cyan}7. ${Silver}Create the folder: ${Purple}${HOME}/.local/bin/enhanced-bash-system/lib/dirjump${txtReset}"
	cursorpos col 2; echo -e "${Cyan}8. ${Silver}Create the file: ${Purple}${HOME}/.local/bin/enhanced-bash-system/lib/dirjump/directory_list${txtReset}"
	cursorpos col 2; echo -e "${Cyan}9. ${Silver}Create the file: ${Purple}${HOME}/.local/bin/enhanced-bash-system/lib/dirjump/last_dir_remove${txtReset}"
	cursorpos col 2; echo -e "${Cyan}10. ${Silver}Copy the file: ${Purple}${HOME}/.local/bin/enhanced-bash-system/lib/enhanced-bash to log-rotate folder${txtReset}"
	cursorpos col 2; echo -e "${Cyan}10. ${Silver}Consider contributing from my Git Repo: ${SpringGreen3}https://${SpringGreen3}gitlab.com/${SpringGreen3}public_scope/${SpringGreen3}bash-projects/${DarkSeaGreen7}enhanced-bash-system.git${txtReset}"
	echo -e ${txtReset} && exit
fi

# Create the installation folder (default is $HOME/.local/bin/enhanced-bash/)
read -p "$(echo -e ${White}Enter installation location ${Red}[${SteelBlue2}${installationLocation}${Red}]${Aqua}: ${txtReset})" installationLocation

if [[ $installationLocation == "" ]]; then
	installationLocation="${HOME}/.local/bin/enhanced-bash"
fi

if [[ ! $installationLocation == "" ]] || [ ! -d $installationLocation ]; then
	errorMsg="$(mkdir -p $installationLocation 2>&1)"

	if [ "$errorMsg" = "" ]; then
		echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[SUCCESS]:[Created installation folder ${installationLocation}]" >> ${logsLocation}/install.log
	else
		error "${errorMsg}."
		echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[ERROR]:[Failed installation folder ${errorMsg}]" >> ${logsLocation}/install.log
    fi
else
	error "${errorMsg}."
	echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[ERROR]:[Failed installation folder ${errorMsg}]" >> ${logsLocation}/install.log
fi

# Copy all of the files to the new folder and remove the install.sh script
if [ -d $installationLocation ]; then
	echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[SUCCESS]:[installation folder found at ${installationLocation}]" >> ${logsLocation}/install.log
	cp -r $scriptPath/* $installationLocation/
	rm $installationLocation/install.sh
else
	echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[ERROR]:[Installation folder was not found]" >> ${logsLocation}/install.log
fi

# Rename the current .bashrc to .bashrc-$timestamp-EBS
mv ~/.bashrc ~/.bashrc-$(LC_ALL=C date +%Y%m%d_%H%M%S)-EBS

# Create the new .bashrc to source to the enhanced-bash-system.sh
printf "editor=\"nano\"\n\ncase \"\$TERM\" in\n\txterm-color|screen|*-256color)\n\t\t. ${installationLocation}/bash_system.sh;;\nesac\n" > ~/.bashrc

# Verify and install the following: git, curl, highlight
# cd ${libLocation}/has && sudo make install
# has git curl highlight 
echo -e "${StealBlue2}To use many features of this program, install any programs that show and ${Red}x${txtReset}"

# Create the new directory jump folder and files
mkdir -p ${installationLocation}/lib/dirjump
touch ${installationLocation}/lib/dirjump/directory_list
touch ${installationLocation}/lib/dirjump/last_dir_remove

# Create the log-rotate conf file
echo "${installationLocation}/logs/startup.log {\n\tsu $USER $USER\n\tnotifempty\n\tcopytruncate\n\tweekly\n\trotate 52\n\tcompress\n\tmissingok\n}\n" | sudo tee /etc/logrotate.d/enhanced-bash

# Make a Success or Error banner with a pitiful self promotion link to the gitlab page.
