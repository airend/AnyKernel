#!/sbin/sh

if [ ! -f /system/xbin/busybox ]; then
   cp /tmp/busybox /system/xbin/busybox; 
   chmod 755 /system/xbin/busybox;
   /system/xbin/busybox --install -s /system/xbin
fi

if [ ! -f /sdcard/.elementalx.backup ]; then
   cp /tmp/elementalx.conf /system/etc/elementalx.conf;
else
   cp /sdcard/.elementalx.backup /system/etc/elementalx.conf;
fi
