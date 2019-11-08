select_server=$(tac /tmp/clash.log | tac /tmp/clash.log | rg -e "\[(.*)\]" -m 1 -o -r '$1')
jq_query=.proxies.\"$select_server\".history[-1].delay
server_delay=$(curl -s "localhost:9090/proxies" | jq --raw-output "$jq_query")

echo "[$select_server]->$server_delay"
