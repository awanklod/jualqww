#!/bin/bash
# SL
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
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
NUMBER_OF_CLIENTS=$(grep -c -E "^#ss# " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
clear
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}         ⇱ RENEW USER SHADOWSOCKS ⇲      ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
echo ""
echo "You have no existing clients!"
echo ""
echo -e "${CYAN}══════════════════════════════════════════${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-ssws
fi
clear
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}         ⇱ RENEW USER SHADOWSOCKS ⇲      ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
echo ""
grep -E "^#ss# " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
echo ""
echo -e "${CYAN}══════════════════════════════════════════${NC}"
read -rp "Input Username : " user
if [ -z $user ]; then
m-ssws
else
read -p "Expired (days): " masaaktif
exp=$(grep -wE "^#ss# $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "/#ss# $user/c\#ss# $user $exp4" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "${CYAN}══════════════════════════════════════════${NC}"
echo " Shadowsocks Account Was Successfully Renewed"
echo -e "${CYAN}══════════════════════════════════════════${NC}"
echo ""
echo " Client Name : $user"
echo " Expired On  : $exp4"
echo ""
echo -e "${CYAN}══════════════════════════════════════════${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-ssws
fi
