#!/bin/bash

# المجلد الذي يحتوي على الحزم
PACKAGE_DIR="debfiles"  # عدل هذا إلى المسار الصحيح إذا كان مختلفًا
OVERRIDE_FILE="override"

# تأكد من وجود ملف override
if [ ! -f "$OVERRIDE_FILE" ]; then
    touch "$OVERRIDE_FILE"
fi

# أفرغ محتويات ملف override
> "$OVERRIDE_FILE"

# إضافة المعلومات عن كل حزمة
for pkg in "$PACKAGE_DIR"/*.deb; do
    # احصل على اسم الحزمة
    pkg_name=$(dpkg-deb --info "$pkg" | grep Package | awk '{print $2}')
    # احصل على الإصدار
    pkg_version=$(dpkg-deb --info "$pkg" | grep Version | awk '{print $2}')
    # احصل على المعمارية
    pkg_arch=$(dpkg-deb --info "$pkg" | grep Architecture | awk '{print $2}')
    # احصل على الوصف
    pkg_desc=$(dpkg-deb --info "$pkg" | grep Description | sed 's/Description: //')
    # احصل على المؤلف
    pkg_author=$(dpkg-deb --info "$pkg" | grep Author | sed 's/Author: //')
    # احصل على الرابط الخاص بالتصوير
    pkg_depiction=$(dpkg-deb --info "$pkg" | grep Depiction | sed 's/Depiction: //')
    # احصل على الأيقونة
    pkg_icon=$(dpkg-deb --info "$pkg" | grep Icon | sed 's/Icon: //')

    # إضافة المعلومات إلى ملف override
    {
        echo "Package: $pkg_name"
        echo "Version: $pkg_version"
        echo "Architecture: $pkg_arch"
        echo "Maintainer: $pkg_author"
        echo "Description: $pkg_desc"
        echo "Depiction: $pkg_depiction"
        echo "Icon: $pkg_icon"
        echo ""
    } >> "$OVERRIDE_FILE"
done

echo "تم تحديث ملف override بنجاح."
