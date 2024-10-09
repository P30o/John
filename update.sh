#!/usr/bin/env bash

# الانتقال إلى مجلد السكربت
cd "$(dirname "$0")"

# إنشاء ملفات Packages وPackages.gz وPackages.bz2
dpkg-scanpackages -m ./debfiles > Packages
gzip -c Packages > Packages.gz
bzip2 -c Packages > Packages.bz2

echo "تم إنشاء ملفات Packages وPackages.gz وPackages.bz2 بنجاح."

git add --all
git commit -m "Update Packages and override"
git push
