#!bash/bin

#### Script to admin whole apache server
###	Exit codes
###		0: Normal termination


### Works locally
LOCALHOST=0
LOCALHOST_IP="127.0.0.1"

### Script Version
VERSION="1.0.0"

### Config Colors
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
RESET_COLOR=`tput sgr0`

### Log Files Dir and Other Files Paths
HOST_FILE_PATH="/etc/hosts"
AUTH_FILENAME=".htpasswd"
LOG_DIR="/var/log/apache_controller_v${VERSION}"
V_HOSTS_PATH="/etc/apache2/sites-available"
V_HOSTS_ENABLED_PATH="/etc/apache2/sites-enabled"
V_HOSTS_DOCROOT_PARENT="/var/www"
V_HOSTS_DOCROOT_POSTFIX="public_html"
OUTPUT_PATH="${LOG_DIR}/out.log"
ERROR_PATH="${LOG_DIR}/error.log"


### Create log directory if not exist and Log file paths
mkdir -p ${LOG_DIR}

### Import sources
source ./operations/helpers.sh
source ./operations/checker.sh
source ./operations/apache_installation/apache_installation.sh
source ./operations/admin_virtualhost/admin_virtualhost_helper.sh
source ./operations/admin_virtualhost/admin_virtualhost.sh
source ./operations/config_authentication/config_authentication_helper.sh
source ./operations/config_authentication/config_authentication.sh
source menuOp.sh



### Display Greeting Message
greeting

### Displaying menu.
runMenu

### Goodbye Message
goodbye

exit 0
