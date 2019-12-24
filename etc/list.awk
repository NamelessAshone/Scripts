BEGIN       { idx = -1 }
/Host /     { idx++; tb[idx]["Host"] = $2 }
/HostName / { tb[idx]["HostName"] = $2 }
/Port /     { tb[idx]["Port"] = $2 }
/User /     { tb[idx]["User"] = $2 }
END {
    printf "%-16s ", "Host"
    printf "%-12s ", "User"
    printf "%-16s ", "HostName"
    printf "%-11s ", "Port"
    printf "\n"
    for(i = 0; i < idx; i++) {
        printf "%-16s ", tb[i]["Host"]
        printf "%-12s ", tb[i]["User"]
        printf "%-16s ", tb[i]["HostName"]
        printf "%-11s ", tb[i]["Port"]
        printf "\n"
    }
}
