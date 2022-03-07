#!/usr/bin/env bash
# title             :Enhanced BASH Backup File System
# description       :A module to backup a directory or file
# author            :Jessica Brown
# date              :2020-01-25
# usage			    :bakup [--help|-h] [directory/|filename.ext]
# notes			    :This install may not work on all systems, please try to install manually!
# bash_version	    :5.0.17(1)-release, 4.4.19(1)-release
# ==============================================================================
#	1.2.0
#		New bash.conf file being added with questions to fill
#		Modified all path folders to respect installation location versus install from location
#	2.0.0
#		Rewrite of code to contain viable installation system
#   git config --global user.email "you@example.com"
#   git config --global user.name "Your Name"
# Setup temp variables to define base locations
version="2.0.0"
scriptLocation="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
White='\e[38;5;15m'
Yellow='\e[38;5;11m'
txtReset='\e[38;5;8m'
Cyan='\e[38;5;51m'
txtReset='\e[0m'

function compareConfig() {
	printf "# Created by Enhanced BASH Installer on $(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')\n\n# Editor\neditor=\"nano\"\n\n# Themes\nprompt_theme=\"pureblack\"\n\n# Default Files\nlogFile=\"startup.log\"\ndirListFile=\"directory_list\"\ndirLastRemoveFile=\"last_dir_remove\"\n\n# Folders\ndirSeperator=\"/\"\nbinSubPath=\"bin\"\nlibSubPath=\"lib\"\nmodSubPath=\"modules\"\nlogsSubPath=\"logs\"\noverrideSubPath=\"overrides\"\nthemeSubPath=\"themes\"\narchiveSubPath=\".backup\"\ndirJumpPath=\"dirjump\"\ninstallationSubPath=\"enhanced-bash\"\n\n# History Settings\nhistoryControl=\"ignoreboth\"\nhistoryAppend=\"histappend\"\nhistorySize=10000\nhistoryFileSize=200000\ndirectoryHistorySize=15\n\n# Keyboard Shortcuts\nkbClear=\"\\ec\" # Alt-C clears screen\nkbDirJump=\"\\ed\" # Alt-D directory history list\nkbReload=\"\\er\" # Alt-R reloads environment\nkbVersion=\"\\ev\" # Alt-V show Distro and version information\nkbWhoIs=\"\\ew\" # Alt-W show who information\nkbHelpFKey=\"\\eOP\" # F1 will display help system\nkbHelp=\"\\eh\" # Alternitive (Alt-H) for help if F1 is not available\nkbSpashscreenFKey=\"\\eOQ\" # F2 will display the spashscreen\nkbSpashscreen=\"\\es\" # Alternitive (Alt-S) for splashscreen if F2 is not available\n\n# Alias Shortcuts\ndirjumpCommand=\"d\"\n" > "${scriptLocation}/temp.dat"
	diff "${scriptLocation}/bin/bash.conf" "${scriptLocation}/temp.dat"
	rm "${scriptLocation}/temp.dat"
	bashConfig
}

