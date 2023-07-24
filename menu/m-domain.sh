#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
clear 
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${CYAN}              ⇱ MENU DOMAIN ⇲            ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
echo -e "" 
echo -e " [\e[36m•1\e[0m] CHANGE DOMAIN VPS"
echo -e " [\e[36m•2\e[0m] RENEW CERTIFICATE DOMAIN"
echo -e ""
echo -e " [\e[31m•0\e[0m] \e[31mBACK TO MENU\033[0m"
echo -e   ""
echo -e   "Press x or [ Ctrl+C ] • To-Exit"
echo -e   ""
echo -e "${CYAN}══════════════════════════════════════════${NC}"
echo -e ""
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; add-host ;;
2) clear ; certv2ray ;;
0) clear ; menu ;;
x) exit ;;
*) echo "Masukkan Angka Yang Benar" ; sleep 1 ; m-domain ;;
esac
