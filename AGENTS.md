# Local Machine Setup & Dotfiles Automation

Welcome to the personal development environment and dotfiles repository. This repository is optimized for quick, reproducible, and automated setups of macOS development machines.

---

## 🚀 Setup Mechanism

The repository relies on two key components to configure and maintain our development environments:

1. **`machine_setup_instructions.md`**: The source-of-truth manual runbook. It breaks the macOS configuration down into 6 distinct, logical phases (System Preferences, Core Packages/Fonts, Zsh & Prompt, SSH/GitHub Keys, Git Config, and Development Tooling).
2. **`start.sh`**: The automated bash execution script. It mirrors the exact installation and configuration workflow defined in the manual instructions, installing packages via Homebrew, setting up shell environments, setting up keys, and linking dotfiles.

---

## 🛠️ Components Covered

### 1. Shell & Prompt
* **Oh My Zsh** with `zsh-autosuggestions` and `zsh-syntax-highlighting` plugins.
* **Starship Prompt** for a fast, customizable terminal prompt.
* Custom `.zshrc` aliases and path variables.

### 2. Version Control & SSH
* Global Git variables and handy command aliases (`git co`, `git br`, `git ci`, `git st`).
* Secure, automated SSH key generation (`ed25519`) and automatic keychain mapping.

### 3. Editor & Custom Configs
* **Neovim** using the standard kickstart.nvim configuration.
* Custom symlinks from the workspace dotfiles directly into home configurations.
* Dedicated **iTerm2** custom settings, loaded dynamically from the `iterm2/` subdirectory in this repo.

### 4. Development Runtimes & Containerization
* **NVM (Node Version Manager)** installing Node.js LTS automatically.
* **Docker Desktop**, **Google Cloud CLI**, and standard web browsers.

### 5. AI Engineering Tools
Our setup integrates leading terminal-based AI tools:
* **Gemini CLI** (`@google/gemini-cli`): Our primary AI terminal agent.
* **OpenAI Codex CLI** (`@openai/codex`): For AI-assisted terminal coding and ChatGPT integration.
* **Claude Code CLI** (`claude-code`): Anthropic's terminal-based AI software engineering agent.

---

## 📖 How to Run the Automated Setup

On a brand-new macOS machine:

1. Clone or download this dotfiles repository:
   ```bash
   git clone git@github.com:devZdev/dotfiles ~/git/dotfiles
   ```
2. Navigate to the directory and run the automation script:
   ```bash
   cd ~/git/dotfiles
   chmod +x start.sh
   ./start.sh
   ```
3. Complete the manual steps outputted at the end of the script:
   * **System Settings**: Log into your Apple ID, configure iCloud, and enable "Tap to click" under Trackpad settings.
   * **iTerm2**: Relaunch iTerm2 to load preferences from the repo.
   * **Docker / GCloud**: Log into Docker Desktop and run `gcloud auth login`.
   * **AI Tooling Keys**:
     * Add your Gemini API key to your `.extra.zsh` or `.zshrc`.
     * Log into Codex by running `codex` to complete OpenAI authentication.
     * Log into Claude Code by running `claude` to complete Anthropic authentication.

---

## 🔄 Maintaining Alignment

To prevent configuration drift, adhere to this rule:
> **Rule of Dual Update**: Whenever you add, upgrade, or remove a global tool, cask, configuration step, or package, **always update both `machine_setup_instructions.md` and `start.sh`** to ensure manual guidelines and automated actions remain 100% synchronized.
