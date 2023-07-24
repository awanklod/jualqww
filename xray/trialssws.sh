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
domain=$(cat /etc/xray/domain)
tls="$(cat ~/log-install.txt | grep -w "Shadowsocks WS TLS" | cut -d: -f2|sed 's/ //g')"
ntls="$(cat ~/log-install.txt | grep -w "Shadowsocks WS none TLS" | cut -d: -f2|sed 's/ //g')"
user=trial-ss`</dev/urandom tr -dc 0-9 | head -c4`
cipher="aes-128-gcm"
uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=1
Quota=5
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#ssws$/a\#ss# '"$user $exp"'\
},{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#ssgrpc$/a\#ss# '"$user $exp"'\
},{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /etc/xray/config.json
echo $cipher:$uuid > /tmp/log
shadowsocks_base64=$(cat /tmp/log)
echo -n "${shadowsocks_base64}" | base64 > /tmp/log1
shadowsocks_base64e=$(cat /tmp/log1)
shadowsockslink="ss://${shadowsocks_base64e}@isi_bug_disini:$tls?path=ss-ws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
shadowsockslink2="ss://${shadowsocks_base64e}@isi_bug_disini:$ntls?path=ss-ws&security=tls&host=${domain}&type=ws#${user}"
shadowsockslink1="ss://${shadowsocks_base64e}@${domain}:$tls?mode=gun&security=tls&type=grpc&serviceName=ss-grpc&sni=bug.com#${user}"
systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1

if [ ! -e /etc/shadowsocks ]; then
  mkdir -p /etc/shadowsocks
fi

if [ -z ${Quota} ]; then
  Quota="0"
fi

c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))

if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/shadowsocks/${user}
fi
DATADB=$(cat /etc/shadowsocks/.shadowsocks.db | grep "^#ss#" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /etc/shadowsocks/.shadowsocks.db
fi
clear
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}" 
echo -e "${BIWhite}            ⇱ SHADOWSOCKS ACCOUNT ⇲            ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "User limit     : ${Quota} GB"
echo -e "Wildcard       : (bug.com).${domain}"
echo -e "Port TLS       : ${tls}"
echo -e "Port none TLS  : ${tls}"
echo -e "Port gRPC      : ${tls}"
echo -e "Password       : ${uuid}"
echo -e "Ciphers        : ${cipher}"
echo -e "Network        : ws/grpc"
echo -e "Path           : /ss-ws"
echo -e "ServiceName    : ss-grpc"
echo -e "${BIWhite}══════════════════════════════════════════${NC}"
echo -e "Link TLS       : ${shadowsockslink}"
echo -e "${BIWhite}══════════════════════════════════════════${NC}"
echo -e "Link none TLS  : ${shadowsockslink2}"
echo -e "${BIWhite}══════════════════════════════════════════${NC}"
echo -e "Link gRPC      : ${shadowsockslink1}"
echo -e "${BIWhite}══════════════════════════════════════════${NC}"
echo -e "Expired On     : $exp"
echo -e "${BIWhite}══════════════════════════════════════════${NC}"
echo "" | tee -a /etc/log-create-user.log
read -n 1 -s -r -p "Press any key to back on menu"
menu
