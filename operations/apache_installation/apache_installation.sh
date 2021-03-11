### Function to display Apache Options
function displayApacheInstallationOptions {
	local CH
	if checkApacheExists 
	then
		read -p "Apache already installed on your system, do you want to uninstall? (Y/N): "  CH
		if [ $CH == "Y" ] || [ $CH == "y" ]
		then
			if uninstallApache
			then
				displaySuccess "Apache has been uninstalled successfully."
			else
				displayFail "Something went wrong while uninstalling apache please check logs."
			fi
		fi
	else
		read -p "Apache isn't installed on your system, do you want to install it? (Y/N)" CH
		if [ $CH == "Y" ] || [ $CH == "y" ]
		then
			if installApache
			then
				displaySuccess "Apache has been installed successfully."
			else
				displayFail "Something went wrong while installing apache please check logs."
			fi
		fi
	fi
}

### Function to uninstall apache
###	Return Codes
###		0: Successfully Uninstalled
###		1: Failed to Uninstalled
function uninstallApache {
	apt-get purge -y apache2 >> ${OUTPUT_PATH} 2>> ${ERROR_PATH}
	if checkApacheExists
	then
		return 1
	else
		return 0
	fi
}

### Function to install apache
###	Return Codes
###		0: Successfully Installed
###		1: Failed to Installed
function installApache {
	apt-get install -y apache2 >> ${OUTPUT_PATH} 2>> ${ERROR_PATH}
	if checkApacheExists
	then
		return 0
	else
		return 1
	fi
}
