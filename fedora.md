# Packages
```
sudo dnf install vim
sudo dnf install vim-default-editor --allowerasing
sudo dnf install keepass
```

# Google drive
https://github.com/odeke-em/drive

# Configuration
## KeePass
Select Lock workspace after KeePass inactivity
## Gnome
```
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']" # Remove <Alt>Tab
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']" # Remove <Shift><Alt>Tab
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"
```
