#!/bin/bash
MYIP=$(curl -sS ipv4.icanhazip.com)
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
# VPS Information
UDPCORE="https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1S3IE25v_fyUfCLslnujFBSBMNunDHDk2' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1S3IE25v_fyUfCLslnujFBSBMNunDHDk2"
#Domain
domain=$(cat /etc/xray/domain)
#Status certificate
modifyTime=$(stat $HOME/.acme.sh/${domain}_ecc/${domain}.key | sed -n '7,6p' | awk '{print $2" "$3" "$4" "$5}')
modifyTime1=$(date +%s -d "${modifyTime}")
currentTime=$(date +%s)
stampDiff=$(expr ${currentTime} - ${modifyTime1})
days=$(expr ${stampDiff} / 86400)
remainingDays=$(expr 90 - ${days})
tlsStatus=${remainingDays}
if [[ ${remainingDays} -le 0 ]]; then
	tlsStatus="expired"
fi

BURIQ () {
    curl -sS https://raw.githubusercontent.com/awanklod/jual/main/izinnya > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/awanklod/jual/main/izinnya | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/awanklod/jual/main/izinnya | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}
red='\e[1;31m'
green='\e[1;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION

if [ "$res" = "Expired" ]; then
Exp="\e[36mExpired\033[0m"
else
Exp=$(curl -sS https://raw.githubusercontent.com/awanklod/jual/main/izinnya | grep $MYIP | awk '{print $3}')
fi

# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# Download
#Download/Upload today
dtoday="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
utoday="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
ttoday="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload yesterday
dyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}')"
uyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}')"
tyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload current month
dmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $3" "substr ($4, 1, 1)}')"
umon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $6" "substr ($7, 1, 1)}')"
tmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $9" "substr ($10, 1, 1)}')"
# Getting CPU Information
ttoday="$(vnstat | grep today | awk '{print $8" "substr ($9, 1, 3)}' | head -1)"
tmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $8" "substr ($9, 1 ,3)}' | head -1)"
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
ISP=$(cat /usr/local/etc/datavps/org )
CITY=$(cat /usr/local/etc/datavps/city )
WKT=$(cat /usr/local/etc/datavps/timezone )
#os=$(curl-s "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`)
DAY=$(date +%A)
DATE=$(date +%m/%d/%Y)
DATE2=$(date -R | cut -d " " -f -5)
IPVPS=$(curl -s ipinfo.io/ip )
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
fram=$( free -m | awk 'NR==2 {print $4}' )

# TOTAL RAM
total_ram=` grep "MemTotal: " /proc/meminfo | awk '{ print $2}'`
totalram=$(($total_ram/1024))
USAGERAM=$(free -m | awk 'NR==2 {print $3}')

persenmemori="$(echo "scale=2; $usmem*100/$tomem" | bc)"
#persencpu=
persencpu="$(echo "scale=2; $cpu1+$cpu2" | bc)"

cek=$(service ssh status | grep active | cut -d ' ' -f5)
if [ "$cek" = "active" ]; then
stat=-f5
else
stat=-f7
fi
ngx=$(service nginx status | grep active | cut -d ' ' $stat)
if [ "$ngx" = "active" ]; then
resngx="${green}ON${NC}"
else
resngx="${red}OFF${NC}"
fi
v2r=$(service xray status | grep active | cut -d ' ' $stat)
if [ "$v2r" = "active" ]; then
resv2r="${green}ON${NC}"
else
resv2r="${red}OFF${NC}"
fi

#KonZ
vlx=$(grep -c -E "^#& " "/etc/xray/config.json")
let vla=$vlx/2
vmc=$(grep -c -E "^#vm# " "/etc/xray/config.json")
let vma=$vmc/2
ssh1="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
trx=$(grep -c -E "^#! " "/etc/xray/config.json")
let tra=$trx/2
ssx=$(grep -c -E "^#ss# " "/etc/xray/config.json")
let ssa=$ssx/2

