#!bash/bin

#### Script to admin whole apache server
###	Exit codes
###		0: Normal termination

### Script Version
VERSION="1.0.0"

### Config Colors
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
RESET_COLOR=`tput sgr0`

### Log Files Dir and Paths
LOG_DIR="/tmp/apache_controller_v${VERSION}"
OUTPUT_PATH="${LOG_DIR}/out.log"
ERROR_PATH="${LOG_DIR}/error.log"


### Create log directory if not exist and Log file paths
mkdir -p /tmp/apache_controller_v1/

### Import sources
source ./operations/helpers.sh
source ./operations/checker.sh
source ./operations/apache_installation.sh
source ./operations/admin_virtualhost.sh
source ./operations/config_authentication.sh
source menuOp.sh



### Display Greeting Message
greeting

### Displaying menu.
runMenu

### Goodbye Message
goodbye

exit 0
