# Neovim Base Config

# Requirements:
## -- Windows
make
npm

# Setup
Winget :  
```
winget install -e --id MSYS2.MSYS2
winget install -e --id OpenJS.NodeJS
```
  
Run in MSYS2 MinGW64 terminal :  
```
pacman -S --needed base-devel mingw-w64-x86_64-toolchain
which make
```
Add msys64\mingw64\bin path to your PATH environment variable :  
/usr/bin/make → C:\msys64\usr\bin  
/mingw64/bin/make → C:\msys64\mingw64\bin
  
Clone the repo into %APPDATA%/local/nvim/ (Create the folder nvim if it does not exist)