clear 
echo -e "${CYAN}╒════════════════════════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}                     ⇱ SERVER INFORMATION ⇲                  ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════════════════════════╛${NC}"
echo -e " ${IPurple} ⇲ ${NC} ${PURPLE}SCRIPT BY      ${NC} ${BIWhite}:  ${BICyan}CLOUDVPN PROJECT${NC}"    
echo -e " ${IPurple} ⇲ ${NC} ${PURPLE}Current Domain ${NC} ${BIWhite}:  ${BICyan}$domain${NC}" 
echo -e " ${IPurple} ⇲ ${NC} ${PURPLE}IP-VPS         ${NC} ${BIWhite}:  ${BICyan}$IPVPS${NC}"                  
echo -e " ${IPurple} ⇲ ${NC} ${PURPLE}ISP-VPS        ${NC} ${BIWhite}:  ${BICyan}$ISP${NC}"
echo -e " ${IPurple} ⇲ ${NC} ${PURPLE}DATE&TIME      ${NC} ${BIWhite}:  ${BICyan}$( date -d "0 days" +"%d-%m-%Y | %X" ) ${NC}"
echo -e " ${IPurple} ⇲ ${NC} ${PURPLE}OS NAME        ${NC} ${BIWhite}:  ${BICyan}$cname${NCS}"
echo -e " ${IPurple} ⇲ ${NC} ${PURPLE}RAM, CORE VPS  ${NC} ${BIWhite}:  ${BICyan}${totalram} MB, $cores${NC}"
echo -e " ${IPurple} ⇲ ${NC} ${PURPLE}USAGE RAM,CPU  ${NC} ${BIWhite}:  ${BICyan}$USAGERAM MB, $cpu_usage${NC}"
echo -e "${CYAN}╒════════════════════════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}                      ⇱ SERVER   RUNNING ⇲                  ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════════════════════════╛${NC}"
echo -e "${CYAN}╒════════════════════════════════════════════════════════════╕${NC}"
echo -e " ${BICyan} NGINX ${NC}: ${GREEN}$resngx ${IPurple}  Today   : $ttoday   ${IPurple} yesterday : $tyest"
echo -e " ${BICyan} XRAY  ${NC}: ${GREEN}$resv2r ${IPurple}  Monthly : $tmon"
echo -e "${CYAN}╘════════════════════════════════════════════════════════════╛${NC}"
echo -e "${CYAN}╒════════════════════════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}                      ⇱ ACCOUNT    TOTAL ⇲                  ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════════════════════════╛${NC}"
echo -e "${CYAN}╒════════════════════════════════════════════════════════════╕${NC}"
echo -e "${BICyan}  \033[0m ${BOLD}${YELLOW}SSH     VMESS       VLESS      TROJAN       SHADOWSOCKS$NC ${BICyan}"
echo -e "${BICyan}  \033[0m ${BICyan} $ssh1        $vma           $vla          $tra              $ssa   $NC    ${BICyan}"
echo -e "${CYAN}╘════════════════════════════════════════════════════════════╛${NC}"
echo -e "${CYAN}╒════════════════════════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}                      ⇱ MENU     SERVICE ⇲                  ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════════════════════════╛${NC}"
echo -e "${CYAN}╒════════════════════════════════════════════════════════════╕${NC}"
echo -e " ${BICyan}[${BIWhite}01${BICyan}]${RED} •${NC} ${CYAN}SSH MENU        $NC  ${BICyan}[${BIWhite}04${BICyan}]${RED} • ${NC}${CYAN}TROJAN MENU $NC"
echo -e " ${BICyan}[${BIWhite}02${BICyan}]${RED} •${NC} ${CYAN}VMESS MENU      $NC  ${BICyan}[${BIWhite}05${BICyan}]${RED} • ${NC}${CYAN}S-SOCK MENU $NC"
echo -e " ${BICyan}[${BIWhite}03${BICyan}]${RED} •${NC} ${CYAN}VLESS MENU      $NC  ${BICyan}[${BIWhite}06${BICyan}]${RED} • ${NC}${CYAN}CHANGE PASSWORD $NC"
echo -e "${CYAN}╘════════════════════════════════════════════════════════════╛${NC}"
echo -e "${CYAN}╒════════════════════════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}                      ⇱ ADD         MENU ⇲                  ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════════════════════════╛${NC}"
echo -e "${CYAN}╒════════════════════════════════════════════════════════════╕${NC}"
echo -e " ${BICyan}[${BIWhite}07${BICyan}]${RED} •${NC} ${CYAN}OTHER MENU      $NC  ${BICyan}[${BIWhite}09${BICyan}]${RED} • ${NC}${CYAN}INSTALL UDP SERVICE $NC"
echo -e " ${BICyan}[${BIWhite}08${BICyan}]${RED} •${NC} ${CYAN}MENU DOMAIN     $NC  ${BICyan}[${BIWhite}10${BICyan}]${RED} • ${NC}${CYAN}REBOOT $NC"
echo -e "${CYAN}╘════════════════════════════════════════════════════════════╛${NC}"
echo -e "${CYAN}╒════════════════════════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}                      ⇱ CLOUDVPN PROJECT ⇲                  ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════════════════════════╛${NC}"

DATE=$(date +'%d %B %Y')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo -e " ${IWhite}│${CYAN}   Expiry In      : ${IYellow}$(( (d1 - d2) / 86400 )) Days $NC"
}
mai="datediff "$Exp" "$DATE""
echo -e " ${IWhite}╒═════════════════════════════════════╕${NC}"
echo -e " ${IWhite}│${CYAN}   Client         : ${IYellow}$Name${NC}"
echo -e " ${IWhite}│${CYAN}   Order By       : ${BIRed}CLOUDVPN${NC}"
if [ $exp \< 1000 ]; 
then
echo -e " ${IWhite}│$NC     License      : ${IBlue}$sisa_hari$NC Days Tersisa $NC"
else
    datediff "$Exp" "$DATE"
fi;
echo -e " ${IWhite}╘═════════════════════════════════════╛${NC}"

echo -e   ""
read -p " Select menu :  "  opt
echo -e   ""
case $opt in
1) clear ; m-sshovpn ;;
2) clear ; m-vmess ;;
3) clear ; m-vless ;;
4) clear ; m-trojan ;;
5) clear ; m-ssws ;;
6) clear ; passwd ;;
7) clear ; set-menu ;;
8) clear ; m-domain ;;
9) clear ; wget --load-cookies /tmp/cookies.txt ${UDPCORE} -O install-udp && rm -rf /tmp/cookies.txt && chmod +x install-udp && ./install-udp ;;
10) clear ; reboot ;;
#x) exit ;;
*) echo "Enter Correct Number " ; sleep 1 ; menu ;;
esac
