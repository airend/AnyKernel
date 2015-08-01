#!/bin/sh

KFLAV=Elefrant-N5-express

cd ~/Android/KernelPackr; OUT=../REPO/kernel/lge/hammerhead

cp -f $OUT/arch/arm/boot/zImage-dtb boot/elex.zImage

if [ -f "../$KFLAV.zip" ]; then mv ../$KFLAV.zip ../$KFLAV.zip.bak; fi

zip -r9 ../$KFLAV.zip META-INF boot config system thermal