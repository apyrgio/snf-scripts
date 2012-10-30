#! /bin/bash

# Clear virtual environment
deactivate 2>/dev/null

# Delete everything
if [ ! -e ~/snf-tools ]; then
	echo "Nothing to destroy. Leaving..."
	exit 0
fi	
sudo rm -rf ~/snf-tools
echo "All snf related tools have been removed."
