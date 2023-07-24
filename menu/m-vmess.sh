#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
#########################
# Color Validation
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White

On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
Yellow='\033[0;93'
NC='\e[0m'
# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
clear
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}               ⇱ VMESS MENU ⇲            ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
echo -e ""
echo -e "${BIWhite}╒════════════════════════════════════════╕${NC}"
echo -e "${BICyan}[${BIWhite}01${BICyan}]${RED} • ${NC}${CYAN}ADD VMESS $NC"
echo -e "${BICyan}[${BIWhite}02${BICyan}]${RED} • ${NC}${CYAN}TRIAL VMESS $NC"
echo -e "${BICyan}[${BIWhite}03${BICyan}]${RED} • ${NC}${CYAN}EXTEND VMESS $NC"
echo -e "${BICyan}[${BIWhite}04${BICyan}]${RED} • ${NC}${CYAN}DELETE VMESS $NC"
echo -e "${BICyan}[${BIWhite}05${BICyan}]${RED} • ${NC}${CYAN}CHECK VMESS $NC"
echo -e "${BIWhite}╘════════════════════════════════════════╛${NC}"
echo -e ""
echo -e "${BICyan}[${BIWhite}0 ${BICyan}]${RED} • ${NC}${CYAN}BACK MENU $NC"
echo -e ""
echo -e   "Press x or [ Ctrl+C ] • To-Exit"
echo ""
echo -e "${CYAN}══════════════════════════════════════════${NC}"
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
1) clear ; add-ws ; exit ;;
2) clear ; trialvmess ; exit ;;
3) clear ; renew-ws ; exit ;;
4) clear ; del-ws ; exit ;;
5) clear ; cek-ws ; exit ;;
0) clear ; menu ; exit ;;
x) exit ;;
*) echo "Masukkan Angka Yang Benar " ; sleep 1 ; m-sshovpn ;;
esac
