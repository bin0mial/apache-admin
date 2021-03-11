### Function to display Success Message
function displaySuccess {
	echo ${1} >> ${OUTPUT_PATH}
	echo "${GREEN}${1}${RESET_COLOR}" 
}

function displayFail {
	echo ${1} >> ${ERROR_PATH}
	echo "${RED}${1}${RESET_COLOR}"
}

function displayWarning {
	echo ${1} >> ${OUTPUT_PATH}
	echo "${YELLOW}${1}${RESET_COLOR}"
}
