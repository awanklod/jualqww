#!/bin/bash
clear
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}    ⇱ CEK USER MULTI SSH  ⇲           ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}"
if [ -e "/root/log-limit.txt" ]; then
echo "User Who Violate The Maximum Limit";
echo "Time - Username - Number of Multilogin"
echo -e "${CYAN}══════════════════════════════════════════${NC}"
cat /root/log-limit.txt
else
echo " No user has committed a violation"
echo " "
echo " or"
echo " "
echo " The user-limit script not been executed."
fi
echo " ";
echo -e "${CYAN}══════════════════════════════════════════${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
