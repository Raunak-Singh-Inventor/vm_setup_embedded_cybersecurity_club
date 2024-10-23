set -x 

# Dock icons
gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Calculator.desktop', 'code_code.desktop', 'firefox_firefox.desktop']"

# Random settings
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 36
gsettings set org.gnome.shell.extensions.desktop-icons show-home false
gsettings set org.gnome.TextEditor restore-session false
gsettings set org.gnome.TextEditor spellcheck false
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

# Terminal colors
dconf write /org/gnome/terminal/legacy/profiles:/$(dconf list /org/gnome/terminal/legacy/profiles:/ | tail -n 1)use-theme-colors false
dconf write /org/gnome/terminal/legacy/profiles:/$(dconf list /org/gnome/terminal/legacy/profiles:/ | tail -n 1)foreground-color "'rgb(255,255,255)'"
dconf write /org/gnome/terminal/legacy/profiles:/$(dconf list /org/gnome/terminal/legacy/profiles:/ | tail -n 1)background-color "'rgb(0,0,0)'"

# remove crap in home dir
xdg-user-dirs-update --set DISABLED ~/.config/user-dirs.dirs
cat ~/.config/user-dirs.dirs | head -n 9 > ~/.config/user-dirs.dirs.tmp
rm -rf ~/.config/user-dirs.dirs
mv ~/.config/user-dirs.dirs.tmp ~/.config/user-dirs.dirs
rm -rf ~/Documents
rm -rf ~/Music
rm -rf ~/Pictures
rm -rf ~/Videos
rm -rf ~/Public
rm -rf ~/Templates
echo "no" > ~/.config/gtk-3.0/bookmarks

# Ghidra config
wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.0.3_build/ghidra_11.0.3_PUBLIC_20240410.zip
unzip ./ghidra_11.0.3_PUBLIC_20240410.zip -d /opt/
mkdir -p /home/$USERNAME/.ghidra/.ghidra_11.0.3_PUBLIC  
echo "Theme=Class\:generic.theme.builtin.FlatDarkTheme" > /home/$USERNAME/.ghidra/.ghidra_11.0.3_PUBLIC/preferences
rm -rf ~/ghidra*

# VS Code extensions
code --install-extension ms-python.python
code --install-extension ms-vscode.cpptools-extension-pack
code --install-extension ms-vscode-remote.vscode-remote-extensionpack
code --install-extension ms-vscode.vscode-serial-monitor

# vs code settings.json
mkdir -p ~/.config/Code/User/
echo "{" > ~/.config/Code/User/settings.json
echo "    \"workbench.startupEditor\": \"none\"," >> ~/.config/Code/User/settings.json
echo "    \"security.workspace.trust.enabled\": false," >> ~/.config/Code/User/settings.json
echo "    \"files.autoSave\": \"afterDelay\"" >> ~/.config/Code/User/settings.json
echo "}" >> ~/.config/Code/User/settings.json

# bashrc prompt modification
echo "export PS1='\[\e[49m\]\[\e[0;39m\]\[\e[1;94m\]\w\[\e[93m\] $ \[\e[0;39m\]'" >> ~/.bashrc

# Firefox
FF_PROFILE=$(cat ~/snap/firefox/common/.mozilla/firefox/profiles.ini | grep Path | awk -F "=" '{ print $2 }')
FF_PROFILE_PATH=~/snap/firefox/common/.mozilla/firefox/$FF_PROFILE/

# Setting up Python virtual environment
(cd /home/$USERNAME; python3 -m venv ./.venv)
source /home/$USERNAME/.venv/bin/activate
python3 -m pip install -r "/$PWD/requirements.txt"
echo "source ~/.venv/bin/activate" >> ~/.bashrc

echo "user_pref(\"app.normandy.first_run\", false);" > $FF_PROFILE_PATH/user.js
echo "user_pref(\"toolkit.telemetry.reportingpolicy.firstRun\", false);" >> $FF_PROFILE_PATH/user.js
echo "user_pref(\"trailhead.firstrun.didSeeAboutWelcome\", true);" >> $FF_PROFILE_PATH/user.js
echo "user_pref(\"browser.toolbars.bookmarks.visibility\", \"never\");" >> $FF_PROFILE_PATH/user.js
echo "user_pref(\"browser.uiCustomization.state\", \"{\\\"placements\\\":{\\\"widget-overflow-fixed-list\\\":[],\\\"unified-extensions-area\\\":[],\\\"nav-bar\\\":[\\\"back-button\\\",\\\"forward-button\\\",\\\"stop-reload-button\\\",\\\"urlbar-container\\\",\\\"downloads-button\\\",\\\"unified-extensions-button\\\"],\\\"toolbar-menubar\\\":[\\\"menubar-items\\\"],\\\"TabsToolbar\\\":[\\\"tabbrowser-tabs\\\",\\\"new-tab-button\\\",\\\"alltabs-button\\\"],\\\"PersonalToolbar\\\":[\\\"import-button\\\",\\\"personal-bookmarks\\\"]},\\\"seen\\\":[\\\"save-to-pocket-button\\\",\\\"developer-button\\\"],\\\"dirtyAreaCache\\\":[\\\"nav-bar\\\",\\\"PersonalToolbar\\\",\\\"toolbar-menubar\\\",\\\"TabsToolbar\\\"],\\\"currentVersion\\\":20,\\\"newElementCount\\\":3}\");" >> $FF_PROFILE_PATH/user.js
echo "user_pref(\"browser.newtabpage.activity-stream.feeds.section.topstories\", false);" >> $FF_PROFILE_PATH/user.js
echo "user_pref(\"browser.newtabpage.activity-stream.feeds.topsites\", false);" >> $FF_PROFILE_PATH/user.js
echo "user_pref(\"browser.newtabpage.activity-stream.showSponsored\", false);" >> $FF_PROFILE_PATH/user.js
echo "user_pref(\"browser.newtabpage.activity-stream.showSponsoredTopSites\", false);" >> $FF_PROFILE_PATH/user.js

rm ~/.bash_history