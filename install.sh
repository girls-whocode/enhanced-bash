#!/usr/bin/env bash
# title             :Enhanced BASH Backup File System
# description       :A module to backup a directory or file
# author            :Jessica Brown
# date              :2020-01-25
# usage			    :bakup [--help|-h] [directory/|filename.ext]
# notes			    :This install may not work on all systems, please try to install manually!
# bash_version	    :4.4.19(1)-release
# ==============================================================================
#	1.2.0
#		New bash.conf file being added with questions to fill
#		Modified all path folders to respect installation location versus install from location
#	2.0.0
#		Rewrite of code to contain viable installation system

# Setup temp variables to define base locations
version="2.0.0"
scriptLocation="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[ -f "${scriptLocation}/bin/log_system.sh" ] && source "${scriptLocation}/bin/log_system.sh" || echo "System files are not found, installation was not successful."
[ -f "${scriptLocation}/bin/bash.conf" ] && source "${scriptLocation}/bin/bash.conf" || echo "The configuration file could not be found."
[ -f "${scriptLocation}/lib/lib_colors" ] && source "${scriptLocation}/lib/lib_colors"

# Define default directories
export binInstallLocation="${scriptLocation}${dirSeperator}${binSubPath}"
export libInstallLocation="${scriptLocation}${dirSeperator}${libSubPath}"
export modInstallLocation="${scriptLocation}${dirSeperator}${modSubPath}"
export orInstallLocation="${scriptLocation}${dirSeperator}${overrideSubPath}"
export thmInstallLocation="${scriptLocation}${dirSeperator}${themeSubPath}"
export logsInstallLocation="${binInstallLocation}${dirSeperator}${logsSubPath}"
export archiveInstallLocation="${binInstallLocation}${dirSeperator}${archiveSubPath}"
export userHomeLocation=$( getent passwd "${USER}" | cut -d: -f6 )

export dirJumpFolder="${binInstallLocation}${dirSeperator}${dirJumpPath}"
export directory_list="${binInstallLocation}${dirSeperator}${dirJumpPath}${dirSeperator}${dirListFile}"
export defaultInstallationLocation="${HOME}${dirSeperator}.local${dirSeperator}share${dirSeperator}applications${dirSeperator}${installationSubPath}"
export defaultSourceLocations=("${libInstallLocation}" "${modInstallLocation}" "${overridesInstallLocation}" "${themesInstallLocation}")

# See if they need some help -- Needs to be rewritten
if [[ $1 == "--help" ]]; then
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
read -p "$(echo -e ${White}Enter installation location ${Red}[${SteelBlue2}${defaultInstallationLocation}${Red}]${Aqua}: ${txtReset})" defaultInstallBaseDirectory

if [[ ${defaultInstallBaseDirectory} == "" ]]; then
	export defaultInstallBaseDirectory="${HOME}${dirSeperator}.local${dirSeperator}share${dirSeperator}applications${dirSeperator}${installationSubPath}"
fi

export installDirectories=("${defaultInstallBaseDirectory}${dirSeperator}${libSubPath}" "${defaultInstallBaseDirectory}${dirSeperator}${modSubPath}" "${defaultInstallBaseDirectory}${dirSeperator}${logsSubPath}" "${defaultInstallBaseDirectory}${dirSeperator}${overridesInstallLocation}" "${defaultInstallBaseDirectory}${dirSeperator}${archiveSubPath}" "${defaultInstallBaseDirectory}${dirSeperator}${dirJumpPath}" "${defaultInstallBaseDirectory}${dirSeperator}${installationSubPath}")

for installDirectory in ${installDirectories[*]}; do
	if [ ! -d ${installDirectory} ]; then
		mkdir -p ${installDirectory} > /dev/null 2>&1
		retVal=$?
		if [ $retVal -ne 0 ]; then
    		error "[Creating directory ${installDirectory}]" >> ${logsInstallLocation}${dirSeperator}installation.log
		else
			success "[Creating directory ${installDirectory}]" >> ${logsInstallLocation}${dirSeperator}installation.log
		fi
	fi
done

# Install the minimal dependancies - git curl highlight most
echo -e "${Red}NOTICE: ${Silver}This script will install ${Yellow}git${White},${Yellow}curl${White},${Yellow}highlight${White},${Yellow}most${White},${Yellow}wget${White},${Yellow}python3${White},${Yellow}pip${White} ${Silver}sudo will be requested, please enter your password.${txtReset}"
sudo apt install git curl highlight most wget python3-pip

# Check if powerline-status exists
pip install --user powerline-status

# Copy all of the files to the new folder and remove the install.sh script
cp -r ${scriptLocation}${dirSeperator}* ${defaultInstallBaseDirectory}${dirSeperator}
echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[SUCCESS]:[installation folder found at ${defaultInstallBaseDirectory}${dirSeperator}]" >> ${logsInstallLocation}${dirSeperator}install.log
rm ${defaultInstallBaseDirectory}${dirSeperator}install.sh

# Rename the current .bashrc to .bashrc-$timestamp-EBS
mv "${HOME}/.bashrc" "${HOME}/.bashrc-$(LC_ALL=C date +%Y%m%d_%H%M%S)-EBS"

# Create the new .bashrc to source to the enhanced-bash-system.sh
printf "# Created by Enhanced BASH Installer on $(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')\n\ncase \"\$TERM\" in\n\txterm-color|screen|*-256color)\n\t\tcd ${defaultInstallBaseDirectory}${dirSeperator}\n\t\t. ${defaultInstallBaseDirectory}${dirSeperator}/bash_system.sh;;\nesac\n" > ~/.bashrc

# Create the new directory jump folder and files
mkdir -p ${dirJumpFolder}
touch ${dirJumpFolder}${dirSeperator}directory_list

# Create the log-rotate conf file
echo -e "${logsInstallLocation}${dirSeperator}startup.log {\n\tsu $USER $USER\n\tnotifempty\n\tcopytruncate\n\tweekly\n\trotate 52\n\tcompress\n\tmissingok\n}\n" | sudo tee ${dirSeperator}etc${dirSeperator}logrotate.d${dirSeperator}enhanced-bash

# Make a Success or Error banner with a pitiful self promotion link to the gitlab page.
