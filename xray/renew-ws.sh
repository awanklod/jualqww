#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }




clear
# Getting
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
NUMBER_OF_CLIENTS=$(grep -c -E "^#vm# " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
clear
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}            ⇱ RENEW USER VMESS ⇲         ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
echo ""
echo "You have no existing clients!"
echo ""
echo -e "${CYAN}══════════════════════════════════════════${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-vmess
fi

clear
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}            ⇱ RENEW USER VMESS ⇲         ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
echo ""
grep -E "^#vm# " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
echo ""
red "tap enter to go back"
echo -e "${CYAN}══════════════════════════════════════════${NC}"
read -rp "Input Username : " user
if [ -z $user ]; then
m-vmess
else
read -p "Expired (days): " masaaktif
exp=$(grep -wE "^#vm# $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "/#vm# $user/c\#vm# $user $exp4" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "${CYAN}══════════════════════════════════════════${NC}"
echo " VMESS Account Was Successfully Renewed"
echo -e "${CYAN}══════════════════════════════════════════${NC}"
echo ""
echo " Client Name : $user"
echo " Expired On  : $exp4"
echo ""
echo -e "${CYAN}══════════════════════════════════════════${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-vmess
fi
