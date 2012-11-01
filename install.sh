#! /bin/bash
	
######### Initial checks #########
SNF_HOME=/home/"`logname`"/snf-tools
txtrst=$(tput sgr0) 	# Reset text color
txtred=$(tput setaf 1) 	# Make text red
txtgrn=$(tput setaf 2) 	# Make text green
mkdir -p $SNF_HOME 	# Create home folder

# Check linux disribution of host machine
CORRECT_DISTRO=`lsb_release -a 2>/dev/null | grep 'Ubuntu 12.04'`
if [ -z "$CORRECT_DISTRO" ]; then
	echo "${txtred}Your distro is not Ubuntu 12.04. ${txtrst}"
fi

# Check cpu virtualization extensions
SVM=`grep svm /proc/cpuinfo`
VMX=`grep vmx /proc/cpuinfo`
if [ -z "$SVM" ] && [ -z "$VMX" ]; then
	echo "${txtred}Your CPU does not support the recommended virtualization extensions${txtrst}"
fi

######### Install dependencies #########
sudo apt-get install -y python-setuptools python-guestfs python-dialog python-virtualenv python-dev python-gevent git

########## Create python virtual environment #########
if [ ! -e $SNF_HOME/image-creator-env ]; then
	virtualenv --system-site-packages $SNF_HOME/image-creator-env
	. $SNF_HOME/image-creator-env/bin/activate
else
	. $SNF_HOME/image-creator-env/bin/activate 2>/dev/null
fi	
echo "${txtgrn}The python virtual environment has been activated.${txtrst}"

######### Install snf-common #########
if [ ! -e $SNF_HOME/synnefo ]; then
	git clone https://code.grnet.gr/git/synnefo $SNF_HOME/synnefo	
fi
if [ ! -e $SNF_HOME/synnefo/snf-common/build ]; then	# not very sane
	cd $SNF_HOME/synnefo/snf-common
	python setup.py build && python setup.py install
	echo "${txtgrn}The snf-common tool has been installed${txtrst}"
else
	echo "${txtgrn}The snf-common tool has already been installed${txtrst}"
fi

######### Install kamaki #########
if [ ! -e $SNF_HOME/kamaki ]; then
	git clone https://code.grnet.gr/git/kamaki $SNF_HOME/kamaki
fi
if [ ! -e $SNF_HOME/image-creator-env/bin/kamaki ]; then
	cd $SNF_HOME/kamaki
	./setup.py build && ./setup.py install
	echo "${txtgrn}The kamaki tool has been installed${txtrst}"
else
	echo "${txtgrn}The kamaki tool has already been installed${txtrst}"
fi

######### Install snf-image-creator #########
if [ ! -e $SNF_HOME/snf-image-creator ]; then
	git clone https://code.grnet.gr/git/snf-image-creator $SNF_HOME/snf-image-creator
fi
if [ ! -e $SNF_HOME/image-creator-env/bin/snf-image-creator ]; then
	cd $SNF_HOME/snf-image-creator
	./setup.py build && ./setup.py install
	echo "${txtgrn}The snf-image-creator tool has been installed${txtrst}"
else
	echo "${txtgrn}The snf-image-creator tool has already been installed${txtrst}"
fi
