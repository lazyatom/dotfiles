alias bi="bundle install --path .bundle/gems --binstubs .bundle/bin"

alias become="sudo su -c 'cd app && bash' -l"

alias ldocker="docker -H tcp://localdocker:2375 --tlsverify --tlscacert=/Users/james/.docker/ca.pem --tlscert=/Users/james/.docker/client-cert.pem --tlskey=/Users/james/.docker/client-key.pem"
alias rdocker="ssh docker.lazyatom.com sudo docker"

alias mubi-redis="MUBI_DEV_DOMAIN=mubi.dev foreman start redis=0,redist=1,ma=0,ma_rsq=0,ma_rsw=0,broccoli=0"
alias mubi-broccoli="MUBI_DEV_DOMAIN=mubi.dev foreman start redis=0,redist=0,ma=0,ma_rsq=0,ma_rsw=0,broccoli=1"
alias tmux="tmux -2"
