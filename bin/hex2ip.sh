printf '%d.%d.%d.%d\n' $(echo $1 | sed 's/../0x& /g')

