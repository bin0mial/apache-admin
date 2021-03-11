### Function to display main menu
function displayMainMenu {
	printf "\n\n"
	echo "=====Main Menu====="
	echo "1. $(displayIsLocalhost)"
	echo "2. Install/Remove Apache Webserver"
	echo "3. Administrate Virtualhost"
	echo "4. Configure Authentication"
	echo "5. Quit"
	printf "\n"
}

### Function to control Menu
### 	Exit Codes
###		1: Not a root
function runMenu {
	local CH
	
	### Validate User is root
	if (! isRoot )
	then
		displayFail "Please run script as a root" 
		exit 1
	fi
	
	while true
	do
		# Display Main menu
		displayMainMenu
		
		read -p "Enter Your Choice: " CH
		
		clear
		case ${CH} in
			"1")
				LOCALHOST=$(test $LOCALHOST -eq 0 && echo 1 || echo 0)
				;;
			"2")
				displayApacheInstallationOptions
				;;
			"3")
				displayAdminVirtualhostsOptions
				;;
			"4")
				displayAuthenticationOptions
				;;
			"5")
				break
				;;
			*)
				echo "Invalid Choice please try again."
		esac
	done
	
}


### Function to display greeting logo
function greeting {
	echo "
╔═══╗────────╔╗─────╔═══╗─╔╗
║╔═╗║────────║║─────║╔═╗║─║║
║║─║╠══╦══╦══╣╚═╦══╗║║─║╠═╝╠╗╔╦╦═╗
║╚═╝║╔╗║╔╗║╔═╣╔╗║║═╣║╚═╝║╔╗║╚╝╠╣╔╗╗
║╔═╗║╚╝║╔╗║╚═╣║║║║═╣║╔═╗║╚╝║║║║║║║║
╚╝─╚╣╔═╩╝╚╩══╩╝╚╩══╝╚╝─╚╩══╩╩╩╩╩╝╚╝
────║║
────╚╝
─────╔╗─╔═══╗╔═══╗
────╔╝║─║╔═╗║║╔═╗║
╔╗╔╗╚╗║─║║║║║║║║║║
║╚╝║─║║─║║║║║║║║║║
╚╗╔╝╔╝╚╦╣╚═╝╠╣╚═╝║
─╚╝─╚══╩╩═══╩╩═══╝
╔══╗───────╔╗──╔╗─────╔═══╗
║╔╗║───────║║──║║─────║╔═╗║
║╚╝╚╦╗─╔╗──║╠══╣╚═╦═╗─║║─╚╬══╦══╦═╦══╦══╗
║╔═╗║║─║║╔╗║║╔╗║╔╗║╔╗╗║║╔═╣║═╣╔╗║╔╣╔╗║║═╣
║╚═╝║╚═╝║║╚╝║╚╝║║║║║║║║╚╩═║║═╣╚╝║║║╚╝║║═╣
╚═══╩═╗╔╝╚══╩══╩╝╚╩╝╚╝╚═══╩══╩══╩╝╚═╗╠══╝
────╔═╝║──────────────────────────╔═╝║
────╚══╝──────────────────────────╚══╝
"
}

### Function to display good bye logo
function goodbye {
	echo "
╔══╦╗──────╔╗─╔═╦╗────╔══╗───╔╦╦═╦╗
╚╗╔╣╚╦═╗╔═╦╣╠╗╚╗║╠═╦╦╗║═╦╩╦╦╗║║║═╬╬═╦╦═╗
─║║║║║╬╚╣║║║═╣╔╩╗║╬║║║║╔╣╬║╔╝║║╠═║║║║║╬║
─╚╝╚╩╩══╩╩═╩╩╝╚══╩═╩═╝╚╝╚═╩╝─╚═╩═╩╩╩═╬╗║
─────────────────────────────────────╚═╝
╔══╗──────╔╗───╔══╗╔╗──╔╗
║╔╗╠═╦═╗╔═╣╚╦═╗║╔╗╠╝╠══╬╬═╦╗
║╠╣║╬║╬╚╣═╣║║╩╣║╠╣║╬║║║║║║║║
╚╝╚╣╔╩══╩═╩╩╩═╝╚╝╚╩═╩╩╩╩╩╩═╝
───╚╝
╔══╗───╔╗─╔╗────╔══╗
║╔╗╠╦╗─║╠═╣╚╦═╦╗║╔═╬═╦═╦╦╦═╦═╗
║╔╗║║║╔╣║╬║║║║║║║╚╗║╩╣╬║╔╣╬║╩╣
╚══╬╗║╚═╩═╩╩╩╩═╝╚══╩═╩═╩╝╠╗╠═╝
───╚═╝───────────────────╚═╝
"
}
