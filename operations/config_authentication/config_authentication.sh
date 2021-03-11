### Function to display current options for aAuthentication using .htpassword
function displayAdminMenu {
	printf "\n\n"
	echo ">>>>>Authentication Menu<<<<<"
	echo "1. Enable Authentication"
	echo "2. Disable Authentication"
	echo "3. Add Authentication User"
	echo "4. Remove Authentication User"
	echo "5. Back to Main Menu"
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
		displayAdminMenu
		
		read -p "Enter Your Choice: " CH
		
		case ${CH} in
			"1")
				enablingAuthentication
				;;
			"2")
				disablingAuthentication
				;;
			"3")
				addingAuthenticatedUser
				;;
			"4")
				deletingAuthenticatedUser
				;;
			"5")
				break
				;;
			*)
				echo "Invalid Choice please try again."
		esac
	done
	
}

function enablingAuthentication {
	echo "Enable Authentication"
}

function disablingAuthentication {
	echo "Disable Authentication"
}

function addingAuthenticatedUser {
	echo "Add Authentication User"
}

function deletingAuthenticatedUser {
	echo "Remove Authentication User"
}
