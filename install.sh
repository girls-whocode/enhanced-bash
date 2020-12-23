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

# Setup temp variables to define base locations
version="1.2.0"
thisHost="$(hostname)"
scriptName="$(basename ${0})" # Set Script Name variable
scriptBasename="$(basename ${scriptName} .sh)" # Strips '.sh' from scriptName
scriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${scriptLocation}${dirSeperator}log_system.sh"
source "${scriptPath}/bash.conf"

# BASHSYSTEMVERSION
# ------------------------------------------------------
# Version this script is tested on
# ------------------------------------------------------
bashsystemVersion=("5.0.17(1)-release" "4.0.1 l2m1")
currentBasgVersion=$BASH_VERSION

# TIMESTAMPS
# ------------------------------------------------------
# Prints the current date and time in a variety of formats:
# ------------------------------------------------------
now=$(LC_ALL=C date +"%m-%d-%Y %r")        				# Returns: 06-14-2015 10:34:40 PM
logtime=$(LC_ALL=C date +"%Y-%m-%d %H:%M:%S")			# Returns: 2015-06-14 20:34:40
datestamp=$(LC_ALL=C date +"%Y-%m-%d")       				# Returns: 2015-06-14
hourstamp=$(LC_ALL=C date +"%r")             				# Returns: 10:34:40 PM
timestamp=$(LC_ALL=C date +"%Y%m%d_%H%M%S")  				# Returns: 20150614_223440
today=$(LC_ALL=C date +"%m-%d-%Y")         				# Returns: 06-14-2015
longdate=$(LC_ALL=C date +"%a, %d %b %Y %H:%M:%S %z")	# Returns: Sun, 10 Jan 2016 20:47:53 -0500
gmtdate=$(LC_ALL=C date -u -R | sed 's/\+0000/GMT/')	# Returns: Wed, 13 Jan 2016 15:55:29 GMT

libInstallLocation="${scriptPath}${dirSeperator}${libSubPath}"
modInstallLocation="${scriptPath}${dirSeperator}${modSubPath}"
logInstallsLocation="${scriptPath}${dirSeperator}"
overridesInstallLocation="${scriptPath}${dirSeperator}${overrideSubPath}"
themesInstallLocation="${scriptPath}${dirSeperator}${themeSubPath}"
archiveInstallLocation="${HOME}${dirSeperator}${archiveSubPath}"

dirJumpFolder="${libLocation}${dirSeperator}${dirJumpPath}"
directory_list="${dirjumpfolder}${dirSeperator}${dirListFile}"
last_dir_remove="${dirjumpfolder}${dirSeperator}${dirLastRemoveFile}"

defaultInstallationLocation="${HOME}${dirSeperator}.local${dirSeperator}share${dirSeperator}applications${dirSeperator}${installationSubPath}"
defaultInstallDirectories=("${libSubPath}" "${modSubPath}" "${logsSubPath}" "${overridesInstallLocation}" "${archiveSubPath}" "${dirJumpPath}" "${installationSubPath}")

defaultSourceLocations=("${libInstallLocation}" "${modInstallLocation}" "${overridesInstallLocation}" "${themesInstallLocation}")

for folder in ${defaultSourceLocations[*]}; do
	for file in ${folder}/*; do
		source ${file}
		success "[Loading ${file}]" # >> ${logInstallsLocation}/install.log
	done
done

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
read -p "$(echo -e ${White}Enter installation location ${Red}[${SteelBlue2}${defaultInstallDirectories}${Red}]${Aqua}: ${txtReset})" defaultInstallDirectories

if [[ $defaultInstallDirectories == "" ]]; then
	defaultInstallDirectories="${HOME}${dirSeperator}.local${dirSeperator}share${dirSeperator}applications${dirSeperator}${installationSubPath}"
fi

for installDirectory in ${installDirectories[*]}; do
	if [ ! -d ${defaultInstallDirectories}${dirSeperator}${installDirectory} ]; then
		mkdir -p ${defaultInstallDirectories}${dirSeperator}${installDirectory}
		success "[Creating directory ${defaultInstallDirectories}${dirSeperator}${installDirectory}]"
	else
		# Create uninstall script
	fi
done

exit 0

if [[ ! $defaultInstallDirectories == "" ]] || [ ! -d $defaultInstallDirectories ]; then
	errorMsg="$(mkdir -p $defaultInstallDirectories 2>&1)"

	if [ "$errorMsg" = "" ]; then
		echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[SUCCESS]:[Created installation folder ${defaultInstallDirectories}]" >> ${logInstallsLocation}/install.log
	else
		error "${errorMsg}."
		echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[ERROR]:[Failed installation folder ${errorMsg}]" >> ${logInstallsLocation}/install.log
    fi
else
	error "${errorMsg}."
	echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[ERROR]:[Failed installation folder ${errorMsg}]" >> ${logInstallsLocation}/install.log
fi

# Copy all of the files to the new folder and remove the install.sh script
if [ -d $defaultInstallDirectories ]; then
	echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[SUCCESS]:[installation folder found at ${defaultInstallDirectories}]" >> ${logInstallsLocation}/install.log
	cp -r $scriptPath/* $defaultInstallDirectories/
	rm $defaultInstallDirectories/install.sh
else
	echo "[$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')]:[ERROR]:[Installation folder was not found]" >> ${logInstallsLocation}/install.log
fi

# Rename the current .bashrc to .bashrc-$timestamp-EBS
mv ~/.bashrc ~/.bashrc-$(LC_ALL=C date +%Y%m%d_%H%M%S)-EBS

# Create the new .bashrc to source to the enhanced-bash-system.sh
printf "# Created by Enhanced BASH Installer on ${longdate}\n\ncase \"\$TERM\" in\n\txterm-color|screen|*-256color)\n\t\tcd ${defaultInstallDirectories}\n\t\t. ${defaultInstallDirectories}/bash_system.sh;;\nesac\n" > ~/.bashrc

# Verify and install the following: git, curl, highlight
# cd ${libLocation}/has && sudo make install
# has git curl highlight 
echo -e "${StealBlue2}To use many features of this program, install any programs that show and ${Red}x${txtReset}"

# Create the new directory jump folder and files
mkdir -p ${defaultInstallDirectories}/lib/dirjump
touch ${defaultInstallDirectories}/lib/dirjump/directory_list
touch ${defaultInstallDirectories}/lib/dirjump/last_dir_remove

# Create the log-rotate conf file
echo "${defaultInstallDirectories}/logs/startup.log {\n\tsu $USER $USER\n\tnotifempty\n\tcopytruncate\n\tweekly\n\trotate 52\n\tcompress\n\tmissingok\n}\n" | sudo tee /etc/logrotate.d/enhanced-bash

# Make a Success or Error banner with a pitiful self promotion link to the gitlab page.
