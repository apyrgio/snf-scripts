#! /bin/bash

# Clear virtual environment
deactivate 2>/dev/null

# Delete everything
if [ ! -e /home/"`logname`"/snf-tools ]; then
	echo "Nothing to destroy. Leaving..."
	return 0
fi	
sudo rm -rf /home/"`logname`"/snf-tools
echo "All snf related tools have been removed."
