#!/bin/bash
# Quick apk shortcut commands
# for android app analysis and
# repackaging

CMD="$1"
APK="$2"

if [ "$CMD" == "unpack" ]; then
    apktool d $APK
    jadx $APK
elif [ "$CMD" == "sign" ]; then
    if [ -f "~/apk.keystore" ]; then
        echo "Using previously generated keystore"
    else
        echo "Generating ~/apk.keystore"
        pushd ~ > /dev/null 2>&1
        keytool -genkey -v -keystore apk.keystore -alias apk -keyalg RSA -keysize 2048 -validity 10000
        popd > /dev/null 2>&1
    fi
    jarsigner -keystore ~/apk.keystore $APK apk
elif [ "$CMD" == "reinstall" ]; then
    apktool b $APK
    sign $APK/dist/$APK.apk
    adb install $APK/dist/$APK.apk
else
    echo "Command doesn't exist"
fi
