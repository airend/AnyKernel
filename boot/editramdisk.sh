#!/sbin/sh

mkdir /tmp/ramdisk
cp /tmp/boot.img-ramdisk.gz /tmp/ramdisk/
cd /tmp/ramdisk/
gunzip -c /tmp/ramdisk/boot.img-ramdisk.gz | cpio -i
rm /tmp/ramdisk/boot.img-ramdisk.gz
rm /tmp/boot.img-ramdisk.gz

#F2FS on /data
if  ! grep -q '/data.*f2fs' /tmp/ramdisk/fstab.hammerhead; then
   sed -i 's@.*by-name/userdata.*@/dev/block/platform/msm_sdcc.1/by-name/userdata     /data           f2fs    rw,noatime,nosuid,nodev,discard,nodiratime,inline_xattr,inline_data,active_logs=4 wait,check,encryptable=/dev/block/platform/msm_sdcc.1/by-name/metadata\n&@' /tmp/ramdisk/fstab.hammerhead
fi

#F2FS on /cache
if  ! grep -q '/cache.*f2fs' /tmp/ramdisk/fstab.hammerhead; then
   sed -i 's@.*by-name/cache.*@/dev/block/platform/msm_sdcc.1/by-name/cache        /cache          f2fs    rw,noatime,nosuid,nodev,discard,nodiratime,inline_xattr,inline_data,active_logs=4 wait,check\n&@' /tmp/ramdisk/fstab.hammerhead
fi

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



find . | cpio -o -H newc | gzip > /tmp/boot.img-ramdisk.gz
rm -r /tmp/ramdisk

