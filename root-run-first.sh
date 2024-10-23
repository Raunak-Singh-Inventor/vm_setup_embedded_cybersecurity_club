#!/bin/bash

# REMEMBER TO RUN THIS AS SUPERUSER!!
export DEBIAN_FRONTEND=noninteractive

# Remove printer stuff, we don't need it
apt-get remove -y bluez-cups cups-browsed cups-bsd cups-client cups-common cups-core-drivers cups-daemon cups-filters-core-drivers cups-filters cups-ipp-utils cups-pk-helper cups-ppdc cups-server-common cups libcupsimage2 printer-driver-hpcups

# Remove other stuff
apt-get remove -y baobab seahorse gnome-disk-utility gnome-clocks
apt-get autoremove -y

# remove snap junk
snap remove firmware-updater snap-store

apt-get update
apt-get -y upgrade

apt-get install -y git open-vm-tools build-essential curl wget less dbus-x11 sl openjdk-21-jdk file htop btop tmux psmisc net-tools cmatrix bsdmainutils openssh-server netcat-traditional python3 python3-pip python3-venv lm4flash picocom

apt-get install -y gcc-arm-none-eabi binutils-arm-none-eabi libc6-dev-armhf-cross gcc-arm-linux-gnueabi gdb-multiarch

# Docker setup
apt-get install -y docker.io
usermod -aG docker hacker

# Permissions to read and write from serial (seems to be an issue with Ubuntu 24)
usermod -a -G dialout $USER

# Set up serial communication script
touch /bin/car-serial
echo "#!/bin/sh" >> /bin/car-serial
echo "picocom /dev/ttyACM0 -b 115200 --imap lfcrlf" >> /bin/car-serial
chmod +x /bin/car-serial

# Ghidra prep
chmod 777 /opt/

touch /usr/share/applications/ghidra.desktop
echo "[Desktop Entry]" >> /usr/share/applications/ghidra.desktop
echo "Version=1.0" >> /usr/share/applications/ghidra.desktop
echo "Name=Ghidra" >> /usr/share/applications/ghidra.desktop
echo "Comment=Ghidra is a software reverse engineering (SRE) framework created and maintained by the National Security Agency Research Directorate." >> /usr/share/applications/ghidra.desktop
echo "Exec=/opt/ghidra_11.0.3_PUBLIC/ghidraRun" >> /usr/share/applications/ghidra.desktop
echo "Type=Application" >> /usr/share/applications/ghidra.desktop
echo "Icon=/opt/ghidra_11.0.3_PUBLIC/docs/GhidraClass/Intermediate/Images/GhidraLogo64.png" >> /usr/share/applications/ghidra.desktop
chmod +x /usr/share/applications/ghidra.desktop

# Get rid of junk in menu
echo "NoDisplay=true" >> /usr/share/applications/software-properties-drivers.desktop
echo "NoDisplay=true" >> /usr/share/applications/gnome-language-selector.desktop
echo "NoDisplay=true" >> /usr/share/applications/org.gnome.DiskUtility.desktop
echo "NoDisplay=true" >> /usr/share/applications/org.gnome.PowerStats.desktop
echo "NoDisplay=true" >> /usr/share/applications/org.gnome.eog.desktop
echo "NoDisplay=true" >> /usr/share/applications/org.gnome.Characters.desktop
echo "NoDisplay=true" >> /usr/share/applications/org.gnome.font-viewer.desktop
echo "NoDisplay=true" >> /usr/share/applications/org.gnome.Logs.desktop
echo "NoDisplay=true" >> /usr/share/applications/update-manager.desktop
echo "NoDisplay=true" >> /usr/share/applications/software-properties-gtk.desktop
echo "NoDisplay=true" >> /usr/share/applications/yelp.desktop
echo "NoDisplay=true" >> /usr/share/applications/nm-connection-editor.desktop
echo "NoDisplay=true" >> /usr/share/applications/gnome-session-properties.desktop
echo "NoDisplay=true" >> /usr/share/applications/htop.desktop
echo "NoDisplay=true" >> /usr/share/applications/btop.desktop

# NoDisplay=true has to go before the [Desktop Action New Window] section in Evince
cat /usr/share/applications/org.gnome.Evince.desktop | head -n 16 >> /usr/share/applications/evince-temp
echo "NoDisplay=true" >> /usr/share/applications/evince-temp
cat /usr/share/applications/org.gnome.Evince.desktop | tail -n 4 >> /usr/share/applications/evince-temp
rm -rf /usr/share/applications/org.gnome.Evince.desktop
mv /usr/share/applications/evince-temp /usr/share/applications/org.gnome.Evince.desktop

