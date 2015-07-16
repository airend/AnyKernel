#!/bin/sh

cd ~/Android/KernelPackr; OUT=../REPO/out

if [ -n "$1" ]; then DEV=$1; else DEV=ovation; fi

ASSERT='assert(getprop("ro.product.device") == "variant" || getprop("ro.build.product") == "variant" || abort("This package is for device: variant; this device is " + getprop("ro.product.device") + "."););'

echo $ASSERT | sed -e "s/variant/${DEV}/g" > META-INF/com/google/android/updater-script

cat updater-script >> META-INF/com/google/android/updater-script

rm -rf boot.img system; mkdir -p system/lib/modules

cp $OUT/target/product/$DEV/boot.img .

cp $OUT/target/product/$DEV/system/lib/modules/* system/lib/modules

if [ -f "../kernel-$DEV.zip" ]; then mv ../kernel-$DEV.zip ../kernel-$DEV.zip.bak; fi

zip -r9 ../kernel-$DEV.zip boot.img system META-INF; rm -rf boot.img system
