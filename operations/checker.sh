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

### Function takes 
##	1-File name
##	2-Type of check
### Call: checkFile "/etc/passwd" "f" 3
##	  checkFile "/etc/passwd" "r" 4
function checkFile {
	FILENAME=${1}
	CHECK=${2}
	if [ ! -${CHECK} ${FILENAME} ] 
	then
		return 1
	else
		return 0
	fi
}

### Function takes
#	1-Data
### Check if the data is int or no
function isInt {
	NUM=${1}
	if [ $(echo ${NUM} | grep "[^0-9] | wc -l") -ne 0 ] 
	then
		return 1
	else
		return 0
	fi
}

### Function check for an email is valid email or no
##	1:Email
function isEmail {
	DATA=${1}
	### Write regular expression check for an email
	if [ $(echo ${DATA} | egrep "[.]*@[a-zA-Z0-9_.]*.(com|org|net)" | wc -l ) -eq 0 ]
	then
		return 1
	else
		return 0
	fi
}


### Function check for an variable is empty or no
##	1:Variable
function isEmpty {
	DATA=${1}
	if [[ -z ${DATA} ]]
	then
		return 0
	else
		return 1
	fi
}
