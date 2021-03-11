### Function Enabling Authentication and validating data entered 
###	Params:
###		1:SERVER_NAME
### 	Return Codes:
###		0: Successfull
###		1: Fail
function enableAuth {
	local SERVER_NAME=$1
	
	local ROOT_PATH="$V_HOSTS_DOCROOT_PARENT/$SERVER_NAME"
	local HTACCESS="$ROOT_PATH/$V_HOSTS_DOCROOT_POSTFIX/.htaccess"
	local HTPASSWORD="$ROOT_PATH/$AUTH_FILENAME"
	if (! checkFile ${ROOT_PATH} "d" )
	then
		mkdir -p ${ROOT_PATH};
	fi
	
	if (! checkFile ${HTACCESS} "f" )
	then
		touch ${HTACCESS}
	fi
	
	if (! checkFile ${HTPASSWORD} "f" || isEmpty $(cat ${HTPASSWORD}) )
	then
		local USERNAME
		read -p "Enter Auth username: " USERNAME
		if (! isEmpty $USERNAME)
		then
			htpasswd -c ${HTPASSWORD} ${USERNAME}
			if [[ $? -ne 0 ]]
			then
				return 1
			fi 
		else
			return 1
		fi
	fi
	
	if [[ $(cat ${HTACCESS} | grep "AuthType" | wc -l ) -eq 0 ]]
	then
		echo "AuthType Basic" >> $HTACCESS
		echo 'AuthName "Authentication Required"' >> $HTACCESS
		echo "AuthUserFile \"${HTPASSWORD}\"" >> $HTACCESS
		echo "Require valid-user" >> $HTACCESS
	fi
	
	return 0
	
	
}

### Function disabling Authentication and validating data entered then delete authentication text from .htaccess
###	Params:
###		1:SERVER_NAME
### 	Return Codes:
###		0: Successfull
###		1: Fail
function disableAuth {
	local SERVER_NAME=$1
	local ROOT_PATH="$V_HOSTS_DOCROOT_PARENT/$SERVER_NAME"
	local HTACCESS="$ROOT_PATH/$V_HOSTS_DOCROOT_POSTFIX/.htaccess"
	
	if (! checkFile ${HTACCESS} "f" )
	then
		return 1
	fi
	
	sed -i -e '/^AuthType/d' -e '/^AuthName/d' -e '/^AuthUserFile/d' -e '/^Require/d' ${HTACCESS}
	
	return 0
}


### Function adding Authentication user and validating data entered  
###	Params:
###		1:SERVER_NAME
### 	Return Codes:
###		0: Successfull
###		1: Something Went wrong while inserting
###		2: Invalid Parameters or file not found
function addAuthUser {
	local SERVER_NAME=$1
	local ROOT_PATH="$V_HOSTS_DOCROOT_PARENT/$SERVER_NAME"
	local HTPASSWORD="$ROOT_PATH/$AUTH_FILENAME"
	
	local USERNAME
	read -p "Enter Auth username: " USERNAME
	if (! checkFile ${HTPASSWORD} "f" )
	then
		return 4
	fi
	if ( isEmpty $USERNAME) && [[ $(cat ${HTPASSWORD} | egrep "^${USERNAME}:" | wc -l ) -ne 0 ]]
	then
		return 2
	fi
		
	if (! checkFile ${HTPASSWORD} "f" || isEmpty $(cat ${HTPASSWORD}) )
	then
		htpasswd -c ${HTPASSWORD} ${USERNAME}
		return $(test $? -eq 0 && echo 0 || echo 1)
	else
		htpasswd ${HTPASSWORD} ${USERNAME}
		return $(test $? -eq 0 && echo 0 || echo 1)
	fi
	
}

### Function Remove Authentication and validating data entered 
###	Params:
###		1:SERVER_NAME
### 	Return Codes:
###		0: Successfull
###		3: User not exist or file or empty username
function removeAuthUser {
	local SERVER_NAME=$1
	local ROOT_PATH="$V_HOSTS_DOCROOT_PARENT/$SERVER_NAME"
	local HTPASSWORD="$ROOT_PATH/$AUTH_FILENAME"
	
	local USERNAME
	read -p "Enter Auth username: " USERNAME
	if (! checkFile ${HTPASSWORD} "f" )
	then
		return 4
	fi
	if ( isEmpty $USERNAME) || ( checkFile ${HTPASSWORD} "f" ) && [[ $(cat ${HTPASSWORD} | grep "^${USERNAME}:" | wc -l ) -eq 0 ]]
	then
		return 3
	fi
	sed -i "/^${USERNAME}:/d" ${HTPASSWORD}
	return 0
}
