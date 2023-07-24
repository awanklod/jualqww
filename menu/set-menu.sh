#!/bin/bash
clear
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
echo -e "${CYAN}╒════════════════════════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}                      ⇱ OTHER MENU ⇲                      ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════════════════════════╛${NC}"
echo -e ""
echo -e " ${BICyan}[${BIWhite}01${BICyan}]${RED} •${NC} ${CYAN}CEK RUNNING      $NC  ${BICyan}[${BIWhite}07${BICyan}]${RED} • ${NC}${CYAN}RESTART ALL SERVICE $NC"
echo -e " ${BICyan}[${BIWhite}02${BICyan}]${RED} •${NC} ${CYAN}CLEAR CACHE      $NC  ${BICyan}[${BIWhite}08${BICyan}]${RED} • ${NC}${CYAN}CERTV2RAY/ADD SSL $NC"
echo -e " ${BICyan}[${BIWhite}03${BICyan}]${RED} •${NC} ${CYAN}SPEEDTEST        $NC  ${BICyan}[${BIWhite}09${BICyan}]${RED} • ${NC}${CYAN}INSTALL TCP BBR  $NC"
echo -e " ${BICyan}[${BIWhite}04${BICyan}]${RED} •${NC} ${CYAN}SET AUTO REBBOT  $NC  ${BICyan}[${BIWhite}10${BICyan}]${RED} • ${NC}${CYAN}BACKUP $NC"
echo -e " ${BICyan}[${BIWhite}05${BICyan}]${RED} •${NC} ${CYAN}CHANGE BANNER    $NC  ${BICyan}[${BIWhite}11${BICyan}]${RED} • ${NC}${CYAN}CEK BANDITCH $NC"
echo -e " ${BICyan}[${BIWhite}06${BICyan}]${RED} •${NC} ${CYAN}DELETE USER EXP  $NC  ${BICyan}[${BIWhite}12${BICyan}]${RED} • ${NC}${CYAN}USAGE QUOTA XRAY $NC"
echo -e " ${BICyan}[${BIWhite}X ${BICyan}]${RED} •${NC} ${CYAN}TYPE X FOR EXIT  $NC"
echo -e "${CYAN}════════════════════════════════════════════════════════════════${NC}"
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
1) clear ; running ; exit ;;
2) clear ; clearcache ; exit ;;
3) clear ; speedtest ; exit ;;
4) clear ; auto-reboot ; exit ;;
5) clear ; nano /etc/issue.net ; exit ;;
6) clear ; xp ; exit ;;
7) clear ; restart ; exit ;;
8) clear ; certv2ray ; exit ;;
9) clear ; m-tcp ; exit ;;
10) clear ; menu-backup ; exit ;;
11) clear ; bw ; exit ;;
12) clear ; usage-xray ; exit ;;
x) exit ;;
*) echo "Enter Correct Number " ; sleep 1 ; menu;;
esac
