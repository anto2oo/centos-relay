# centos-relay

This script let you install a Tor relay on Centos 7.x. It is tested with versions 7.2 and 7.3.
**Important** : the installation on Centos 6.x will fail because of nyx supporting only python 2.7, which is not included by default in C6. You can update Python if you wish to install it anyway.
### What the script does :
* Install tor from epel-release and setup correct permissions for toranon user
* Install python pip and the nyx monitoring software (allows you to monitor your relay)
* Install fail2ban to prevent bruteforce attacks on your server
### Installation :
Download the script, then `chmod +x setup.sh` and `./centos-relay.sh`
### After installing :
- Configure your relay by editing `/etc/tor/torrc`
- Start tor using `su -l toranon -s /bin/bash -c "tor --runasdaemon 1"`
- Monitor your relay by runnin `nyx`
