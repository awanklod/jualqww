#!/bin/bash
red() { echo -e "\\033[32;1m${*}\\033[0m"; }
clear
echo "Checking VPS"
sleep 2
clear
_APISERVER=127.0.0.1:10085
_XRAY=/usr/local/bin/xray
apidata () {
    local ARGS=
    if [[ $1 == "reset" ]]; then
      ARGS="-reset=false"
    fi
    $_XRAY api statsquery --server=$_APISERVER "${ARGS}" \
    | awk '{
        if (match($1, /"name":/)) {
            f=1; gsub(/^"|link"|,$/, "", $2);
            split($2, p,  ">>>");
            printf "%s:%s->%s\t", p[1],p[2],p[4];
        }
        else if (match($1, /"value":/) && f){
          f = 0;
          gsub(/"/, "", $2);
          printf "%.0f\n", $2;
        }
        else if (match($0, /}/) && f) { f = 0; print 0; }
    }'
}
print_sum() {
    local DATA="$1"
    local PREFIX="$2"
    local SORTED=$(echo "$DATA" | grep "^${PREFIX}" | sort -r)
    local SUM=$(echo "$SORTED" | awk '
        /->up/{us+=$2}
        /->down/{ds+=$2}
        END{
            printf "USAGE:\t%.0f\n",  us+ds;
        }')
    echo -e "${SORTED}\n${SUM}" \
    | numfmt --field=2  --suffix=B --to=iec \
    | column -t
}
DATA=$(apidata $1)
DATA=$(apidata $1)
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}             ⇱ USAGE XRAY ⇲           ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
print_sum "$DATA" "user" "$NC"
echo -e ""
read -n 1 -s -r -p "Press [enter] to back on menu vmess"
m-vmess
fi
