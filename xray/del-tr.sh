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

NUMBER_OF_CLIENTS=$(grep -c -E "^#! " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${CYAN}           ⇱ DELETE USER TROJAN ⇲        ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
echo ""
echo "You have no existing clients!"
echo ""
echo -e "${CYAN}══════════════════════════════════════════${NC}"
read -n 1 -s -r -p "Press any key to back on menu"
menu
fi

clear
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${CYAN}          ⇱ DELETE USER TROJAN ⇲         ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
echo "  User       Expired  " 
echo -e "${CYAN}══════════════════════════════════════════${NC}"
grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
echo ""
red "tap enter to go back"
echo -e "${CYAN}══════════════════════════════════════════${NC}"
read -rp "Input Username : " user
if [ -z $user ]; then
m-trojan
else
exp=$(grep -wE "^#! $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#! $user $exp/,/^},{/d" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "${CYAN}══════════════════════════════════════════${NC}"
echo " VLess Account Deleted Successfully"
echo -e "${CYAN}══════════════════════════════════════════${NC}"
echo " Client Name : $user"
echo " Expired On  : $exp"
echo -e "${CYAN}══════════════════════════════════════════${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-trojan
fi