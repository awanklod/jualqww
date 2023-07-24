#!/bin/bash
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#ss# " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${CYAN}        ⇱ DELETE USER SHADOWSOCKS ⇲      ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
echo ""
echo "You have no existing clients!"
echo ""
echo -e "${CYAN}══════════════════════════════════════════${NC}"
read -n 1 -s -r -p "Press any key to back on menu"
m-ssws
fi

clear
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${CYAN}        ⇱ DELETE USER SHADOWSOCKS ⇲      ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
echo "  User       Expired  " 
echo -e "${CYAN}══════════════════════════════════════════${NC}"
grep -E "^#ss# " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
echo ""
echo -e "${CYAN}══════════════════════════════════════════${NC}"
read -rp "Input Username : " user
if [ -z $user ]; then
m-ssws
else
exp=$(grep -wE "^#ss# $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#ss# $user $exp/,/^},{/d" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "${CYAN}══════════════════════════════════════════${NC}"
echo " Shadowsocks Account Deleted Successfully"
echo -e "${CYAN}══════════════════════════════════════════${NC}"
echo " Client Name : $user"
echo " Expired On  : $exp"
echo -e "${CYAN}══════════════════════════════════════════${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-ssws
fi
