#!/bin/bash
function limit ip vmess(){
echo -n > /var/log/xray/vmess.log
sleep 2
data=( `ls /etc/funny/limit/vmess/ip`);
for user in "${data[@]}"
do
iplimit=$(cat /etc/funny/limit/vmess/ip/$user)
ehh=$(cat /var/log/xray/vmess.log | grep "$user" | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq | cut -d . -f 1-3 | sed s/127.0.0//g);
cekcek=$(echo -e "$ehh" | wc -l);
if [[ $cekcek -gt $iplimit ]]; then
disable-vmess  $user $cekcek $iplimit "$ehh"
nais=3
else
echo > /dev/null
fi
sleep 0.1
done
if [[ $nais -gt 1 ]]; then
systemctl restart vmess-ws
systemctl restart vmess-grpc
else
echo > /dev/null
fi
done
}
function limit ip vless(){
echo -n > /var/log/xray/vless.log
sleep 2
data=( `ls /etc/funny/limit/vless/ip`);
for user in "${data[@]}"
do
iplimit=$(cat /etc/funny/limit/vless/ip/$user)
ehh=$(cat /var/log/xray/vless.log | grep "$user" | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq | cut -d . -f 1-3 | sed s/127.0.0//g);
cekcek=$(echo -e "$ehh" | wc -l);
if [[ $cekcek -gt $iplimit ]]; then
disable-vless  $user $cekcek $iplimit "$ehh"
nais=3
else
echo > /dev/null
fi
sleep 0.1
done
if [[ $nais -gt 1 ]]; then
systemctl restart vless-ws
systemctl restart vless-grpc
else
echo > /dev/null
fi
done
}
function limit ip trojan(){
echo -n > /var/log/xray/trojan.log
sleep 2
data=( `ls /etc/funny/limit/trojan/ip`);
for user in "${data[@]}"
do
iplimit=$(cat /etc/funny/limit/trojan/ip/$user)
ehh=$(cat /var/log/xray/trojan.log | grep "$user" | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq | cut -d . -f 1-3 | sed s/127.0.0//g);
cekcek=$(echo -e "$ehh" | wc -l);
if [[ $cekcek -gt $iplimit ]]; then
disable-trojan  $user $cekcek $iplimit "$ehh"
nais=3
else
echo > /dev/null
fi
sleep 0.1
done
if [[ $nais -gt 1 ]]; then
systemctl restart trojan-ws
systemctl restart trojan-grpc
else
echo > /dev/null
fi
done
}
function limit ip shadowsocks(){
echo -n > /var/log/xray/shadowsocks.log
sleep 2
data=( `ls /etc/funny/limit/shadowsocks./ip`);
for user in "${data[@]}"
do
iplimit=$(cat /etc/funny/limit/shadowsocks./ip/$user)
ehh=$(cat /var/log/xray/shadowsocks.log | grep "$user" | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq | cut -d . -f 1-3 | sed s/127.0.0//g);
cekcek=$(echo -e "$ehh" | wc -l);
if [[ $cekcek -gt $iplimit ]]; then
disable-shadowsocks.  $user $cekcek $iplimit "$ehh"
nais=3
else
echo > /dev/null
fi
sleep 0.1
done
if [[ $nais -gt 1 ]]; then
systemctl restart shadowsocks.-ws
systemctl restart shadowsocks.-grpc
else
echo > /dev/null
fi
done
}
function limit ip ssh(){
mulog=$(member)
date=$(date)
data=( `ls /etc/kyt/limit/ssh/ip`);
for user in "${data[@]}"
do
iplimit=$(cat /etc/kyt/limit/ssh/ip/$user)
cekcek=$(echo -e "$mulog" | grep $user | wc -l);
if [[ $cekcek -gt $iplimit ]]; then
userdel -f -r $user
nais=3
echo -e "$waktu\nRemoved User: $user Login: $cekcek IP Max: $ip IP \n" >> /etc/kyt/log/ssh/ssh.log
else
echo > /dev/null
fi
sleep 0.1
done
if [[ $nais -gt 1 ]]; then
telegram-send --pre "$(log-ssh)" > /dev/null & 
else
echo > /dev/null
fi
done
}
if [[ ${1} == "vmess" ]]; then
vmess
elif [[ ${1} == "vless" ]]; then
vless
elif [[ ${1} == "trojan" ]]; then
trojan
elif [[ ${1} == "shadowsocks" ]]; then
shadowsocks
elif [[ ${1} == "ssh" ]]; then
ssh
fi
