#!/bin/sh

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

if [ ! -e /usr/lib/filepeace ]; then sudo mkdir /usr/lib/filepeace; fi

echo "Installing filepeace..." && echo "- Installing filepeace command in /usr/bin..."
sudo cp -f filepeace /usr/bin
echo "- Turning filepeace into an executable..."
sudo chmod +x /usr/bin/filepeace

echo "Installing filepeace suite's apps..."

echo "Installing webpresent..."
cd include/webpresent
if [ ! -e .git ]; then git clone --no-checkout https://github.com/FilePeace/webpresent.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && sh ./install.sh
cd "$SCRIPTPATH"

echo "Installing folderstamp..."
cd include/folderstamp
if [ ! -e .git ]; then git clone --no-checkout https://github.com/FilePeace/folderstamp.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && sh ./install.sh
cd "$SCRIPTPATH"

echo "Installing verifact-hash..."
cd include/verifact-hash
if [ ! -e .git ]; then git clone --no-checkout https://github.com/FilePeace/verifact-hash.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && sh ./install.sh
cd "$SCRIPTPATH"

echo "Installing recordings-tools..."
cd include/recordings-tools
if [ ! -e .git ]; then git clone --no-checkout https://github.com/FilePeace/recordings-tools.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && sh ./install.sh
cd "$SCRIPTPATH"

echo "Installing icon for FilePeace..."
cp icon.svg /usr/share/icons/hicolor/scalable/apps/
sudo gtk-update-icon-cache /usr/share/icons/gnome/ -f

echo "Done! Run 'filepeace' command to use it." && exit
