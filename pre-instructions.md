## Ubuntu Server (macOS Apple Silicon)
- Enable Apple virtualization during VM setup (You can't switch to this later)
- Install Ubuntu 24.04 server
- Chose "Erase disk and install ubuntu", default partitioning options
- UNCHECK the LVM disk option
- hostname: `embsec`
- username: `hacker`
- password: `password`
- Reboot
- `sudo apt update`
- `sudo apt upgrade`
- Reccomend shutting down and exporting the VM here so you can get back if something goes wrong
- `sudo apt install ubuntu-desktop minimal`

## Ubuntu 24.04 desktop (macOS Intel or Windows)
- Click "Try or Install Ubuntu"
- Click "Install Ubuntu 22.04..." icon on the Desktop
- Choose "Minimal installation"
- Check "download updates and 3rd party software"
- Chose "Erase disk and install ubuntu", default partitioning options
- hostname: `embsec`
- username: `hacker`
- password: `password`
- Log in automatically: yes
- don't use active directory

## VirtioFS (for file sharing on Apple Virtualization engine)
```bash
sudo mkdir -p /shared
sudo mount -t virtiofs share /shared
```

## After install:
- Open terminal
- Preferences
- Profiles -> unnamed
- Text -> Uncheck Terminal bell
- Check Custom font and select Ubuntu Mono 12
- Colors
- Uncheck "Use colors from system theme"

- Drag everything out of utilities folder in app menu so utilities goes away (gnome might crash when you do this, that's OK)
    - If it hangs logging back in, take the VM out of fullscreen mode
- `sudo systemctl disable pd-mapper`
- `sudo systemctl disable systemd-networkd-wait-online`

## Install VS Code
- Open firefox
- Download appropriate VS code (arm64 or amd64 from) https://code.visualstudio.com/Download
- Close firefox
- run this to avoid apt permissions issue: `sudo chown _apt /var/lib/update-notifier/package-data-downloads/partial/`
- Install VS Code deb: `sudo apt install ./code_whatever_arm.deb`
- Delete deb file from downloads

## Prep scripts
- Run `chmod +x` on both scripts from this repo
