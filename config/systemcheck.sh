#!/sbin/sh

if [ ! -f /system/xbin/busybox ]; then
   cp /tmp/busybox /system/xbin/busybox; 
   chmod 755 /system/xbin/busybox;
   /system/xbin/busybox --install -s /system/xbin
fi

if [ ! -d /system/etc/init.d ]; then
   if [ -f /system/etc/init.d ]; then
      mv /system/etc/init.d /system/etc/init.d.bak;
   fi
   mkdir /system/etc/init.d;
fi

if [ ! -f /sdcard/.elementalx.backup ]; then
   cp /tmp/elementalx.conf /system/etc/elementalx.conf;
else
   cp /sdcard/.elementalx.backup /system/etc/elementalx.conf;
fi

if [ "`grep THERM=1 /system/etc/elementalx.conf`" ]; then
  cp /tmp/elexcool/thermal-engine-8974.conf /system/etc/thermal-engine-8974.conf
elif [ "`grep THERM=2 /system/etc/elementalx.conf`" ]; then
  cp /tmp/extracool/thermal-engine-8974.conf /system/etc/thermal-engine-8974.conf
elif [ "`grep THERM=3 /system/etc/elementalx.conf`" ]; then
  cp /tmp/stockcool/thermal-engine-8974.conf /system/etc/thermal-engine-8974.conf
fi
