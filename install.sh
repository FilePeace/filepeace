#!/bin/sh

rocketlaunch_dir=`pwd` #from https://unix.stackexchange.com/a/52919/470623

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
cd "$rocketlaunch_dir"

echo "Installing folderstamp..."
cd include/folderstamp
if [ ! -e .git ]; then git clone --no-checkout https://github.com/FilePeace/folderstamp.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && sh ./install.sh
cd "$rocketlaunch_dir"

echo "Installing verifact-hash..."
cd include/verifact-hash
if [ ! -e .git ]; then git clone --no-checkout https://github.com/FilePeace/verifact-hash.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && sh ./install.sh
cd "$rocketlaunch_dir"

echo "Installing recordings-tools..."
cd include/recordings-tools
if [ ! -e .git ]; then git clone --no-checkout https://github.com/FilePeace/recordings-tools.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && sh ./install.sh
cd "$rocketlaunch_dir"

echo "Installing mimetypes and their icons..." # this is continuously adding the same entries to /etc/mime.types and have to be fixed
cat >> /etc/mime.types <<EOF
text/x-md5			        md5
text/x-sha256			    sha256
text/x-md5sum			    md5sum
text/x-sha256sum			sha256sum
EOF
#-<- should check if line is already added, before re-adding!
cat > /usr/share/mime/packages/x-md5.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns='http://www.freedesktop.org/standards/shared-mime-info'>
  <mime-type type="text/x-md5">
    <comment>MD5 hash checksum file</comment>
    <generic-icon name="text-x-md5"/>
    <glob pattern="*.md5"/>
  </mime-type>
</mime-info>

EOF
cat > /usr/share/mime/packages/x-sha256.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns='http://www.freedesktop.org/standards/shared-mime-info'>
  <mime-type type="text/x-sha256">
    <comment>SHA256 hash checksum file</comment>
    <generic-icon name="text-x-sha256"/>
    <glob pattern="*.sha256"/>
  </mime-type>
</mime-info>

EOF
cat > /usr/share/mime/packages/x-md5sum.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns='http://www.freedesktop.org/standards/shared-mime-info'>
  <mime-type type="text/x-md5sum">
    <comment>MD5 hash checksum file</comment>
    <generic-icon name="text-x-md5sum"/>
    <glob pattern="*.md5sum"/>
  </mime-type>
</mime-info>

EOF
cat > /usr/share/mime/packages/x-sha256sum.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns='http://www.freedesktop.org/standards/shared-mime-info'>
  <mime-type type="text/x-sha256sum">
    <comment>SHA256 hash checksum file</comment>
    <generic-icon name="text-x-sha256sum"/>
    <glob pattern="*.sha256sum"/>
  </mime-type>
</mime-info>

EOF
$maysudo update-mime-database /usr/share/mime

echo "Installing icons for .md5 and .sha256 files..."
cd include/icons
cp -r -f --preserve=all . /usr/share/icons/hicolor/scalable/mimetypes/
cd "$rocketlaunch_dir"
$maysudo gtk-update-icon-cache /usr/share/icons/gnome/ -f

echo "Installing icon for FilePeace..."
cp icon.svg /usr/share/icons/hicolor/scalable/apps/
sudo gtk-update-icon-cache /usr/share/icons/gnome/ -f

echo "Done! Run 'filepeace' command to use it." && exit
