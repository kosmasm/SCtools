#!/bin/bash
[ -f /usr/bin/expect ] || { echo Utility expect does not exist. Exiting; exit 1; }

[ "$1" == "" ] && {
        echo No parameters given.
        echo Ussage: copy-keys.sh *username *password *host1 *hostxx
        echo Where username the user to ssh to remote machine.
        echo and password the ssh password for the user.
        echo after that, a list of hosts seperated by spaces
        echo Exiting.
        exit 1;
}
[ "$2" == "" ] && { echo No password given. Exiting; exit 1; }
[ "$3" == "" ] && { echo No Hosts given. Exiting; exit 1; }
user=$1
pass=$2
shift;shift
for a in $@; do 
	echo ssh-keyscan -t rsa,dsa $a >> ~/.ssh/authorized_keys
	sshpass -p "$pass" ssh-copy-id $user@$a
done
