#! /bin/bash
	
SNF_HOME=~/snf-tools

# Check disribution of host machine
CORRECT_DISTRO=`lsb_release -a 2>/dev/null | grep 'Ubuntu 12.04'`
if [ -z "$CORRECT_DISTRO" ]; then
	echo "Your distro is not Ubuntu 12.04. Leaving..."
	exit 0
fi

# Check cpu virtualization extensions
## TO-DO ##

# Install dependencies 
sudo apt-get install -y python-setuptools python-guestfs python-dialog python-virtualenv python-dev git

# Create virtual environment
if [ ! -e $SNF_HOME/image-creator-env ]; then
	virtualenv --system-site-packages $SNF_HOME/image-creator-env
	source $SNF_HOME/image-creator-env/bin/activate
fi

# Install kamaki
if [ ! -e $SNF_HOME/kamaki ]; then
	cd $SNF_HOME
	git clone https://code.grnet.gr/git/kamaki
	cd kamaki
	./setup.py build && ./setup.py install
fi

# Install snf-image-creator
if [ ! -e $SNF_HOME/snf-image-creator ]; then
	cd $SNF_HOME
	git clone https://code.grnet.gr/git/snf-image-creator
	cd snf-image-creator
	./setup.py build && ./setup.py install
fi

