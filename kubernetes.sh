#!/bin/bash
[ -f kube-hosts ] || exit 1;
for a in $(cat kube-hosts); do
  scp kube-install.sh root@${a}:/tmp
  ssh root@${a} "chmod 755 /tmp/kube-install.sh;/tmp/kube-install.sh"
done
