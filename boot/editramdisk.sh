#!/sbin/sh

mkdir /tmp/ramdisk
cp /tmp/boot.img-ramdisk.gz /tmp/ramdisk/
cd /tmp/ramdisk/
gunzip -c /tmp/ramdisk/boot.img-ramdisk.gz | cpio -i
rm /tmp/ramdisk/boot.img-ramdisk.gz
rm /tmp/boot.img-ramdisk.gz

#Start elementalx script
if [ $(grep -c "import /init.elementalx.rc" /tmp/ramdisk/init.rc) == 0 ]; then
   sed -i "/import \/init\.trace\.rc/aimport /init.elementalx.rc" /tmp/ramdisk/init.rc
fi

#copy elementalx scripts
cp /tmp/elementalx.sh /tmp/ramdisk/sbin/elementalx.sh
chmod 755 /tmp/ramdisk/sbin/elementalx.sh
cp /tmp/init.elementalx.rc /tmp/ramdisk/init.elementalx.rc

#F2FS on /data
if  ! grep -q '/data.*f2fs' /tmp/ramdisk/fstab.hammerhead; then
   sed -i 's@.*by-name/userdata.*@/dev/block/platform/msm_sdcc.1/by-name/userdata     /data           f2fs    rw,noatime,nosuid,nodev,nodiratime,inline_xattr wait,check,encryptable=/dev/block/platform/msm_sdcc.1/by-name/metadata\n&@' /tmp/ramdisk/fstab.hammerhead
else
   sed -i 's@.*/data.*f2fs.*@/dev/block/platform/msm_sdcc.1/by-name/userdata     /data           f2fs    rw,noatime,nosuid,nodev,nodiratime,inline_xattr wait,check,encryptable=/dev/block/platform/msm_sdcc.1/by-name/metadata@' /tmp/ramdisk/fstab.hammerhead
fi

#F2FS on /cache
if  ! grep -q '/cache.*f2fs' /tmp/ramdisk/fstab.hammerhead; then
   sed -i 's@.*by-name/cache.*@/dev/block/platform/msm_sdcc.1/by-name/cache        /cache          f2fs    rw,noatime,nosuid,nodev,nodiratime,inline_xattr wait,check\n&@' /tmp/ramdisk/fstab.hammerhead
else
   sed -i 's@.*/cache.*f2fs.*@/dev/block/platform/msm_sdcc.1/by-name/cache        /cache          f2fs    rw,noatime,nosuid,nodev,nodiratime,inline_xattr wait,check@' /tmp/ramdisk/fstab.hammerhead
fi

#Copy modified sepolicy for SuperSU 2.50
#cp /tmp/sepolicy /tmp/ramdisk/sepolicy

if  ! grep -qr init.d /tmp/ramdisk/*; then
   echo "" >> /tmp/ramdisk/init.rc
   echo "service userinit /system/xbin/busybox run-parts /system/etc/init.d" >> /tmp/ramdisk/init.rc
   echo "    oneshot" >> /tmp/ramdisk/init.rc
   echo "    class late_start" >> /tmp/ramdisk/init.rc
   echo "    user root" >> /tmp/ramdisk/init.rc
   echo "    group root" >> /tmp/ramdisk/init.rc
fi

echo "xprivacy453 u:object_r:system_server_service:s0\n" >> /tmp/service_contexts

#Tweak mpdecision
sed -i '/service mpdecision/c\service mpdecision /system/bin/mpdecision --avg_comp --Nw=1:1.99 --Nw=2:2.99 --Nw=3:3.99 --Tw=2:140 --Tw=3:140 --Ts=2:190 --Ts=3:190' /tmp/ramdisk/init.hammerhead.rc

#Disable thermal-engine
if [ $(grep -c "service thermal-engine" /tmp/ramdisk/init.hammerhead.rc) == 1 ]; then
   sed -i "/service thermal-engine/{N;N;N;N;d}" /tmp/ramdisk/init.hammerhead.rc
fi

#Insecure kernel
if [ "`grep INSECURE=1 /system/etc/elementalx.conf`" ]; then
  sed -i 's/ro.secure=1/ro.secure=0/' /tmp/ramdisk/default.prop
  sed -i 's/ro.adb.secure=1/ro.adb.secure=0/' /tmp/ramdisk/default.prop
fi

find . | cpio -o -H newc | gzip > /tmp/boot.img-ramdisk.gz
rm -r /tmp/ramdisk

