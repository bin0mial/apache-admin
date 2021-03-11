### Function Creating Virtual host and validating server name
### 	Return Codes:
###		0: Successfull
function createVirtualHost {
	local SERVER_NAME=$1
	local SERVER_ADMIN=$2

	local CONFIG_FILE="${V_HOSTS_PATH}/${SERVER_NAME}.conf"
	local DOCUMENT_ROOT="${V_HOSTS_DOCROOT_PARENT}/${SERVER_NAME}"
	local PUBLIC_HTML="${DOCUMENT_ROOT}/${V_HOSTS_DOCROOT_POSTFIX}"
	local HTACCESS="${PUBLIC_HTML}/.htaccess"
	
	if (! isEmpty $SERVER_ADMIN)
	then
		SERVER_ADMIN="ServerAdmin ${SERVER_ADMIN}"
	fi
	
	mkdir -p ${PUBLIC_HTML}
	chown -R www-data: ${DOCUMENT_ROOT}
	touch ${CONFIG_FILE}
	touch ${HTACCESS}
	echo "
<VirtualHost *:80>
	ServerName ${SERVER_NAME}
	ServerAlias www.${SERVER_NAME}
	${SERVER_ADMIN}
	DocumentRoot ${PUBLIC_HTML}
	 
	<Directory ${PUBLIC_HTML}>
		Options -Indexes +FollowSymLinks
		AllowOverride All
	</Directory>
	 
	ErrorLog \${APACHE_LOG_DIR}/example.com-error.log
	CustomLog \${APACHE_LOG_DIR}/example.com-access.log combined
</VirtualHost>
	" > ${CONFIG_FILE} 
	
	return 0
	
}


### Function Deleting Virtual host and validating server name
### 	Return Codes:
###		0: Successfull
function deleteVirtualHost {
	local SERVER_NAME=$1
	local CONFIG_FILE="${V_HOSTS_PATH}/${SERVER_NAME}.conf"
	local DOCUMENT_ROOT="${V_HOSTS_DOCROOT_PARENT}/${SERVER_NAME}/"
	local ENABLED_PATH="$V_HOSTS_ENABLED_PATH/$SERVER_NAME.conf"
	
	if( checkFile ${ENABLED_PATH} "f" )
	then
		a2dissite SERVER_NAME >> ${OUTPUT_PATH} 2>> ${ERROR_PATH}
	fi
	
	rm ${CONFIG_FILE} >> ${OUTPUT_PATH} 2>> ${ERROR_PATH}
	rm -Rf ${DOCUMENT_ROOT} >> ${OUTPUT_PATH} 2>> ${ERROR_PATH}
	
	service apache2 restart >> ${OUTPUT_PATH} 2>> ${ERROR_PATH}
 
	return 0
}

### Function Enabling Virtual host and validating server name and restarting aoache2
### 	Return Codes:
###		0: Successfull
function enableVirtualHost {
	local SERVER_NAME=$1
	local ENABLED_PATH="$V_HOSTS_ENABLED_PATH/$SERVER_NAME.conf"
	if(! checkFile ${ENABLED_PATH} "f")
	then	
		test $LOCALHOST -eq 0 && echo -e "${LOCALHOST_IP}\t${SERVER_NAME}\n${LOCALHOST_IP}\twww.${SERVER_NAME}" >> ${HOST_FILE_PATH}
		a2ensite "${SERVER_NAME}" >> ${OUTPUT_PATH} 2>> ${ERROR_PATH}
		service apache2 restart >> ${OUTPUT_PATH} 2>> ${ERROR_PATH}
	fi
	return 0
}

### Function disabling Virtual host and validating server name and restarting aoache2
### 	Return Codes:
###		0: Successfull
function disableVirtualHost {
	local SERVER_NAME=$1
	local ENABLED_PATH="$V_HOSTS_ENABLED_PATH/$SERVER_NAME.conf"
	if( checkFile ${ENABLED_PATH} "f" )
	then
		test $LOCALHOST -eq 0 && sed -i "/${SERVER_NAME}/d" ${HOST_FILE_PATH}
		a2dissite "${SERVER_NAME}" >> ${OUTPUT_PATH} 2>> ${ERROR_PATH}
		service apache2 restart >> ${OUTPUT_PATH} 2>> ${ERROR_PATH}
	fi
	return 0
}
