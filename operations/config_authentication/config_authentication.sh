### Function to display current options for aAuthentication using .htpassword
function displayAuthMenu {
	printf "\n\n"
	echo ">>>>>Authentication Menu<<<<<"
	echo "1. Enable Authentication"
	echo "2. Disable Authentication"
	echo "3. List Authenticated Users"
	echo "4. Add Authentication User"
	echo "5. Remove Authentication User"
	echo "6. Back to Main Menu"
	printf "\n"
}

### Function to admin Authentication enable, disable, add, remove
### 	Return codes
###		1: Apache not installed
function displayAuthenticationOptions {
	if ! checkApacheExists
	then
		displayFail "Apache isn't installed on your System please install it from main menu before processing to script."
		return 1
	fi
	
	local CH
	while true
	do
		# Display Main menu
		displayAuthMenu
		
		read -p "Enter Your Choice: " CH
		clear
		case ${CH} in
			"1")
				enablingAuthentication
				;;
			"2")
				disablingAuthentication
				;;
			"3")
				listAuthenticatedUsers
				;;
			"4")
				addingAuthenticatedUser
				;;
			"5")
				deletingAuthenticatedUser
				;;
			"6")
				break
				;;
			*)
				displayFail "Invalid Choice please try again."
		esac
	done
	
}

function commonConfigAuthentication {
	local SERVER_NAME
	read -p "Please Enter ServerName to ${2} Authentication: " SERVER_NAME
	if (! isEmpty "$SERVER_NAME" )
	then
		if (checkFile "$V_HOSTS_PATH/$SERVER_NAME.conf" "f")
		then
			$($1 $SERVER_NAME)
			case $? in
				"0")
					displaySuccess "Authenication for ${SERVER_NAME} has been ${2}${3}d Successfully"
					;;
				"1")				
					displayFail "Failed to ${2} authenication for ${SERVER_NAME} check parameters sent correctly."
					;;
				"2")
					displayFail "Username empty or already exists."
					;;
				"3")
					displayFail "Username empty or not exists."
					;;
				"4")
					displayFail "No data exists."
					;;
			esac

		else
			displayFail "You have Typed Invalid ServerName ${SERVER_NAME}."
		fi
	else
		displayFail "Empty ServerName Provided: ${SERVER_NAME}."
	fi
}

function enablingAuthentication {
	commonConfigAuthentication "enableAuth" "Enable"
}

function disablingAuthentication {
	commonConfigAuthentication "disableAuth" "Disable"
}

function listAuthenticatedUsers {
	local SERVER_NAME
	read -p "Please Enter ServerName to ${2} Authentication: " SERVER_NAME
	if (! isEmpty "$SERVER_NAME" )
	then
		if (checkFile "$V_HOSTS_PATH/$SERVER_NAME.conf" "f")
		then
			local ROOT_PATH="$V_HOSTS_DOCROOT_PARENT/$SERVER_NAME"
			local HTPASSWORD="$ROOT_PATH/$AUTH_FILENAME"
			if (! checkFile ${HTPASSWORD} "f" )
			then
				displayFail "No data exists."
			else
				displaySuccess "Current Users:"
				cat ${HTPASSWORD} | cut -d ":" -f 1
			fi
			
		else
			displayFail "You have Typed Invalid ServerName ${SERVER_NAME}."
		fi
	else
		displayFail "Empty ServerName Provided: ${SERVER_NAME}."
	fi
}

function addingAuthenticatedUser {
	commonConfigAuthentication "addAuthUser" "add" "e"
}

function deletingAuthenticatedUser {
	commonConfigAuthentication "removeAuthUser" "delete"
}
