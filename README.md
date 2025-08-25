# My personal (Neo)Vim config
Love it or hate it but this is my personal neovim config. This is tailor made to me so if you're looking for a fully featured vim config where everything is done for you, try SpaceVim.

## Install
### Install the latest NVIM

This config requires neo nightly.

Please refer to the [official Neovim installation documentation](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-package) for platform-specific installation instructions.

### Run Make
To install to nvim run
```bash
make install-nvim
```

This command will remove any old config

## Dependencies

### Core Dependencies (All Platforms)
These are required for basic functionality:
- **Git** - Version control and plugin management
- **Node.js** - Language server support and some plugins
- **Ripgrep** - Fast file searching (used by Telescope)
- **GitHub CLI (gh)** - For GitHub integration (e.g., CopilotChat features)

### Platform-Specific Dependencies

#### Ubuntu/Debian (apt-based)
```bash
sudo apt update
sudo apt install build-essential git curl php nodejs ripgrep
# Install GitHub CLI (gh)
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
```

#### macOS (using Homebrew)
```bash
# Install Homebrew if you don't have it
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install git curl php node ripgrep
brew install --cask github-cli  # for gh command
```

#### Windows (using Chocolatey)
```bash
# Install Chocolatey if you don't have it
# Run PowerShell as Administrator and execute:
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install dependencies
choco install git curl php nodejs ripgrep github-cli
```

#### Arch Linux (pacman-based)
```bash
sudo pacman -S base-devel git curl php nodejs ripgrep github-cli
```

#### Fedora/RHEL/CentOS (dnf/yum-based)
```bash
sudo dnf install gcc gcc-c++ make git curl php nodejs ripgrep github-cli
# or for older versions
sudo yum groupinstall "Development Tools"
sudo yum install git curl php nodejs ripgrep github-cli
```

### Optional Dependencies
These enhance the experience but aren't required:
- **Python 3** - Additional language support
- **Lua** - Some advanced plugin features
- **Cargo** (Rust) - Some Rust-based tools
- **Go** - Go language support

#### Installing Optional Dependencies

**Ubuntu/Debian:**
```bash
sudo apt install python3 python3-pip lua5.4 cargo golang-go
```

**macOS:**
```bash
brew install python lua rust go
```

**Windows:**
```bash
choco install python lua rust golang
```

**Arch Linux:**
```bash
sudo pacman -S python lua rust go
```

**Fedora/RHEL/CentOS:**
```bash
sudo dnf install python3 python3-pip lua cargo golang
```

### Font Requirements
For the best experience, install a Nerd Font:
- **Ubuntu/Debian:** `sudo apt install fonts-nerd-fonts-hack`
- **macOS:** `brew install --cask font-hack-nerd-font`
- **Windows:** Download from [Nerd Fonts](https://www.nerdfonts.com/font-downloads)
- **Arch Linux:** `sudo pacman -S nerd-fonts-hack`

### Verification
After installation, verify your setup:
```bash
# Check Neovim version (should be 0.9.0+)
nvim --version

# Check other dependencies
git --version
node --version
rg --version
php --version
gh --version
```

## Troubleshooting

### Common Issues

**Neovim version too old:**
- Ensure you're using the nightly/unstable version
- On Ubuntu, the stable PPA only provides older versions

**Missing ripgrep:**
- Telescope plugin requires ripgrep for live grep functionality
- Alternative: install `fd` and configure Telescope to use it

**Node.js issues:**
- Ensure Node.js version 16+ is installed
- Some language servers require specific Node.js versions

**Font issues:**
- Set `vim.g.have_nerd_font = true` in your config if using Nerd Fonts
- Or set `vim.g.have_nerd_font = false` if not using them

### Platform-Specific Issues

**macOS:**
- If using M1/M2 Mac, ensure you have the ARM64 versions of dependencies
- Some plugins may require Xcode Command Line Tools: `xcode-select --install`

**Windows:**
- Ensure WSL2 is used for better compatibility
- Some Unix tools may not work natively on Windows

**Linux:**
- Ensure you have the latest package versions
- Some distributions may require enabling additional repositories
