# Machine Setup Documentation

**Phase 1: macOS System Preferences**
1. Log into your Apple ID and configure iCloud.
2. Remove any unnecessary files or default bloatware.
3. Open System Settings and adjust the Trackpad speed.
4. Enable "Tap to click" in the Trackpad settings.

**Phase 2: Core Package Management & Fonts**
1. Install Homebrew:
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
2. Install the Inconsolata Go Nerd Font:
`brew install --cask font-inconsolata-go-nerd-font`

**Phase 3: Zsh & Terminal Environment**
1. Install Oh My Zsh:
`sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
2. Install Starship prompt:
`brew install starship`
3. Clone Zsh plugins into the Oh My Zsh custom plugins directory:
`git clone git@github.com:zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions`
`git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting`

**Phase 4: SSH & GitHub Authentication**
1. Generate a new SSH key:
`ssh-keygen -t ed25519 -C "devin.zimmer@gmail.com"`
2. Start the SSH agent in the background:
`eval "$(ssh-agent -s)"`
3. Create and edit your SSH config file (`vim ~/.ssh/config`) to include:
```text
Host github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
```
4. Add your SSH private key to the ssh-agent:
`ssh-add --apple-use-keychain ~/.ssh/id_ed25519`
5. Copy the public key to your clipboard and add it to your GitHub account settings:
`pbcopy < ~/.ssh/id_ed25519.pub`

**Phase 5: Git Configuration & Dotfiles**
1. Set your global Git variables and aliases:
`git config --global user.name "Devin Zimmer"`
`git config --global user.email devin.zimmer@gmail.com`
`git config --global alias.co checkout`
`git config --global alias.br branch`
`git config --global alias.ci commit`
`git config --global alias.st status`
2. Clone your repositories into a working directory (e.g., `~/git`):
`git clone git@github.com:devZdev/dotfiles ~/git/dotfiles`
`git clone git@github.com:devZdev/kickstart.nvim.git ~/git/kickstart.nvim`
3. Symlink your dotfiles to your home directory:
`ln -s ~/git/dotfiles/.zshrc ~/.zshrc`
`ln -s ~/git/dotfiles/.extra.zsh ~/.extra.zsh`

**Phase 6: Development Tooling**
1. Install Neovim, ripgrep, fd, Glow, tree-sitter, and tree-sitter-cli via Homebrew:
`brew install neovim ripgrep fd glow tree-sitter tree-sitter-cli`
2. Symlink the Neovim configuration:
`ln -s ~/git/kickstart.nvim ~/.config/nvim`
3. Install NVM (Node Version Manager):
`brew update && brew install nvm`
4. Add NVM configuration to your `.zshrc` (if not already handled by your dotfiles repo).
5. Install the LTS version of Node.js:
`nvm install --lts`
6. Install required global NPM packages (Language servers and OpenAI Codex):
`npm install -g vscode-langservers-extracted @openai/codex`
7. Install Docker Desktop and log in (Username: `devzdev`):
`brew install --cask docker-desktop`
8. Install Google Cloud CLI, log in (`devin.zimmer@gmail.com`), and set the active project:
`brew install --cask gcloud-cli`
`gcloud config set project air-scraper-0317`
9. Install Google Chrome for development:
`brew install --cask google-chrome`
10. Install the ChatGPT macOS app:
`brew install --cask chatgpt`
11. Install TradingView Desktop:
`brew install --cask tradingview`
12. Install Superset via Homebrew Cask:
`brew install --cask superset`
13. Install iTerm2 via Homebrew Cask:
`brew install --cask iterm2`
14. Configure iTerm2 to load preferences from your cloned dotfiles:
`defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$HOME/git/dotfiles/iterm2"`
`defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true`
15. Install Zoom for collaboration:
`brew install --cask zoom`
16. Install Slack for communication:
`brew install --cask slack`
17. Install Logi Tune for Logitech device management:
`brew install --cask logitune`
18. Install ProtonVPN for VPN access:
`brew install --cask protonvpn`
19. Install Claude Code CLI for AI-assisted terminal software engineering:
`brew install --cask claude-code`
20. Install Cursor CLI for AI-assisted editor workflows:
`brew install --cask cursor-cli`
21. Install Grok Build CLI for AI-assisted software engineering:
`brew install --cask grok-build`
22. Install Antigravity CLI for AI-assisted terminal software engineering:
`brew install --cask antigravity-cli`
23. Install Jekyll and its prerequisites (Ruby, chruby, ruby-install):
    * Install chruby and ruby-install via Homebrew:
      `brew install chruby ruby-install`
    * Install a modern Ruby version:
      `ruby-install ruby 3.4.1`
    * Add Ruby configuration to your `.zshrc` (automatically handled by cloning this dotfiles repo).
    * Install Bundler and Jekyll gems:
      `gem install bundler jekyll`
24. Install Shopify CLI:
    * Tap the Shopify repository:
      `brew tap shopify/shopify`
    * Install Shopify CLI:
      `brew install shopify-cli`
