#!/bin/bash
url=""
file=1
try=1000
wordlist="/usr/share/wordlists/dirb/big.txt"
delay=1

while [ $file -le $try ]
do
        sed -n 1,700p "$wordlist" > "$file".txt || echo final.
        service tor start
        sleep 8
        echo "IP ->"$(proxychains4 -q curl -s icanhazip.com)
        proxychains4 -q gobuster dir -u "$url" -w "$wordlist" -t 25 --timeout 20s -q -b 404  | tee -a output.txt
        service tor stop
        rm "$file".txt
        file=$((file+1))

        echo "Waiting $delay for next try."
        sleep $delay
done
echo "done."
