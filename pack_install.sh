#! /bin/bash

######### Initial checks #########
txtrst=$(tput sgr0) 	# Reset text color
txtred=$(tput setaf 1) 	# Make text red
txtgrn=$(tput setaf 2) 	# Make text green

# Check linux disribution of host machine
CORRECT_DISTRO=`cat /etc/*-release | grep 'Ubuntu 12.04'`
if [ -z "$CORRECT_DISTRO" ]; then
	echo "${txtred}Your distro is not Ubuntu 12.04. ${txtrst}"
	exit 1
fi

# Check cpu virtualization extensions
SVM=`grep svm /proc/cpuinfo`
VMX=`grep vmx /proc/cpuinfo`
if [ -z "$SVM" ] && [ -z "$VMX" ]; then
	echo "${txtred}Your CPU does not support the recommended virtualization extensions${txtrst}"
fi

######### Install dependencies #########
sudo apt-get install -y curl

########## Add apt.dev.grnet repo  #########
cd /etc/apt/sources.list.d
sudo rm -f apt.dev.grnet.gr.list

echo "deb http://apt.dev.grnet.gr precise main" | \
	sudo tee -a  apt.dev.grnet.gr.list
echo "deb-src http://apt.dev.grnet.gr precise main" | \
	sudo tee -a apt.dev.grnet.gr.list

sudo curl https://dev.grnet.gr/files/apt-grnetdev.pub | sudo apt-key add -

######## Verify proper addition of repo #########
sudo apt-get update

if ! apt-cache showpkg snf-image-creator > /dev/null 2>&1; then
	echo $?
	echo "${txtred}Repo installation failed.${txtrst}"
	exit 1
fi

######### Install snf-image-creator #########
sudo apt-get install -y snf-image-creator

if ! dpkg -s snf-image-creator > /dev/null 2>&1; then
	echo $?
	echo "${txtred}snf-image-creator installation failed.${txtrst}"
	exit 1
else
	echo "${txtgrn}snf-image-creator has been installed successfully${txtrst}"
fi
