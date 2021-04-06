#!/bin/bash
./bin/pacapt install python3-pip zsh gpg-agent syncthing
pip3 install supervisor


# Packages
# syncthing
# curl -s https://api.github.com/repos/syncthing/syncthing/releases/latest | grep 'browser_download_url.*linux-amd64.*\.tar.gz' | cut -d: -f2,3 | tr -d \" | wget -i -
# supervisor
# curl -s https://github.com/Supervisor/supervisor/archive/refs/tags/4.2.2.tar.gz