function bashConfig() {
	# Create the Config file if it doesn't exist
	if [ -f "${scriptLocation}/bin/bash.conf" ]; then
		echo "Existing config file exists, would you like to replace it, use it, compare the new to existing, or backup existing and use new? (Default is backup and use new)"
		read -p "$(echo -e ${White}[${Cyan}R${White}]${txtReset}eplace ${White}[${Cyan}U${White}]${txtReset}se ${White}[${Cyan}C${White}]${txtReset}ompare ${White}[${Cyan}B${White}]${txtReset}ackup ${Yellow}:${txtReset})" configConfim
		if [ $configConfim == "R" ] || [ $configConfim == "r" ]; then
			printf "# Created by Enhanced BASH Installer on $(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')\n\n# Editor\neditor=\"nano\"\n\n# Themes\nprompt_theme=\"pureblack\"\n\n# Default Files\nlogFile=\"startup.log\"\ndirListFile=\"directory_list\"\ndirLastRemoveFile=\"last_dir_remove\"\n\n# Folders\ndirSeperator=\"/\"\nbinSubPath=\"bin\"\nlibSubPath=\"lib\"\nmodSubPath=\"modules\"\nlogsSubPath=\"logs\"\noverrideSubPath=\"overrides\"\nthemeSubPath=\"themes\"\narchiveSubPath=\".backup\"\ndirJumpPath=\"dirjump\"\ninstallationSubPath=\"enhanced-bash\"\n\n# History Settings\nhistoryControl=\"ignoreboth\"\nhistoryAppend=\"histappend\"\nhistorySize=10000\nhistoryFileSize=200000\ndirectoryHistorySize=15\n\n# Keyboard Shortcuts\nkbClear=\"\\ec\" # Alt-C clears screen\nkbDirJump=\"\\ed\" # Alt-D directory history list\nkbReload=\"\\er\" # Alt-R reloads environment\nkbVersion=\"\\ev\" # Alt-V show Distro and version information\nkbWhoIs=\"\\ew\" # Alt-W show who information\nkbHelpFKey=\"\\eOP\" # F1 will display help system\nkbHelp=\"\\eh\" # Alternitive (Alt-H) for help if F1 is not available\nkbSpashscreenFKey=\"\\eOQ\" # F2 will display the spashscreen\nkbSpashscreen=\"\\es\" # Alternitive (Alt-S) for splashscreen if F2 is not available\n\n# Alias Shortcuts\ndirjumpCommand=\"d\"\n" > "${scriptLocation}/bin/bash.conf"
			source "${scriptLocation}/bin/bash.conf"
		elif [ $configConfim == "U" ] || [ $configConfim == "u" ]; then
			source "${scriptLocation}/bin/bash.conf"
		elif [ $configConfim == "C" ] || [ $configConfim == "c" ]; then
			compareConfig
		elif [ $configConfim == "B" ] || [ $configConfim == "b" ]; then
			mv "${scriptLocation}/bin/bash.conf" "${scriptLocation}/bash.conf.bak"
			printf "# Created by Enhanced BASH Installer on $(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')\n\n# Editor\neditor=\"nano\"\n\n# Themes\nprompt_theme=\"pureblack\"\n\n# Default Files\nlogFile=\"startup.log\"\ndirListFile=\"directory_list\"\ndirLastRemoveFile=\"last_dir_remove\"\n\n# Folders\ndirSeperator=\"/\"\nbinSubPath=\"bin\"\nlibSubPath=\"lib\"\nmodSubPath=\"modules\"\nlogsSubPath=\"logs\"\noverrideSubPath=\"overrides\"\nthemeSubPath=\"themes\"\narchiveSubPath=\".backup\"\ndirJumpPath=\"dirjump\"\ninstallationSubPath=\"enhanced-bash\"\n\n# History Settings\nhistoryControl=\"ignoreboth\"\nhistoryAppend=\"histappend\"\nhistorySize=10000\nhistoryFileSize=200000\ndirectoryHistorySize=15\n\n# Keyboard Shortcuts\nkbClear=\"\\ec\" # Alt-C clears screen\nkbDirJump=\"\\ed\" # Alt-D directory history list\nkbReload=\"\\er\" # Alt-R reloads environment\nkbVersion=\"\\ev\" # Alt-V show Distro and version information\nkbWhoIs=\"\\ew\" # Alt-W show who information\nkbHelpFKey=\"\\eOP\" # F1 will display help system\nkbHelp=\"\\eh\" # Alternitive (Alt-H) for help if F1 is not available\nkbSpashscreenFKey=\"\\eOQ\" # F2 will display the spashscreen\nkbSpashscreen=\"\\es\" # Alternitive (Alt-S) for splashscreen if F2 is not available\n\n# Alias Shortcuts\ndirjumpCommand=\"d\"\n" > "${scriptLocation}/bin/bash.conf"
			source "${scriptLocation}/bin/bash.conf"
		fi
	else
		printf "# Created by Enhanced BASH Installer on $(LC_ALL=C date +'%Y-%m-%d %H:%M:%S')\n\n# Editor\neditor=\"nano\"\n\n# Themes\nprompt_theme=\"pureblack\"\n\n# Default Files\nlogFile=\"startup.log\"\ndirListFile=\"directory_list\"\ndirLastRemoveFile=\"last_dir_remove\"\n\n# Folders\ndirSeperator=\"/\"\nbinSubPath=\"bin\"\nlibSubPath=\"lib\"\nmodSubPath=\"modules\"\nlogsSubPath=\"logs\"\noverrideSubPath=\"overrides\"\nthemeSubPath=\"themes\"\narchiveSubPath=\".backup\"\ndirJumpPath=\"dirjump\"\ninstallationSubPath=\"enhanced-bash\"\n\n# History Settings\nhistoryControl=\"ignoreboth\"\nhistoryAppend=\"histappend\"\nhistorySize=10000\nhistoryFileSize=200000\ndirectoryHistorySize=15\n\n# Keyboard Shortcuts\nkbClear=\"\\ec\" # Alt-C clears screen\nkbDirJump=\"\\ed\" # Alt-D directory history list\nkbReload=\"\\er\" # Alt-R reloads environment\nkbVersion=\"\\ev\" # Alt-V show Distro and version information\nkbWhoIs=\"\\ew\" # Alt-W show who information\nkbHelpFKey=\"\\eOP\" # F1 will display help system\nkbHelp=\"\\eh\" # Alternitive (Alt-H) for help if F1 is not available\nkbSpashscreenFKey=\"\\eOQ\" # F2 will display the spashscreen\nkbSpashscreen=\"\\es\" # Alternitive (Alt-S) for splashscreen if F2 is not available\n\n# Alias Shortcuts\ndirjumpCommand=\"d\"\n" > "${scriptLocation}/bin/bash.conf"
		source "${scriptLocation}/bin/bash.conf"
	fi
}

