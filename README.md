# nvim-configs

A personal Neovim setup tuned for daily development on Windows and Linux. Configured for C/C++ (CMake + Clangd/MSVC), Python, Web/TypeScript, C# (.NET/Avalonia), Go, and Java.

Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for package management, [blink.cmp](https://github.com/saghen/blink.cmp) for autocompletion, [snacks.nvim](https://github.com/folke/snacks.nvim) + [persistence.nvim](https://github.com/folke/persistence.nvim) for the dashboard and session management, and [nvim-dap](https://github.com/mfussenegger/nvim-dap) with `nvim-dap-view` for debugging.

---

## Requirements

Install these prerequisites before launching Neovim so LSPs, formatters, and native plugins compile and run without issues.

### Windows

Using `winget` (recommended):

```powershell
# Core runtimes & CLI tools
winget install --id Git.Git -e
winget install --id Neovim.Neovim -e
winget install --id OpenJS.NodeJS -e
winget install --id Python.Python.3 -e
winget install --id Oracle.JDK.21 -e
winget install --id BurntSushi.ripgrep.MSVC -e
winget install --id sharkdp.fd -e
winget install --id Kitware.CMake -e
winget install --id JesseDuffield.lazygit -e

# Rust / Cargo (optional, needed if building blink.cmp from source)
winget install --id Rustlang.Rustup -e
```

**C/C++ Compiler on Windows:**
- **Visual Studio 2019/2022** (with "Desktop development with C++") or **Visual Studio Build Tools**.
  This config has an automatic MSVC detector (`lua/config/msvc.lua`) that finds `vcvarsall.bat` and loads the MSVC environment variables on startup. You do not need to launch Neovim from the Developer Command Prompt.
- Alternatively, install MinGW/GCC or Clang (`winget install LLVM.LLVM` or `choco install mingw -y`).

### Linux (Ubuntu / Debian)

```bash
sudo apt update
sudo apt install -y build-essential curl git unzip wget \
    gcc clang cmake \
    python3 python3-pip python3-venv \
    nodejs npm \
    openjdk-21-jdk \
    ripgrep fd-find
```

Optional tools:
- `cargo` / Rust (`curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`)
- `lazygit` (via GitHub releases or package manager)

---

## Installation

### 1. Clone the repository

**Windows (PowerShell):**
```powershell
git clone https://github.com/zischl/nvim-configs.git $env:LOCALAPPDATA\nvim
```

**Linux / macOS:**
```bash
git clone https://github.com/zischl/nvim-configs.git ~/.config/nvim
```

### 2. Start Neovim

```bash
nvim
```

- `lazy.nvim` will automatically download and install plugins.
- Mason and `mason-tool-installer` will install configured LSPs, formatters, and debug adapters in the background.

### Optional: AI Commit Messages
For AI commit message generation (`<leader>gc`), set your Gemini API key in your environment:
- **Windows**: `[System.Environment]::SetEnvironmentVariable('GEMINI_API_KEY', 'your_key', 'User')`
- **Linux**: `export GEMINI_API_KEY="your_key"` in `~/.bashrc` or `~/.zshrc`.

---

## Keymaps

Leader key is `<Space>`.

### General & Windows
| Key | Action |
| --- | --- |
| `<Space>w` | Save file |
| `<Space>q` | Close window |
| `<Space>Q` | Quit all |
| `<C-a>` | Select all |
| `<A-j>` / `<A-k>` | Move line down / up |
| `te` | Open new tab |
| `<Tab>` / `<S-Tab>` | Next / previous tab |
| `ss` / `sv` | Horizontal / vertical split |
| `<leader>bd` | Close current buffer |
| `<C-/>` | Toggle line comment |
| `<leader>e` | Toggle file explorer (`nvim-tree`) |

### Search & Navigation
| Key | Action |
| --- | --- |
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Live grep (Telescope) |
| `<leader>fb` | Open buffers (Telescope) |
| `<leader>fd` | Diagnostics (Telescope) |
| `<leader>sr` | Search & replace hub (`grug-far`) |
| `<leader>gw` | Search word under cursor (`grug-far`) |

### LSP, Linting & Formatting
| Key | Action |
| --- | --- |
| `gd` | Definition |
| `gD` | Declaration |
| `gi` | Implementation |
| `gr` | References |
| `K` | Hover docs |
| `<leader>ca` | Code actions |
| `<leader>rn` | Incremental rename (`inc-rename`) |
| `<leader>th` | Toggle inlay hints |
| `<leader>mp` | Format buffer / selection (`conform.nvim`) |
| `<leader>l` | Trigger linting (`nvim-lint`) |
| `<leader>xx` | Workspace diagnostics (`trouble.nvim`) |
| `<leader>xX` | Buffer diagnostics (`trouble.nvim`) |
| `]d` / `[d` | Next / previous diagnostic |

### Debugging (DAP)
| Key | Action |
| --- | --- |
| `<leader>dd` | Start / continue debugging |
| `<leader>dt` | Toggle breakpoint |
| `<leader>ds` | Step over |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dp` | Pause debugger |
| `<leader>dq` | Terminate debugger |
| `<leader>du` | Toggle DAP UI view (`nvim-dap-view`) |

### Git
| Key | Action |
| --- | --- |
| `<leader>lg` | Open LazyGit |
| `<leader>gc` | Generate AI commit message (Gemini) |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff current buffer |
| `<leader>dv` | Diffview menu |

### Sessions (Persistence)
| Key | Action |
| --- | --- |
| `<leader>qs` | Restore session (current directory) |
| `<leader>ql` | Restore last session |
| `<leader>qS` | Select session from picker |
| `<leader>qd` | Don't save current session |

### AI (CodeCompanion)
| Key | Action |
| --- | --- |
| `<leader>cc` | CodeCompanion actions menu |
| `<leader>ct` | Toggle AI chat |

---

## Extras
- **Swap Esc & Caps**: `Swap-Esc-Caps.reg` is included in the root folder to swap Caps Lock and Escape on Windows. Run it and log out / restart to apply.
