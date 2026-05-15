# OpenCode AI Agent - Installation Guide (Ubuntu)

A step-by-step guide to installing and configuring OpenCode on Ubuntu.

---

## Table of Contents

1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Installation on Ubuntu](#installation-on-ubuntu)
   - [Method 1: Install Script (Recommended)](#method-1-install-script-recommended)
   - [Method 2: Node.js Package Managers](#method-2-nodejs-package-managers)
   - [Method 3: Homebrew](#method-3-homebrew)
   - [Method 4: Docker](#method-4-docker)
   - [Method 5: Mise](#method-5-mise)
   - [Method 6: Manual Binary Download](#method-6-manual-binary-download)
4. [Initial Configuration](#initial-configuration)
5. [Verification](#verification)
6. [Getting Started](#getting-started)

---

## Overview

OpenCode is an open source AI coding agent available as a terminal-based interface, desktop app, or IDE extension. It supports multiple LLM providers including Claude, GPT, Gemini, and 75+ models through Models.dev.

**Key Features:**
- LSP enabled - Automatically loads the right LSPs for the LLM
- Multi-session - Start multiple agents in parallel on the same project
- Share links - Share a session link for reference or debugging
- GitHub Copilot support - Log in with GitHub to use your Copilot account
- ChatGPT support - Log in with OpenAI to use ChatGPT Plus or Pro
- Any model - 75+ LLM providers through Models.dev, including local models
- Privacy first - Does not store any code or context data

---

## Prerequisites

### Required:
1. A modern terminal emulator (one of the following recommended):
   - [WezTerm](https://wezterm.org) - Cross-platform
   - [Alacritty](https://alacritty.org) - Cross-platform
   - [Ghostty](https://ghostty.org) - Linux
   - [Kitty](https://sw.kovidgoyal.net/kitty/) - Linux
   - GNOME Terminal (default on Ubuntu)
   - Terminator

2. API keys for the LLM providers you want to use

### Optional (for development):
- Node.js 18+ (for npm/bun installation)
- Git (for version control integration)

### System Requirements:
- Ubuntu 20.04 LTS or later
- curl or wget for downloading
- sudo privileges for system-wide installation

---

## Installation on Ubuntu

### Method 1: Install Script (Recommended)

The easiest way to install OpenCode on Ubuntu:

```bash
curl -fsSL https://opencode.ai/install | bash
```

This script will:
- Download the latest binary for your platform
- Install it to `/usr/local/bin` (requires sudo) or `~/.local/bin`
- Add the binary to your PATH

After installation, you may need to restart your terminal or source your profile:

```bash
source ~/.bashrc
```

### Method 2: Node.js Package Managers

First, ensure you have Node.js installed. If not, install it:

```bash
# Install Node.js 20.x
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
```

**Using npm:**
```bash
npm install -g opencode-ai
```

**Using Bun:**
```bash
# Install Bun
curl -fsSL https://bun.sh/install | bash
bun install -g opencode-ai
```

**Using pnpm:**
```bash
# Install pnpm first
npm install -g pnpm
pnpm install -g opencode-ai
```

**Using Yarn:**
```bash
# Install Yarn first
npm install -g yarn
yarn global add opencode-ai
```

### Method 3: Homebrew

Install Homebrew if you haven't already:

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then add to your PATH (add to `~/.bashrc`):

```bash
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

Install OpenCode:

```bash
brew install anomalyco/tap/opencode
```

### Method 4: Docker

If you have Docker installed, you can run OpenCode in a container:

```bash
docker run -it --rm ghcr.io/anomalyco/opencode
```

To make it easier to use, create an alias:

```bash
echo 'alias opencode="docker run -it --rm -v $(pwd):/workspace ghcr.io/anomalyco/opencode"' >> ~/.bashrc
source ~/.bashrc
```

### Method 5: Mise

If you use Mise for version management:

```bash
# Install Mise if not already installed
curl https:// mise.run | sh

# Add to PATH
echo 'eval "$(mise activate bash)"' >> ~/.bashrc
source ~/.bashrc

# Install OpenCode
mise use -g github:anomalyco/opencode
```

### Method 6: Manual Binary Download

Download the binary directly from the releases page:

```bash
# Check system architecture
uname -m

# Download the latest release (x86_64)
wget https://github.com/anomalyco/opencode/releases/latest/download/opencode-linux-x64

# Or for ARM64 (Apple Silicon or Raspberry Pi)
wget https://github.com/anomalyco/opencode/releases/latest/download/opencode-linux-arm64

# Make it executable
chmod +x opencode-linux-*

# Move to PATH
sudo mv opencode-linux-* /usr/local/bin/opencode

# Verify
opencode --version
```

---

## Initial Configuration

### Step 1: Verify Installation

Check that OpenCode is installed correctly:

```bash
opencode --version
```

If you get "command not found", try:

```bash
# Check if it's in a different location
ls -la ~/.local/bin/opencode

# Add to PATH if needed
export PATH="$HOME/.local/bin:$PATH"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

### Step 2: Connect to an LLM Provider

You can use any LLM provider by configuring their API keys.

#### Option A: OpenCode Zen (Recommended for Beginners)

OpenCode Zen provides access to handpicked AI models tested specifically for coding agents.

1. Run the `/connect` command in OpenCode:
   ```
   /connect
   ```

2. Select `opencode` from the menu

3. Visit [opencode.ai/auth](https://opencode.ai/auth)

4. Sign in, add your billing details, and copy your API key

5. Paste your API key when prompted

#### Option B: Other Providers

OpenCode supports 75+ LLM providers. To configure a different provider:

1. Create the config directory:
   ```bash
   mkdir -p ~/.config/opencode
   ```

2. Create or edit the config file at `~/.config/opencode/config.yaml`

3. Add your provider configuration:
   ```yaml
   providers:
     anthropic:
       api-key: your-api-key-here
     openai:
       api-key: your-api-key-here
   ```

For more details, see the [OpenCode Providers Documentation](https://opencode.ai/docs/providers/).

### Step 3: Initialize a Project

1. Navigate to your project directory:
   ```bash
   cd /path/to/project
   ```

2. Start OpenCode:
   ```bash
   opencode
   ```

3. Initialize the project:
   ```
   /init
   ```

   This will analyze your project and create an `AGENTS.md` file in the project root.

> **Tip:** Commit your project's `AGENTS.md` file to Git. This helps OpenCode understand the project structure and coding patterns used.

---

## Verification

After installation, verify everything is working:

```bash
# Check version
opencode --version

# Check help
opencode --help
```

---

## Getting Started

### Basic Commands

| Command | Description |
|---------|-------------|
| `/init` | Initialize OpenCode for the current project |
| `/connect` | Connect to an LLM provider |
| `/undo` | Undo the last change |
| `/redo` | Redo the last undone change |
| `/share` | Share the current session via link |
| `/exit` | Exit OpenCode |

### Switching Modes

- Press **Tab** to switch between Plan mode and Build mode
- Plan mode disables automatic changes and shows implementation plans
- Build mode allows OpenCode to make changes directly

### Usage Examples

**Ask questions about code:**
```
How is authentication handled in @src/auth/index.ts
```

**Add a feature:**
```
Add a login form to the authentication module
```

**Make specific changes:**
```
Refactor the function in @src/utils/helper.ts to use async/await
```

### Customization

After getting familiar with OpenCode, consider customizing:

- [Themes](https://opencode.ai/docs/themes/) - Customize the appearance
- [Keybinds](https://opencode.ai/docs/keybinds/) - Configure keyboard shortcuts
- [Formatters](https://opencode.ai/docs/formatters/) - Set up code formatters
- [Commands](https://opencode.ai/docs/commands/) - Create custom commands
- [Configuration](https://opencode.ai/docs/config/) - Full config reference

---

## Troubleshooting

### Common Issues

1. **Command not found**
   - Ensure the installation directory is in your PATH
   - Try restarting your terminal
   - Check: `echo $PATH`

2. **Permission denied when installing**
   - Use `sudo` for system-wide installation
   - Or install to user directory: `~/.local/bin`

3. **API key not recognized**
   - Verify your API key is correctly set in the config
   - Check the config file location: `~/.config/opencode/config.yaml`

4. **Terminal compatibility issues**
   - Ensure you're using a supported terminal emulator
   - Try WezTerm, Alacritty, or GNOME Terminal

### Additional Resources

- [Official Documentation](https://opencode.ai/docs/)
- [GitHub Repository](https://github.com/anomalyco/opencode)
- [Discord Community](https://opencode.ai/discord)
- [Changelog](https://opencode.ai/changelog)

---

## Summary

You have successfully installed OpenCode on Ubuntu! Here's what to do next:

1. Start OpenCode in your project: `opencode`
2. Connect to a provider: `/connect`
3. Initialize your project: `/init`
4. Start coding with AI assistance!

---

*Last updated: May 2026*