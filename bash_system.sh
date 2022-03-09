#!/usr/bin/env bash
# title					:BASHRC System
# description			:This is a start up script to make your bash experience useful
# author				:Jessica Brown
# date					:2019-12-20
# version				:4.0.0
# usage					:After install, just open a terminal
# notes					:This script is self installing
# bash_version	:4.1.5(1)-release
# ==============================================================================
# TODO:
#	DONE - 1. Currently it checks if the directory extists then files should be expected
#	          this should change to check for files instead
#	MOVED -2. Check screen width for small screens (like cell phones) with terminal
#	DONE - 3. dirjump needs to become a module, not a library.
#	DONE - 4. Mixture of dirjump variables located in this file, they should be moved to the dirjump module.
#	DONE - 5. Looking over this code, it looks as if the lib_utils library is loaded twice
#	DONE - 6. Clean up script for easier to find and read, this should be just a controller
#	          to load each of the libraries, modules and overrides.
#	DONE - 7. Variables should be loaded from a library file, except path locations
#	DONE - 8. Create a config file for users to easily change custom variables

scriptLocation="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[ -f "${scriptLocation}/bin/log_system.sh" ] && source "${scriptLocation}/bin/log_system.sh" || echo "System files are not found, installation was not successful."
[ -f "${scriptLocation}/bin/bash.conf" ] && source "${scriptLocation}/bin/bash.conf" || echo "The configuration file could not be found."

export binLocation="${scriptLocation}${dirSeparator}${binSubPath}"
export libLocation="${scriptLocation}${dirSeparator}${libSubPath}"
export modLocation="${scriptLocation}${dirSeparator}${modSubPath}"
export orLocation="${scriptLocation}${dirSeparator}${overrideSubPath}"
export thmLocation="${scriptLocation}${dirSeparator}${themeSubPath}"
export logsLocation="${scriptLocation}${dirSeparator}${logsSubPath}"
export archiveLocation="${HOME}${dirSeparator}${archiveSubPath}"
export userHomeLocation=$( getent passwd "${USER}" | cut -d: -f6 )

defaultSourceLocations=("${libLocation}" "${modLocation}" "${orLocation}" "${thmLocation}")

for folder in ${defaultSourceLocations[*]}; do
	if [[ -d ${folder} ]]; then
		for file in ${folder}/???_*; do
			if [[ -f ${file} ]]; then
				source "${file}"
				success "[Loading ${file}]" >> ${logsLocation}/startup.log
			fi
		done
	fi
done

# Load the preload from the lib_sharedFunctions
__preload