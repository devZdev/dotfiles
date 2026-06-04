Laptop on
iCloud config, waste removal of files not needed
Adjust trackpad speed, tap to track

Installations

Homebrew:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


Oh My Zsh:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

Github SSH
ssh-keygen -t ed25519 -C "devin.zimmer@gmail.com"

eval "$(ssh-agent -s)"

Vim ~/.ssh/config

Host github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519

ssh-add --apple-use-keychain ~/.ssh/id_ed25519


pbcopy < ~/.ssh/id_ed25519.pub
Then sdd to GitHub 

clone dotfiles repos:
Git clone git@github.com:devZdev/dotfiles
Git clone git@github.com:devZdev/kickstart.nvim.git

Link zsh to my dotfiles
ln -s ~/git/dotfiles/.zshrc .zshrc
ln -s ~/git/dotfiles/.extra.zsh .extra.zsh


note: zsh plugin dir: /Users/devzdev/.oh-my-zsh/plugins

I sim linked to the plugins dir
Git clone git@github.com:zsh-users/zsh-autosuggestions.git 
Git clone git@github.com:zsh-users/zsh-syntax-highlighting.git



NVim
brew install neovim
in .config folder:
ln -s ~/git/kickstart.nvim nvim


Node, nvm, npm:
brew update && brew install nvm 


Adding to zshrc:
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh" # This loads nvm
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm" # This loads nvm bash_completion

nvm install --lts

(Now we have npm)

Css-ls, intelephense, prettier, typescript language servers:
npm install -g vscode-langservers-extracted

docker:
brew install --cask docker-desktop
(Password required)

Gcloud:
brew install --cask gcloud-cli
gcloud config set project air-scraper-0317

Nerd Font:
brew install --cask font-inconsolata-go-nerd-font

Starship:
Brew install starship

Enabled iterm2 with nerdfont in iterm2 settings

Added git config aliases
in .gitconfg

[alias]
    co = checkout
    br = branch
    ci = commit
    st = status

git config --global user.name "Devin Zimmer"
git config --global user.email devin.zimmer@gmail.com

gemini:
npm install -g @google/gemini-cli
(added api key to zsh)

Needs
---
[x] iterm2
[x] homebrew
[x] github and ssh
[x] git retrieve dotfiles and kickstart
[x] xsh oh my zsh
[x] npm and node
[x] nvim and dips
[x] docker, logged in (devzdev)
[x] gcloud, logged in (devin.zimmer@gmail.com)
[x] nerdfont
[x] starship
[x] gemini cli






