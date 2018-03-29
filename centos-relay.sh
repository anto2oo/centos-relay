#!/bin/bash

# Defining printf colors
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

# Check if run as root
if [ "$EUID" -ne 0 ]
  then printf "${red}Please run as root${end}\\n"
  exit
else
	printf "Take a look at what this script is going to do :\\n - Install tor from epel-release and setup correct permissions for toranon user\\n - Install python pip and the nyx monitoring software (allows you to monitor your relay)\\n - Install fail2ban to prevent bruteforce attacks on your server\\n\\nPress ${grn}enter${end} to continue\\n"
	read -p ""
fi

# Installing epel and tor
printf "${yel}[in progress]${end} Installing Tor\\n"
yum -y install epel-release 
yum -y install tor
chown -R toranon /run/tor/
chown -R toranon /var/lib/tor/
printf "${grn}[done]${end} Installed tor\\n"

# If pip is not installed, install it
pip -V &> /dev/null
if [ $? -eq 0 ]; then
    printf "${grn}[ok]${end} pip already installed\\n"
else
    printf "${yel}[in progress]${end}\ Installing pip\n"
	wget https://bootstrap.pypa.io/get-pip.py
	python get-pip.py
	printf "${grn}[done]${end} Installed pip\\n"
fi

# Installing nyx
printf "${yel}[in progress]${end} Installing nyx\\n"
pip install nyx
printf "${grn}[done]${end} Installed nyx\\n"

# Installing fail2ban
printf "${yel}[in progress]${end} Installing fail2ban\\n"
yum -y install fail2ban
systemctl enable fail2ban
printf "${grn}[done]${end} Installed fail2ban\\n"

# Everything is okay
printf "${grn}Done. What now ?${end}\\n - Configure your relay by editing ${cyn}/etc/tor/torrc${end}\\n - Start tor using ${cyn}su -l toranon -s /bin/bash -c \"tor --runasdaemon 1\"${end}\\n - Monitor your relay by running ${cyn}nyx${end}\\n"



