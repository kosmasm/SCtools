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
rm hosts.a
for a in $@; do 
	ssh-keyscan -t rsa,dsa $a >> ~/.ssh/known_hosts
	sshpass -p "$pass" ssh-copy-id $user@$a
	ssh $user@$a "echo $pass|sudo cat /home/$user/.ssh/authorized_keys >> /root/.ssh/authorized_keys"
	echo 	ssh $user@$a "echo $pass|sudo cat /home/$user/.ssh/authorized_keys >> /root/.ssh/authorized_keys"
	echo -ne "${a}," >> hosts.a 
done
sed -i s/,$// hosts.a
