alias vi=vim
alias chrome=google-chrome-stable

export DEFAULT_USER=$(whoami)
export EDITOR=vim
export BROWSER="google-chrome-stable --profile-directory=Default"

export PBCLI=pb-docker

export ISAC_DEV=True

export GOPATH=$HOME/projects/golang
export GOBIN=$GOPATH/bin
export PATH=$GOPATH/bin:$PATH

export PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
export GEM_HOME=$HOME/.gem
eval "$(rbenv init -)"

export PATH=$HOME/bin:$PATH

# use GTK2 for SWT cause of bugs with hidpi
export SWT_GTK3=0

source ~/.secret/.profile 
