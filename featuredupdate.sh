#!/bin/bash
git config --global --add safe.directory /private/var/mobile/John


# مسار إلى المستودع
REPO_PATH="/var/mobile/John"

# تحديث ملفات Packages
cd $REPO_PATH

echo "Rebuilding Packages file..."
dpkg-scanpackages ./debfiles > Packages

echo "Compressing Packages file..."
bzip2 -fks Packages
gzip -fk Packages

# تحديث ملف sileo-featured.json (إذا كان هناك أي تغييرات)
echo "Updating sileo-featured.json..."
cp ./sileo-featured.json $REPO_PATH/sileo-featured.json

# رفع التغييرات إلى GitHub
echo "Pushing changes to GitHub..."
git add --all
git commit -m "Updated Packages and sileo-featured.json"
git push origin main

echo "Update complete."
