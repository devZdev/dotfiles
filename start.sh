#!/bin/bash
# macOS Development Machine Setup Script

echo "Starting automated machine setup..."

# 1. Install Homebrew (if not installed)
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew is already installed. Updating..."
    brew update
fi

# 2. Install Core Packages & Casks
echo "Installing terminal utilities, fonts, and core applications..."
brew install --cask font-inconsolata-go-nerd-font
brew install starship
brew install neovim
brew install ripgrep
brew install fd
brew install glow
brew install tree-sitter
brew install tree-sitter-cli
brew install nvm
brew install --cask docker-desktop
brew install --cask google-chrome
brew install --cask chatgpt
brew install --cask tradingview
brew install superset-sh/tap/superset
brew link superset-sh/tap/superset
brew install --cask superset
brew install --cask iterm2
brew install --cask zoom
brew install --cask slack
brew install --cask logitune
brew install --cask protonvpn
brew install --cask gcloud-cli
brew install --cask claude-code
brew install --cask cursor-cli
brew install --cask grok-build
brew install --cask grok-bot
brew install --cask antigravity-cli
brew install chruby
brew install ruby-install
brew tap shopify/shopify
brew install shopify-cli

# 3. Setup Oh My Zsh & Plugins
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "Cloning Zsh plugins..."
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || true

# 4. Git Configuration
echo "Configuring Git..."
git config --global user.name "Devin Zimmer"
git config --global user.email devin.zimmer@gmail.com
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

# 5. SSH Key Generation
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    echo "Generating SSH key..."
    ssh-keygen -t ed25519 -C "devin.zimmer@gmail.com" -f ~/.ssh/id_ed25519 -N ""
    eval "$(ssh-agent -s)"
    
    # Create SSH config if it doesn't exist
    touch ~/.ssh/config
    if ! grep -q "github.com" ~/.ssh/config; then
        echo -e "Host github.com\n  AddKeysToAgent yes\n  IdentityFile ~/.ssh/id_ed25519\n" >> ~/.ssh/config
    fi
    
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519
    pbcopy < ~/.ssh/id_ed25519.pub
    
    echo "===================================================================="
    echo "ACTION REQUIRED: Your SSH public key has been copied to the clipboard."
    echo "Please add it to your GitHub account now: https://github.com/settings/keys"
    echo "Press [Enter] once you have added the key to GitHub..."
    echo "===================================================================="
    read -r
fi

# 6. Repositories and Symlinks
echo "Setting up working directories and dotfiles..."
mkdir -p ~/git
mkdir -p ~/.config

if [ ! -d "$HOME/git/dotfiles" ]; then
    git clone git@github.com:devZdev/dotfiles ~/git/dotfiles
    ln -sf ~/git/dotfiles/.zshrc ~/.zshrc
    ln -sf ~/git/dotfiles/.extra.zsh ~/.extra.zsh
fi

if [ ! -d "$HOME/git/kickstart.nvim" ]; then
    git clone git@github.com:devZdev/kickstart.nvim.git ~/git/kickstart.nvim
    ln -sf ~/git/kickstart.nvim ~/.config/nvim
fi

# Configure iTerm2 custom preferences folder
echo "Configuring iTerm2 preferences..."
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$HOME/git/dotfiles/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# 7. Node Environment & Global Packages
echo "Configuring NVM and Node..."
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
nvm install --lts

echo "Installing global NPM packages..."
npm install -g vscode-langservers-extracted @openai/codex

# 8. Ruby Environment & Jekyll
echo "Configuring Ruby and Jekyll..."
if [ ! -d "$HOME/.rubies/ruby-3.4.1" ]; then
    echo "Installing Ruby 3.4.1 (this may take a few minutes)..."
    ruby-install ruby 3.4.1
fi

# Load chruby configuration to install Jekyll
if [ -f "/opt/homebrew/opt/chruby/share/chruby/chruby.sh" ]; then
    source "/opt/homebrew/opt/chruby/share/chruby/chruby.sh"
    source "/opt/homebrew/opt/chruby/share/chruby/auto.sh"
    chruby ruby-3.4.1
elif [ -f "/usr/local/opt/chruby/share/chruby/chruby.sh" ]; then
    source "/usr/local/opt/chruby/share/chruby/chruby.sh"
    source "/usr/local/opt/chruby/share/chruby/auto.sh"
    chruby ruby-3.4.1
fi

echo "Installing Bundler and Jekyll gems..."
gem install bundler jekyll

# 9. GCloud Configuration
echo "Configuring GCloud Project..."
gcloud config set project air-scraper-0317

echo "===================================================================="
echo "SETUP COMPLETE."
echo "Manual steps remaining:"
echo "1. Set up iCloud and adjust trackpad settings in System Preferences."
echo "2. Restart iTerm2 to apply imported preferences and verify font configurations."
echo "3. Log into Docker Desktop as 'devzdev'."
echo "4. Authenticate gcloud (run: gcloud auth login)."
echo "5. Set up your OpenAI / Codex authentication (run: codex to sign in)."
echo "6. Set up your Claude Code authentication (run: claude to sign in)."
echo "7. Set up your Grok Build authentication (run: grok-build auth login)."
echo "8. Open Grok Bot and choose 'Get started' to sign in with Cursor."
echo "9. Set up your Antigravity CLI authentication (run: agy to sign in)."
echo "10. Set up your Superset CLI authentication (run: superset auth login)."
echo "===================================================================="
