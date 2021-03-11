function createVirtualHost {
	local SERVER_NAME=$1
	local SERVER_ADMIN=$2

	local CONFIG_FILE="${V_HOSTS_PATH}/${SERVER_NAME}.conf"
	local DOCUMENT_ROOT="${V_HOSTS_DOCROOT_PARENT}/${SERVER_NAME}/"
	local PUBLIC_HTML="${V_HOSTS_DOCROOT_PARENT}/${SERVER_NAME}/public_html"
	
	if (! isEmpty $SERVER_ADMIN)
	then
		SERVER_ADMIN="ServerAdmin ${SERVER_ADMIN}"
	fi
	
	mkdir -p ${PUBLIC_HTML}
	chown -R www-data: ${DOCUMENT_ROOT}
	touch ${CONFIG_FILE}
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

function enableVirtualHost {
	local SERVER_NAME=$1
	local ENABLED_PATH="$V_HOSTS_ENABLED_PATH/$SERVER_NAME.conf"
	if(! checkFile ${ENABLED_PATH} "f" )
	then
		a2ensite "${SERVER_NAME}" >> ${OUTPUT_PATH} 2>> ${ERROR_PATH}
		service apache2 restart >> ${OUTPUT_PATH} 2>> ${ERROR_PATH}
	fi
	return 0
}

function disableVirtualHost {
	local SERVER_NAME=$1
	local ENABLED_PATH="$V_HOSTS_ENABLED_PATH/$SERVER_NAME.conf"
	if( checkFile ${ENABLED_PATH} "f" )
	then
		a2dissite "${SERVER_NAME}" >> ${OUTPUT_PATH} 2>> ${ERROR_PATH}
		service apache2 restart >> ${OUTPUT_PATH} 2>> ${ERROR_PATH}
	fi
	return 0
}
