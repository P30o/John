bash
dpkg-scanpackages -m . /dev/null > Packages
gzip -c Packages > Packages.gz