bashConfig
[ -f "${scriptLocation}${dirSeperator}${binSubPath}${dirSeperator}log_system.sh" ] && source "${scriptLocation}${dirSeperator}${binSubPath}${dirSeperator}log_system.sh" || echo "Can not continue"
[ -f "${scriptLocation}${dirSeperator}${libSubPath}${dirSeperator}lib_colors" ] && source "${scriptLocation}${dirSeperator}${libSubPath}${dirSeperator}lib_colors"

# Define default directories
export binInstallLocation="${scriptLocation}${dirSeperator}${binSubPath}"
export libInstallLocation="${scriptLocation}${dirSeperator}${libSubPath}"
export modInstallLocation="${scriptLocation}${dirSeperator}${modSubPath}"
export orInstallLocation="${scriptLocation}${dirSeperator}${overrideSubPath}"
export thmInstallLocation="${scriptLocation}${dirSeperator}${themeSubPath}"
export logsInstallLocation="${binInstallLocation}${dirSeperator}${logsSubPath}"
export archiveInstallLocation="${binInstallLocation}${dirSeperator}${archiveSubPath}"
export backupInstallLocation="${HOME}${dirSeperator}.backup"
export userHomeLocation=$( getent passwd "${USER}" | cut -d: -f6 )

export dirJumpFolder="${binInstallLocation}${dirSeperator}${dirJumpPath}"
export directory_list="${binInstallLocation}${dirSeperator}${dirJumpPath}${dirSeperator}${dirListFile}"
export defaultInstallationLocation="${HOME}${dirSeperator}.local${dirSeperator}share${dirSeperator}applications${dirSeperator}${installationSubPath}"
export defaultSourceLocations=("${libInstallLocation}" "${modInstallLocation}" "${overridesInstallLocation}" "${themesInstallLocation}")
export defaultBackupLocation=("${backupInstallLocation}")

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
	cursorpos col 2; echo -e "${Cyan}8. ${Silver}Create the folder: ${Purple}${defaultBackupLocation}${txtReset}"
	cursorpos col 2; echo -e "${Cyan}9. ${Silver}Create the file: ${Purple}${HOME}/.local/bin/enhanced-bash-system/lib/dirjump/directory_list${txtReset}"
	cursorpos col 2; echo -e "${Cyan}10. ${Silver}Create the file: ${Purple}${HOME}/.local/bin/enhanced-bash-system/lib/dirjump/last_dir_remove${txtReset}"
	cursorpos col 2; echo -e "${Cyan}11. ${Silver}Copy the file: ${Purple}${HOME}/.local/bin/enhanced-bash-system/lib/enhanced-bash to log-rotate folder${txtReset}"
	cursorpos col 2; echo -e "${Cyan}12. ${Silver}Consider contributing from my Git Repo: ${SpringGreen3}https://${SpringGreen3}gitlab.com/${SpringGreen3}public_scope/${SpringGreen3}bash-projects/${DarkSeaGreen7}enhanced-bash-system.git${txtReset}"
	echo -e ${txtReset} && exit
fi

