A plug-and-play Neovim setup designed to work smoothly on Windows or Linux while providing all the essential modern features: autocompletion, snippets, treesitter, telescope, LSP, file explorer, formatting, debugging, UI improvements, and more.

Some plugins in this configuration optionally compile small native modules (e.g., telescope-fzf-native, LuaSnip’s JS regex).  
To avoid errors, follow the installation steps below.

# Requirements 

Install these tools before launching Neovim for the first time.  
They ensure plugins can build their optional native components.

##Linux

```
# Essential build tools
sudo apt update
sudo apt install -y build-essential curl git unzip wget

# For Tree-sitter C parsers
sudo apt install -y gcc clang

# Python and pip
sudo apt install -y python3 python3-pip

# Node.js and npm (needed for some LSPs and debug adapters)
sudo apt install -y nodejs npm

# Java (for nvim-jdtls)
sudo apt install -y openjdk-21-jdk

# ripgrep (optional, for telescope live grep search)
sudo apt install -y ripgrep
```


##Windows

### 1) git, node.js + npm, python, jdk 21
```
winget install --id Git.Git -e
winget install --id OpenJS.NodeJS -e
winget install --id Python.Python.3 -e
winget install Oracle.JDK.21
```

### 2) Install Make / Build Tools

for an easier installation use chocolatey, to see if u already have it
```
choco -version
```
Install Chocolatey (Powershell - Run as administrator since choco install needs perms):
```
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Install build tools using choco:
```
choco install make -y
choco install mingw -y
```

### 3) Optional but recommended
```
winget install --id BurntSushi.ripgrep.MSVC -e
```

### For java lsp and debugging features make sure u have jdk 21 installed and added to path
Check with : 
```
java -version
```


## Installing This Neovim Config

Clone this repository and move all the files into :

```
%APPDATA%\Local\nvim\  (create the folder if it doesn't exist)
```


After installation:

1. Start Neovim
2. Lazy.nvim will install all plugins
3. Optional build steps will automatically run only if `make` + a compiler are installed

* If `make` or a compiler is not installed, plugin builds are skipped automatically — Neovim still works fine.
* Zig is highly recommended on Windows for its compatibility with C build steps.
* MSYS2 is optional and mostly for advanced users who want full capabilities.
