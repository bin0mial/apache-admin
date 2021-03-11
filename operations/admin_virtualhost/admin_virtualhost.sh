### Function to display current options for admin virutalhost
function displayAdminMenu {
	printf "\n\n"
	echo ">>>>>Admin VirtualHosts Menu<<<<<"
	echo "1. List VirtualHosts"
	echo "2. Add VirtualHost"
	echo "3. Delete VirtualHost"
	echo "4. Enable VirtualHost"
	echo "5. Disable VirtualHost"
	echo "6. Back to Main Menu"
	printf "\n"
}

### Function to admin virtual hosts displaying data and controlling it to list, add, remove, enable, disable virtualhost
### 	Return codes
###		1: Apache not installed
function displayAdminVirtualhostsOptions {
	if ! checkApacheExists
	then
		displayFail "Apache isn't installed on your System please install it from main menu before processing to script."
		return 1
	fi
	
	local CH
	while true
	do
		# Display Main menu
		displayAdminMenu
		
		read -p "Enter Your Choice: " CH
		
		case ${CH} in
			"1")
				listAvailableVirtualHosts
				;;
			"2")
				addVirtualHost
				;;
			"3")
				removeVirtualHost
				;;
			"4")
				enablingVirtualHost
				;;
			"5")
				disablingVirtualHost
				;;
			"6")
				break
				;;
			*)
				echo "Invalid Choice please try again."
		esac
	done
	
}


### Function to display Available VirtualHosts enabled and disabled

function listAvailableVirtualHosts {
	echo "________________________________________________"
	local V_HOSTS_ENABLED=$(ls $V_HOSTS_ENABLED_PATH)
	local FILTERED_VHOSTS=$( ls $V_HOSTS_PATH | grep -v "\(000-.*.conf\)\|\(default.*.conf\)")
	for FILTERED_VHOST in $FILTERED_VHOSTS
	do
		cat $V_HOSTS_PATH/$FILTERED_VHOST \
		| grep -v "Virtual" | sed -e "s/<\/Directory>//g" -e "s/<//g" -e "s/>//g" \
		| awk -v V_HOSTS_ENABLED="$V_HOSTS_ENABLED" \
		-f operations/admin_virtualhost/admin_virtualhost_list_awk
	done
}

### Function takes servername and serveradmin from user to create virtualhost and its root directory
###	Params
###		1-SERVER_NAME
###		2-SERVER_ADMIN <<Optional>>
function addVirtualHost {
	local SERVER_NAME
	local SERVER_ADMIN
	local FLAG=0;
	while ([ $FLAG -ne 2 ])
	do
		case ${FLAG} in
			"0")
				read -p "Please Enter Server Name: " SERVER_NAME
				# Validate Input and increase flag if it is true
				if (! isEmpty "$SERVER_NAME" )
				then
					if (! checkFile "$V_HOSTS_PATH/$SERVER_NAME.conf" "f")
					then
						FLAG=$((FLAG+1))
					else
						displayFail "Virutal Host already exists please choose another name."
					fi
				else
					displayFail "Invalid Server Name Provided"
				fi
				;;
			"1")
				read -p "Please Enter Your Email: " SERVER_ADMIN
				
				if (isEmpty $SERVER_ADMIN)
				then
					FLAG=$((FLAG+1))
				else
					if (isEmail $SERVER_ADMIN)
					then
						FLAG=$((FLAG+1))
					else
						displayFail "Invalid Email Supplied"
					fi
				fi
				;;
		esac
	done
	#### Create Virtual Host
	if ( createVirtualHost $SERVER_NAME $SERVER_ADMIN)
	then
		displaySuccess "${SERVER_NAME} virtual host has been created successfully."
	else
		displayFail "Something went wrong while creating ${SERVER_NAME}."
	fi
}

### Function takes servername from user to delete virtualhost and its root directory
###	Params
###		1-SERVER_NAME
function removeVirtualHost {
	local SERVER_NAME
	local CH
	read -p "Please Enter ServerName to delete: " SERVER_NAME
	if (! isEmpty "$SERVER_NAME" )
	then
		if (checkFile "$V_HOSTS_PATH/$SERVER_NAME.conf" "f")
		then
			echo -n $(displayWarning "Are you sure you want to remove VirtualHost with all its component? (Y/N) ")
			read CH
			if [ $CH == "Y" ] || [ $CH == "y" ]
			then
				if ( deleteVirtualHost $SERVER_NAME )
				then
					displaySuccess "VirtualHost with all its components have been removed successfully."
				else
					displayFail "Something went wrong while deleting VirtualHost please try again."
				fi
			else
				displayWarning "You have cancelled the operation."
			fi
		else
			displayFail "You have Typed Invalid ServerName."
		fi
	else
		displayFail "Empty ServerName Provided"
	fi

}

### Function takes servername from user to enable virtualhost
###	Params
###		1-SERVER_NAME
function enablingVirtualHost {
	local SERVER_NAME
	local CH
	read -p "Please Enter ServerName to enabled: " SERVER_NAME
	if (! isEmpty "$SERVER_NAME" )
	then
		if (checkFile "$V_HOSTS_PATH/$SERVER_NAME.conf" "f")
		then
			if ( enableVirtualHost $SERVER_NAME )
			then
				displaySuccess "VirtualHost has been enabled Successfully"
			else
				displayFail "Failed to enable VirtualHost."
			fi

		else
			displayFail "You have Typed Invalid ServerName."
		fi
	else
		displayFail "Empty ServerName Provided"
	fi

}

### Function takes servername from user to disable virtualhost
###	Params
###		1-SERVER_NAME
function disablingVirtualHost {
	local SERVER_NAME
	local CH
	read -p "Please Enter ServerName to disabled: " SERVER_NAME
	if (! isEmpty "$SERVER_NAME" )
	then
		if (checkFile "$V_HOSTS_PATH/$SERVER_NAME.conf" "f")
		then
			if ( disableVirtualHost $SERVER_NAME )
			then
				displaySuccess "VirtualHost has been disabled Successfully"
			else
				displayFail "Failed to disabled VirtualHost."
			fi

		else
			displayFail "You have Typed Invalid ServerName."
		fi
	else
		displayFail "Empty ServerName Provided"
	fi

}



