#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################
clear
# izin
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
CEKEXPIRED () {
    today=$(date -d +1day +%Y-%m-%d)
    Exp1=$(curl -sS https://raw.githubusercontent.com/awanklod/jual/main/izinnya | grep $MYIP | awk '{print $3}')
    if [[ $today < $Exp1 ]]; then
    echo -e "\e[32mSTATUS SCRIPT AKTIF...\e[0m"
    else
    echo -e "\e[31mSCRIPT ANDA EXPIRED!\e[0m";
    exit 0
fi
}
IZIN=$(curl -sS https://raw.githubusercontent.com/awanklod/jual/main/izinnya | awk '{print $4}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
echo -e "\e[32mPermission Accepted...\e[0m"
CEKEXPIRED
else
echo -e "\e[31mPermission Denied!\e[0m";
exit 0
fi

clear
# Getting

domain=$(cat /etc/xray/domain)
sldomain=$(cat /root/nsdomain)
cdndomain=$(cat /root/awscdndomain)
slkey=$(cat /etc/slowdns/server.pub)
clear

echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}        ⇱ USERNEW SSH  ACCOUNT ⇲        ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (hari): " masaaktif

IP=$(curl -sS ifconfig.me);
ossl=`cat /root/log-install.txt | grep -w "OpenVPN" | cut -f2 -d: | awk '{print $6}'`
opensh=`cat /root/log-install.txt | grep -w "OpenSSH" | cut -f2 -d: | awk '{print $1}'`
db=`cat /root/log-install.txt | grep -w "Dropbear" | cut -f2 -d: | awk '{print $1,$2}'`
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
#portsshws=`cat ~/log-install.txt | grep -w "SSH Websocket" | cut -d: -f2 | awk '{print $1}'`
wsssl=`cat /root/log-install.txt | grep -w "SSH SSL Websocket" | cut -d: -f2 | awk '{print $1}'`
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
#ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
#ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
#ovpn4="$(cat ~/log-install.txt | grep -w "OpenVPN SSL" | cut -d: -f2|sed 's/ //g')

OhpSSH=`cat /root/log-install.txt | grep -w "OHP SSH" | cut -d: -f2 | awk '{print $1}'`
OhpDB=`cat /root/log-install.txt | grep -w "OHP DBear" | cut -d: -f2 | awk '{print $1}'`
OhpOVPN=`cat /root/log-install.txt | grep -w "OHP OpenVPN" | cut -d: -f2 | awk '{print $1}'`

systemctl stop client-sldns
systemctl stop server-sldns
pkill sldns-server
pkill sldns-client
systemctl enable client-sldns
systemctl enable server-sldns
systemctl start client-sldns
systemctl start server-sldns
systemctl restart client-sldns
systemctl restart server-sldns

useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
PID=`ps -ef |grep -v grep | grep sshws |awk '{print $2}'`

if [[ ! -z "${PID}" ]]; then
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}" | tee -a /etc/log-create-user.log
echo -e "${BIWhite}              ⇱ SSH  ACCOUNT ⇲           ${NC}" | tee -a /etc/log-create-user.log
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}" | tee -a /etc/log-create-user.log
echo -e "Username    : $Login" | tee -a /etc/log-create-user.log
echo -e "Password    : $Pass" | tee -a /etc/log-create-user.log
echo -e "Expired On  : $exp" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "IP          : $IP" | tee -a /etc/log-create-user.log
echo -e "Host        : $domain" | tee -a /etc/log-create-user.log
echo -e "PubKey      : $slkey" | tee -a /etc/log-create-user.log 
echo -e "Nameserver  : $sldomain" | tee -a /etc/log-create-user.log
echo -e "SlowDNS port: 53,5300,8080" | tee -a /etc/log-create-user.log
echo -e "OpenSSH     : $opensh" | tee -a /etc/log-create-user.log
echo -e "SSH WS      : 80, 8080" | tee -a /etc/log-create-user.log
echo -e "SSH SSL WS  : $wsssl" | tee -a /etc/log-create-user.log
echo -e "OVPN WS     : 2086" | tee -a /etc/log-create-user.log
echo -e "OVPN SSL    : 442" | tee -a /etc/log-create-user.log
echo -e "OVPN TCP    : 1194" | tee -a /etc/log-create-user.log
echo -e "OVPN UDP    : 2200" | tee -a /etc/log-create-user.log
echo -e "SSL/TLS     : $ssl" | tee -a /etc/log-create-user.log
echo -e "UDPGW       : 7100-7900" | tee -a /etc/log-create-user.log
echo -e "UDP USER    : $domain:1-65535@$Login:$Pass" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "${GARIS}◇━━━━━ OpenVPN ━━━━━◇${NC}"
echo -e "OVPN WS SSL : http://$IP:81/ws-ssl.ovpn"
echo -e "OVPN TCP    : http://$IP:81/tcp.ovpn"
echo -e "OVPN UDP    : http://$IP:81/udp.ovpn"
echo -e "OVPN SSL    : http://$IP:81/ssl.ovpn"
echo -e "${GARIS}◇━━━━━━━━━━━━━━━━━◇${NC}"
echo -e "Payload WSS" | tee -a /etc/log-create-user.log
echo -e "
GET wss://isi_bug_disini HTTP/1.1[crlf]Host: ${domain}[crlf]Upgrade: websocket[crlf][crlf]
" | tee -a /etc/log-create-user.log
echo -e "Payload WS" | tee -a /etc/log-create-user.log
echo -e "
GET / HTTP/1.1[crlf]Host: $domain[crlf]Upgrade: websocket[crlf][crlf]
" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
else

echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "\E[0;41;36m            SSH Account            \E[0m" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "Username    : $Login" | tee -a /etc/log-create-user.log
echo -e "Password    : $Pass" | tee -a /etc/log-create-user.log
echo -e "Expired On  : $exp" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "IP          : $IP" | tee -a /etc/log-create-user.log
echo -e "Host        : $domain" | tee -a /etc/log-create-user.log
echo -e "PubKey      : $slkey" | tee -a /etc/log-create-user.log 
echo -e "Nameserver  : $sldomain" | tee -a /etc/log-create-user.log
echo -e "SlowDNS port: 53,5300,8080" | tee -a /etc/log-create-user.log
echo -e "OpenSSH     : $opensh" | tee -a /etc/log-create-user.log
echo -e "SSH WS      : 80, 8080" | tee -a /etc/log-create-user.log
echo -e "SSH SSL WS  : $wsssl" | tee -a /etc/log-create-user.log
echo -e "OVPN WS     : 2052" | tee -a /etc/log-create-user.log
echo -e "OVPN SSL    : 442" | tee -a /etc/log-create-user.log
echo -e "OVPN TCP    : 1194" | tee -a /etc/log-create-user.log
echo -e "OVPN UDP    : 2200" | tee -a /etc/log-create-user.log
echo -e "SSL/TLS     : $ssl" | tee -a /etc/log-create-user.log
echo -e "UDPGW       : 7100-7900" | tee -a /etc/log-create-user.log
echo -e "UDP USER    : $domain:1-65535@$Login:$Pass" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "Expired On     : $exp" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "${GARIS}◇━━━━━ OpenVPN ━━━━━◇${NC}"
echo -e "OVPN WS SSL : http://$IP:81/ws-ssl.ovpn"
echo -e "OVPN TCP    : http://$IP:81/tcp.ovpn"
echo -e "OVPN UDP    : http://$IP:81/udp.ovpn"
echo -e "OVPN SSL    : http://$IP:81/ssl.ovpn"
echo -e "${GARIS}◇━━━━━━━━━━━━━━━━━◇${NC}"
echo -e "Payload WSS" | tee -a /etc/log-create-user.log
echo -e "
GET wss://isi_bug_disini HTTP/1.1[crlf]Host: ${domain}[crlf]Upgrade: websocket[crlf][crlf]
" | tee -a /etc/log-create-user.log
echo -e "Payload WS" | tee -a /etc/log-create-user.log
echo -e "
GET / HTTP/1.1[crlf]Host: $domain[crlf]Upgrade: websocket[crlf][crlf]
" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
fi
echo "" | tee -a /etc/log-create-user.log
read -n 1 -s -r -p "Press any key to back on menu"
menu
