# SOCKS proxy tunnel
alias tunnel="'ssh -4fgN -D 8081 -L 8080:localhost:3128 foo"

## TRAFFIC MONITORING ##

alias tcpf3000='sudo tcpflow -c -i lo0 port 3000'
alias tcpf80='sudo tcpflow -c -i en1 port 80'
alias tcpf8080='sudo tcpflow -c -i lo0 port 8080'

alias tcpd8080="sudo tcpdump -s 0 -A -i lo0 'tcp port 8080 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)'"

# Need to use ports to install "wireshark" for this to work
alias tshark8080='sudo tshark -i lo0 -R "tcp.port == 8080" -w -'

# Need to use ports to install "ngrep" for this to work
alias ngrep8080='sudo ngrep -q -l -d lo0 port 8080'

# Need to use ports to install "tcpflow" for this to work
alias tcpf8080='sudo tcpflow -c -i lo0 port 8080'

# Find all active IP addresses in LAN
alias activeips='nmap -sP 192.168.1.0/24'

# show open ports
alias op='lsof -i'

alias nsop='netstat -tunl -p tcp'
