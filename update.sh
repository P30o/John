#!/usr/bin/env bash

# الانتقال إلى مجلد السكربت
cd "$(dirname "$0")"

# إنشاء ملفات Packages وPackages.gz وPackages.bz2
dpkg-scanpackages -m ./debfiles /dev/null > Packages
gzip -c Packages > Packages.gz
bzip2 -c Packages > Packages.bz2

# إنشاء ملف override
echo "إنشاء ملف override..."
echo "com.johnspire.tiktok: priority optional" > override
echo "com.johnspire.youtube: priority optional" >> override

echo "تم إنشاء ملفات Packages وPackages.gz وPackages.bz2 بنجاح."
