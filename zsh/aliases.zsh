alias bi="bundle install --binstubs .bundle/bin"

alias become="sudo su -c 'cd app && bash' -l"

alias ldocker="docker -H tcp://localdocker:2375 --tlsverify --tlscacert=/Users/james/.docker/ca.pem --tlscert=/Users/james/.docker/client-cert.pem --tlskey=/Users/james/.docker/client-key.pem"
alias rdocker="ssh docker.lazyatom.com sudo docker"

alias tmux="tmux -2"

alias edit="emacsclient -n"
