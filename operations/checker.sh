### Function to check whether user is root or not
###	Return codes
###		0: Is root
###		1: Isn't root
function isRoot {
	if  [ $(whoami) == "root" ]
	then
		return 0
	else 
	  	return 1
	fi
}

### Function to check whether apache server is installed or not
###	Return codes 
###		0: Exists
###		1: Not Exist
function checkApacheExists {
	if service --status-all | grep -Fq 'apache2'
	then
		return 0
	else
		return 1
	fi
}
