#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

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
IP=$(curl -sS ifconfig.me);
ossl=`cat /root/log-install.txt | grep -w "OpenVPN" | cut -f2 -d: | awk '{print $6}'`
opensh=`cat /root/log-install.txt | grep -w "OpenSSH" | cut -f2 -d: | awk '{print $1}'`
db=`cat /root/log-install.txt | grep -w "Dropbear" | cut -f2 -d: | awk '{print $1,$2}'`
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
portsshws=`cat ~/log-install.txt | grep -w "SSH Websocket" | cut -d: -f2 | awk '{print $1}'`
#wsssl=`cat /root/log-install.txt | grep -w "SSH SSL Websocket" | cut -d: -f2 | awk '{print $1}'`
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
#ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
#ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
#ovpn4="$(cat ~/log-install.txt | grep -w "OpenVPN SSL" | cut -d: -f2|sed 's/ //g')

OhpSSH=`cat /root/log-install.txt | grep -w "OHP SSH" | cut -d: -f2 | awk '{print $1}'`
OhpDB=`cat /root/log-install.txt | grep -w "OHP DBear" | cut -d: -f2 | awk '{print $1}'`
OhpOVPN=`cat /root/log-install.txt | grep -w "OHP OpenVPN" | cut -d: -f2 | awk '{print $1}'`

Login=trial-ssh`</dev/urandom tr -dc 0-9 | head -c4`
hari="1"
Pass=1
echo Ping Host
echo Create Akun: $Login
sleep 0.5
echo Setting Password: $Pass
sleep 0.5
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
PID=`ps -ef |grep -v grep | grep sshws |awk '{print $2}'`

if [[ ! -z "${PID}" ]]; then
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}           ⇱ TRIAL SSH  ACCOUNT ⇲        ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
echo -e "Username    : $Login"
echo -e "Password    : $Pass"
echo -e "Expired On  : $exp"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "IP          : $IP"
echo -e "Host        : $domain"
echo -e "PubKey      : $slkey"
echo -e "Nameserver  : $sldomain"
echo -e "SlowDNS port: 53,5300,8080"
echo -e "OpenSSH     : $opensh"
echo -e "SSH WS      : 80, 8080"
echo -e "SSH SSL WS  : $wsssl"
echo -e "OVPN WS     : 2086"
echo -e "OVPN SSL    : 442"
echo -e "OVPN TCP    : 1194"
echo -e "OVPN UDP    : 2200"
echo -e "SSL/TLS     : $ssl"
echo -e "UDPGW       : 7100-7900"
echo -e "UDP USER    : $domain:1-65535@$Login:$Pass"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "${GARIS}◇━━━━━ OpenVPN ━━━━━◇${NC}"
echo -e "OVPN WS SSL : http://$IP:81/ws-ssl.ovpn"
echo -e "OVPN TCP    : http://$IP:81/tcp.ovpn"
echo -e "OVPN UDP    : http://$IP:81/udp.ovpn"
echo -e "OVPN SSL    : http://$IP:81/ssl.ovpn"
echo -e "${GARIS}◇━━━━━━━━━━━━━━━━━◇${NC}"
echo -e "Payload WSS"
echo -e "GET wss://isi_bug_disini HTTP/1.1[crlf]Host: ${domain}[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Payload WS"
echo -e "GET / HTTP/1.1[crlf]Host: $domain[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

else

echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}           ⇱ TRIAL SSH  ACCOUNT ⇲        ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
echo -e "Username    : $Login"
echo -e "Password    : $Pass"
echo -e "Expired On  : $exp"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "IP          : $IP"
echo -e "Host        : $domain"
echo -e "PubKey      : $slkey"
echo -e "Nameserver  : $sldomain"
echo -e "SlowDNS port: 53,5300,8080"
echo -e "OpenSSH     : $opensh"
echo -e "SSH WS      : 80, 8080"
echo -e "SSH SSL WS  : $wsssl"
echo -e "OVPN WS     : 2086"
echo -e "OVPN SSL    : 442"
echo -e "OVPN TCP    : 1194"
echo -e "OVPN UDP    : 2200"
echo -e "SSL/TLS     : $ssl"
echo -e "UDPGW       : 7100-7900"
echo -e "UDP USER    : $domain:1-65535@$Login:$Pass"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "${GARIS}◇━━━━━ OpenVPN ━━━━━◇${NC}"
echo -e "OVPN WS SSL : http://$IP:81/ws-ssl.ovpn"
echo -e "OVPN TCP    : http://$IP:81/tcp.ovpn"
echo -e "OVPN UDP    : http://$IP:81/udp.ovpn"
echo -e "OVPN SSL    : http://$IP:81/ssl.ovpn"
echo -e "${GARIS}◇━━━━━━━━━━━━━━━━━◇${NC}"
echo -e "Payload WSS"
echo -e "GET wss://isi_bug_disini HTTP/1.1[crlf]Host: ${domain}[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Payload WS"
echo -e "GET / HTTP/1.1[crlf]Host: $domain[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
fi
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
