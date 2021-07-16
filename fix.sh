#!/bin/sh
FOLDER=$(cd "$(dirname "$0")";pwd)
cp $FOLDER/ko/* /lib/modules/
cp $FOLDER/so/* /usr/lib/iptables/
cp $FOLDER/iptables_modules_list /usr/syno/etc.defaults/iptables_modules_list
synoservice --restart pkgctl-Docker