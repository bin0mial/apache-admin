### Function to display Success Message
function displaySuccess {
	echo ${1} >> ${OUTPUT_PATH}
	echo "${GREEN}${1}${RESET_COLOR}" 
}

function displayFail {
	(echo ${1} >> ${ERROR_PATH}) 2> /dev/null
	echo "${RED}${1}${RESET_COLOR}"
}

function displayWarning {
	echo ${1} >> ${OUTPUT_PATH}
	echo "${YELLOW}${1}${RESET_COLOR}"
}

function displayIsLocalhost {
	echo -n "Toggle Hosting type " 
	if (isLocalhost)
	then
		displayWarning "(Hosted Locally is Enabled)"
	else
		displayWarning "(Hosted Locally is Disabled)"
	fi
}
