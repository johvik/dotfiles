# Packages
```
sudo dnf install vim meld keepassxc
sudo dnf install vim-default-editor --allowerasing
```

# Google drive
https://github.com/odeke-em/drive

```go install github.com/odeke-em/drive/cmd/drive@latest```

https://github.com/odeke-em/drive/pull/1142 is needed if not yet merged. Note that one may need to set GOOGLE_API_CLIENT_ID and GOOGLE_API_CLIENT_SECRET.


# Configuration
## KeePassXC
Google drive sync before start and on exit (e.g. ~/bin/keepassxc):
```
#!/bin/bash

gnome-terminal --wait -- <go drive path>/drive-google pull <db path>/db.kdbx

/usr/bin/keepassxc

gnome-terminal --wait -- <go drive path>/drive-google push <db path>/db.kdbx
```

Configurations:
* Disable automatic save after every change
* Disable automatic save when locking database
* Disable save non-data changes when locking database
* Lock database after inactivity of 360 sec
* Increase password generator length to >= 30

## Gnome
```
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']" # Remove <Alt>Tab
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']" # Remove <Shift><Alt>Tab
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"
```
