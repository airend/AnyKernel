#!/bin/sh

KFLAV=Elefrant-AK2

cd ~/Android/KernelPackr; OUT=../REPO/kernel/lge/hammerhead

cp -f $OUT/arch/arm/boot/zImage-dtb zImage

if [ -f "../$KFLAV.zip" ]; then mv ../$KFLAV.zip ../$KFLAV.zip.bak; fi

zip -r9 ../$KFLAV.zip anykernel.sh META-INF ramdisk tools zImage; rm -f zImage
