#!/bin/sh

set -e

echo "install git"
yum install -y git

echo "install zsh"
brew install zsh

echo "install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "install some plugins"
brew install cowsay

echo "install zsh plugin: vscode"
git clone https://github.com/valentinocossar/vscode.git $ZSH_CUSTOM/plugins/vscode

echo "install jq"
brew install jq

echo "install zsh plugin: zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo "install zsh plugin: zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo "install fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

echo "enable some plugins"
sed -i .back 's/plugins=(git)/plugins=(fzf git cp zsh-syntax-highlighting zsh-autosuggestions rand-quote extract sudo vscode z)/g' ~/.zshrc

echo "some common aliases"
cat >>~/.zshrc <<EOF

alias sed="docker exec -i busybox sed"
alias awk="docker exec -i busybox awk"
alias kgp="kubectl get po"
alias kgn="kubectl get node"
alias kgnl="kubectl get node -l"
alias kaf="kubectl apply -f"
alias kgsys="kubectl get -n kube-system"
EOF

source ~/.zshrc

echo "install kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo "install helm"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

echo "install python3"
yum install -y python3
