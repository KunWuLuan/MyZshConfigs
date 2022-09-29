#! /bin/bash

echo "install zsh"
brew install zsh

echo "install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "install some plugins"
brew install cowsay

echo "install jq"
brew install jq

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

echo "enable some plugins"
sed -i .back 's/plugins=(git)/plugins=(fzf git cp zsh-syntax-highlighting zsh-autosuggestions rand-quote extract sudo z)/g' ~/.zshrc 

echo "some common aliases"
cat >>~/.zshrc <<EOF

alias sed="docker run -i busybox sed"
alias awk="docker run -i busybox awk"
alias kgp="kubectl get po"
alias kgn="kubectl get node"
alias kgnl="kubectl get node -l"
alias kaf="kubectl apply -f""
alias kgsys="kubectl get -n kube-system"
EOF

source ~/.zshrc
