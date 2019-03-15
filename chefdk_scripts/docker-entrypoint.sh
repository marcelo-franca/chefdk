#!/bin/bash
#
# docker-entrypoint.sh - Install and configure chef-workstation on Unix
#
# Author     : Marcelo França <marcelo.frneves@gmail.com>
#
#  -------------------------------------------------------------
#   That's program get download of Chef Development Kit via URL added by
#   user in docker-compose, then install via dpkg if sha256
#   signature match, else send error message in console (STDOUT).
#
#  -------------------------------------------------------------
#
#
# Changelog:
#
#    v1.0 2019-02-28, Marcelo Franca:
#       - Creating a feature to get download of Chef Development Kit
#    v1.1 2019-03-13, Marcelo Franca:
#		    - Organizing statements of install and check chefdk into functions
#    v1.2 2019-03-14, Marcelo Franca:
#		    - Adding statement to check if chefdk has been successfully installed.
#    v1.3 2019-03-15, Marcelo Franca:
#				- Adding statement to send dpkg output to /dev/null
#       - Arranging shell scripts into directories and adding statements
#         dockerfiles
# Licence: Apache.
#
installchefdk() {
	dpkg -i $LOCAL_FILE > /dev/null 2>&1
	if [[ $? == 0 ]]; then
		echo "Installation has been completed!"
		rm -f $LOCAL_FILE
	else
		echo "The installation failure"
		exit 2
	fi
}

verifychef() {
	/usr/bin/chef verify
	if [[ $? == 0 ]]; then
		echo "ChefDK Verification completed"
		touch /.chefdk
		/bin/bash
	fi
}

if [[ -f /.chefdk ]]; then
	echo "ChefDK has been configured"
	/bin/bash
else
	echo -e "The ChefDK has not yet been installed.\n\n"
	echo -e "Starting the Installation...\n\n"
	sleep 5;
	installchefdk;
	echo -e "Now we will start the ChefDK Verification"
	verifychef;
fi
