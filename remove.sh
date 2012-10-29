#! /bin/bash

# Clear virtual environment - NOT WORKING ATM
`deactivate 2>/dev/null`

# Delete everything
if [ ! -e ~/snf-tools ]; then
	echo "Nothing to destroy. Leaving..."
	exit 0
fi	
sudo -rf ~/snf-tools
