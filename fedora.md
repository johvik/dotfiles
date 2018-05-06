# Packages
```
sudo dnf install vim
sudo dnf install owncloud-client
sudo dnf install keepass
```

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
