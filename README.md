A plug-and-play Neovim setup designed to work smoothly on Windows or Linux while providing all the essential modern features: autocompletion, snippets, treesitter, telescope, LSP, file explorer, formatting, debugging, UI improvements, and more.

Some plugins in this configuration optionally compile small native modules (e.g., telescope-fzf-native, LuaSnip’s JS regex).  
To avoid errors on Windows, follow the installation steps below.

## Requirements (Windows)

Install these tools before launching Neovim for the first time.  
They ensure plugins can build their optional native components.

### 1. Install make

Required by several plugins during installation.

### 2. Install Node.js (for LuaSnip)

LuaSnip’s optional build for advanced regex inside snippet triggers needs npm for installation.

```
winget install OpenJS.NodeJS
```


## 3. Install a C Compiler (choose ONE)

### Option A — Zig (recommended)
```
winget install Zig.Zig
```

### Option B — LLVM / Clang
```
winget install LLVM.LLVM
```

### Option C — MSYS2 + GCC
Only for users who specifically want advanced regex inside snippet triggers or native telescope for speed.

1. Install MSYS2:
   ```
   winget install MSYS2.MSYS2
   ```

2. Open the **MSYS2 MinGW64** terminal and run:
   ```
   pacman -S --needed base-devel mingw-w64-x86_64-toolchain
   which make
   ```

3. Add MSYS2 binaries to PATH:
   ```
   C:\msys64\usr\bin
   C:\msys64\mingw64\bin
   ```

## Installing This Neovim Config

Clone this repository and move all the files into :

```
%APPDATA%\Local\nvim\  (create the folder if it doesn't exist)
```


After installation:

1. Start Neovim
2. Lazy.nvim will install all plugins
3. Build steps will automatically run only if `make` + a compiler are installed

* If `make` or a compiler is not installed, plugin builds are skipped automatically — Neovim still works fine.
* Zig is highly recommended on Windows for its compatibility with C build steps.
* MSYS2 is optional and mostly for advanced users who want full capabilities.