# Create the installation folder (default is $HOME/.local/bin/enhanced-bash/)
read -p "$(echo -e ${White}Enter installation location ${Red}[${SteelBlue2}${defaultInstallationLocation}${Red}]${Aqua}: ${txtReset})" defaultInstallBaseDirectory

if [[ ${defaultInstallBaseDirectory} == "" ]]; then
	export defaultInstallBaseDirectory="${HOME}${dirSeperator}.local${dirSeperator}share${dirSeperator}applications${dirSeperator}${installationSubPath}"
fi

export installDirectories=("${defaultInstallBaseDirectory}${dirSeperator}${libSubPath}" "${defaultInstallBaseDirectory}${dirSeperator}${modSubPath}" "${defaultInstallBaseDirectory}${dirSeperator}${logsSubPath}" "${defaultInstallBaseDirectory}${dirSeperator}${archiveSubPath}" "${defaultInstallBaseDirectory}${dirSeperator}${dirJumpPath}" "${defaultInstallBaseDirectory}${dirSeperator}${installationSubPath}" "${defaultBackupLocation}")

for installDirectory in ${installDirectories[*]}; do
	if [ ! -d "${installDirectory}" ]; then
		mkdir -p "${installDirectory}" > /dev/null 2>&1
		retVal=$?
		if [ $retVal -ne 0 ]; then
    		error "[Creating directory ${installDirectory}]" >> ${logsInstallLocation}${dirSeperator}installation.log
		else
			success "[Creating directory ${installDirectory}]" >> ${logsInstallLocation}${dirSeperator}installation.log
		fi
	fi
done

# make the overrides folder if it doesn't exist, we don't want to over write any existing overrides
if [ ! -d "${defaultInstallBaseDirectory}${dirSeperator}${overridesInstallLocation}" ]; then
	mkdir -p "${defaultInstallBaseDirectory}${dirSeperator}${overridesInstallLocation}" > /dev/null 2>&1
fi 

# Install the minimal dependancies - git curl highlight most
# TODO: Check to see if any exist and only install those that don't
packagesNeeded='jq git curl highlight most wget python3 python3-pip'
echo -e "${Red}NOTICE: ${Silver}This script will install ${Yellow}${packagesNeeded}${Silver} sudo will be requested, please enter your password.${txtReset}"

if [ -x "$(command -v apk)" ];       then sudo apk add --no-cache $packagesNeeded
elif [ -x "$(command -v apt-get)" ]; then sudo apt-get install $packagesNeeded
elif [ -x "$(command -v dnf)" ];     then sudo dnf install $packagesNeeded
elif [ -x "$(command -v zypper)" ];  then sudo zypper install $packagesNeeded
elif [ -x "$(command -v pkg)" ];  	 then sudo pkg install $packagesNeeded
else echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: $packagesNeeded">&2; fi

# Check and install some fonts for dependancies
[ ! -d "${userHomeLocation}${dirSeperator}.local${dirSeperator}share${dirSeperator}fonts${dirSeperator}" ] && mkdir -p "${userHomeLocation}${dirSeperator}.local${dirSeperator}share${dirSeperator}fonts${dirSeperator}"
if [ ! -f "${userHomeLocation}${dirSeperator}.local${dirSeperator}share${dirSeperator}fonts${dirSeperator}PowerlineSymbols.otf" ]; then
	wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
	mv PowerlineSymbols.otf "${userHomeLocation}${dirSeperator}.local${dirSeperator}share${dirSeperator}fonts${dirSeperator}"
fi	

[ ! -d "${userHomeLocation}${dirSeperator}.config${dirSeperator}fontconfig${dirSeperator}conf.d${dirSeperator}" ] && mkdir -p "${userHomeLocation}${dirSeperator}.config${dirSeperator}fontconfig${dirSeperator}conf.d${dirSeperator}"	
if [ ! -f "${userHomeLocation}${dirSeperator}.config${dirSeperator}fontconfig${dirSeperator}conf.d${dirSeperator}10-powerline-symbols.conf" ]; then
	wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
	mv 10-powerline-symbols.conf "${userHomeLocation}${dirSeperator}.config${dirSeperator}fontconfig${dirSeperator}conf.d${dirSeperator}"
fi

# Add the fonts to cache
fc-cache -vf ~/.local/share/fonts/

# TODO: Check if powerline-status exists
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
