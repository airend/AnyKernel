#!/bin/sh

cd ~/Android/KernelPackr; OUT=$OUT_DIR_COMMON_BASE/AOSP

if [ -n "$1" ]; then DEV=$1; else DEV=ovation; fi

ASSERT='assert(getprop("ro.product.device") == "variant" || getprop("ro.build.product") == "variant" || abort("This package is for device: variant; this device is " + getprop("ro.product.device") + "."););'

echo $ASSERT | sed -e "s/variant/${DEV}/g" > META-INF/com/google/android/updater-script

cat updater-script >> META-INF/com/google/android/updater-script

rm -f recovery.img; cp $OUT/target/product/$DEV/recovery.img .

if [ -f "../recovery-$DEV.zip" ]; then mv ../recovery-$DEV.zip ../recovery-$DEV.zip.bak; fi

zip -r9 ../recovery-$DEV.zip recovery.img META-INF; rm -rf recovery.img
