#!/bin/bash
clear
echo -e "${CYAN}╒════════════════════════════════════════╕${NC}"
echo -e "${BIWhite}            ⇱ DELETE USER SSH ⇲          ${NC}"
echo -e "${CYAN}╘════════════════════════════════════════╛${NC}" 
echo ""
read -p "Username SSH to Delete : " Pengguna

if getent passwd $Pengguna > /dev/null 2>&1; then
        userdel $Pengguna > /dev/null 2>&1
        echo -e "User $Pengguna was removed."
else
        echo -e "Failure: User $Pengguna Not Exist."
fi

read -n 1 -s -r -p "Press any key to back on menu"

menu
