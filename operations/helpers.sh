### Function to display Success Message
function displaySuccess {
	echo "${GREEN}${1}${RESET_COLOR}"
}

function displayFail {
	echo "${RED}${1}${RESET_COLOR}"
}

function displayWarning {
	echo "${YELLOW}${1}${RESET_COLOR}"
}
