### Function to display main menu
function displayMainMenu {
	printf "\n\n"
	echo "=====Main Menu====="
	echo "1. Install/Remove Apache Webserver"
	echo "2. Administrate Virtualhost"
	echo "3. Configure Authentiation"
	echo "4. Quit"
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
		
		case ${CH} in
			"1")
				displayApacheInstallationOptions
				;;
			"2")
				displayAdminVirtualhostsOptions
				;;
			"3")
				displayAuthenticationOptions
				;;
			"4")
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
