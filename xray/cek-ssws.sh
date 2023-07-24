#!/bin/bash
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
cyan='\e[36m'
Lred='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
LIGHT='\033[0;37m'
grenbo="\e[92;1m"
clear
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
function con() {
local -i bytes=$1;
if [[ $bytes -lt 1024 ]]; then
echo "${bytes}B"
elif [[ $bytes -lt 1048576 ]]; then
echo "$(( (bytes + 1023)/1024 ))KB"
elif [[ $bytes -lt 1073741824 ]]; then
echo "$(( (bytes + 1048575)/1048576 ))MB"
else
echo "$(( (bytes + 1073741823)/1073741824 ))GB"
fi
}
echo -n > /tmp/other.txt
data=( `cat /etc/xray/config.json | grep '#ss#' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}        ⇱ SHADOWSOCKS USER LOGIN ⇲      ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
echo -e "   User"     "       Last Login"    "  Usage"   " Total IP"
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/ipshadowsocks.txt
data2=( `cat /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipshadowsocks.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipshadowsocks.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipshadowsocks.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipshadowsocks.txt | wc -l)
byte=$(cat /etc/shadowsocks/${akun})
lim=$(con ${byte})
wey=$(cat /etc/limit/shadowsocks/${akun})
gb=$(con ${wey})
lastlogin=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 2 | tail -1)
printf "  %-13s %-7s %-8s %2s\n"   "${akun}" "$lastlogin"  " ${gb}/${lim}"   "$jum2";
fi 
rm -rf /tmp/ipshadowsocks.txt
done
rm -rf /tmp/other.txt
echo ""
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}          ⇱ SCRIPT BY CLOUDVPN ⇲         ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"

m-ssws
