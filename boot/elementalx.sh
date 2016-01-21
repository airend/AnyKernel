#!/system/bin/sh

ELEX_CONF="/system/etc/elementalx.conf"
ELEX_LOGFILE="/data/local/tmp/elementalx.log"

if [ -f $ELEX_LOGFILE ]; then
  mv $ELEX_LOGFILE $ELEX_LOGFILE.2;
fi

echo $(date) >> $ELEX_LOGFILE

#Find PVS bin
PVS="`cat /sys/module/acpuclock_krait/parameters/pvs_number`"
echo PVS: $PVS >> $ELEX_LOGFILE;

#Set hotplugging
if [ "`grep HOTPLUG=1 $ELEX_CONF`" ]; then
  stop mpdecision
  echo 1 > /sys/devices/platform/msm_sleeper/enabled
  echo Custom hotplugging >> $ELEX_LOGFILE;
else
  echo 0 > /sys/devices/platform/msm_sleeper/enabled
fi

#Set Sweep2wake
S2W="`grep SWEEP2WAKE $ELEX_CONF | cut -d '=' -f2`"
  echo $S2W > /sys/android_touch/sweep2wake
  echo Sweep2wake $S2W >> $ELEX_LOGFILE;

#Set Doubletap2wake
if [ "`grep DT2W=1 $ELEX_CONF`" ]; then
  echo 1 > /sys/android_touch/doubletap2wake
  echo Doubletap2wake enabled >> $ELEX_LOGFILE;
elif [ "`grep DT2W=2 $ELEX_CONF`" ]; then
  echo 2 > /sys/android_touch/doubletap2wake
  echo Doubletap2wake fullscreen enabled >> $ELEX_LOGFILE;
else
  echo 0 > /sys/android_touch/doubletap2wake
  echo Doubletap2wake disabled >> $ELEX_LOGFILE;
fi

#Set Sweep2sleep
if [ "`grep S2S=1 $ELEX_CONF`" ]; then
  echo 1 > /sys/android_touch/sweep2sleep
  echo Sweep2sleep right enabled >> $ELEX_LOGFILE;
elif [ "`grep S2S=2 $ELEX_CONF`" ]; then
  echo 2 > /sys/android_touch/sweep2sleep
  echo Sweep2sleep left enabled >> $ELEX_LOGFILE;
elif [ "`grep S2S=3 $ELEX_CONF`" ]; then
  echo 3 > /sys/android_touch/sweep2sleep
  echo Sweep2sleep left and right enabled >> $ELEX_LOGFILE;
else
  echo 0 > /sys/android_touch/sweep2sleep
  echo Sweep2sleep disabled >> $ELEX_LOGFILE;
fi

#Set Wake vibration strength
VIB_STRENGTH="`grep VIB_STRENGTH $ELEX_CONF | cut -d '=' -f2`"
  echo $VIB_STRENGTH > /sys/android_touch/vib_strength
  echo Wake vibration strength $VIB_STRENGTH >> $ELEX_LOGFILE;

#Set S2W/DT2W Power Key Toggle
if [ "`grep PWR_KEY=1 $ELEX_CONF`" ]; then
  echo 1 > /sys/module/qpnp_power_on/parameters/pwrkey_suspend
  echo "Power key toggle for S2W/DT2W enabled" >> $ELEX_LOGFILE;
else
  echo 0 > /sys/module/qpnp_power_on/parameters/pwrkey_suspend
  echo "Power key toggle for S2W/DT2W disabled" >> $ELEX_LOGFILE;
fi

#Set S2W/DT2W Timeout
TIMEOUT=`grep "TIMEOUT" $ELEX_CONF | cut -d '=' -f2`
echo $TIMEOUT > /sys/android_touch/wake_timeout
echo S2W/DT2W Timeout\: $TIMEOUT >> $ELEX_LOGFILE;

#Set Camera launch gesture
if [ "`grep CAMERA_GESTURE=1 $ELEX_CONF`" ]; then
  echo 1 > /sys/android_touch/camera_gesture
  echo "Camera launch gesture enabled" >> $ELEX_LOGFILE;
else
  echo 0 > /sys/android_touch/camera_gesture
  echo "Camera launch gesture disabled" >> $ELEX_LOGFILE;
fi

#Set FASTCHARGE
if [ "`grep FC=1 $ELEX_CONF`" ]; then
  echo 1 > /sys/kernel/fast_charge/force_fast_charge
  echo USB Fastcharge enabled >> $ELEX_LOGFILE;
else
  echo 0 > /sys/kernel/fast_charge/force_fast_charge
  echo USB Fastcharge disabled >> $ELEX_LOGFILE;
fi

#Set Max screen off
if [ "`grep MAXSCROFF=1 $ELEX_CONF`" ]; then
  echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/screen_off_max
  echo Max screen off frequency enabled >> $ELEX_LOGFILE;
else
  echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/screen_off_max
  echo Max screen off frequency disabled >> $ELEX_LOGFILE;
fi

#Set Color
if [ "`grep COLOR=1 $ELEX_CONF`" ]; then
  echo 1 > /sys/module/mdss_dsi/parameters/color_preset
  echo Slightly cooler colors >> $ELEX_LOGFILE;
else
  echo 0 > /sys/module/mdss_dsi/parameters/color_preset
  echo Stock color >> $ELEX_LOGFILE;
fi

#Set Backlight
if [ "`grep BL=1 $ELEX_CONF`" ]; then
  echo 1 > /sys/module/lm3630_bl/parameters/backlight_dimmer
  echo Backlight dimmer enabled >> $ELEX_LOGFILE;
else
  echo 0 > /sys/module/lm3630_bl/parameters/backlight_dimmer
  echo Backlight dimmer disabled >> $ELEX_LOGFILE;
fi

#Set fsync
if [ "`grep FSYNC=0 $ELEX_CONF`" ]; then
  echo 0 > /sys/module/sync/parameters/fsync_enabled;
  echo fsync disabled >> $ELEX_LOGFILE;
else
  echo 1 > /sys/module/sync/parameters/fsync_enabled;
  echo fsync enabled >> $ELEX_LOGFILE;
fi

#Ondemand Governor
if [ "`grep CPU_GOV=0 $ELEX_CONF`" ]; then
  echo 1 > /sys/devices/system/cpu/cpu0/online;
  echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor;
  echo 1 > /sys/devices/system/cpu/cpu1/online;
  echo ondemand > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor;
  echo 1 > /sys/devices/system/cpu/cpu2/online;
  echo ondemand > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor;
  echo 1 > /sys/devices/system/cpu/cpu3/online;
  echo ondemand > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor;
  echo 90 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold;
  echo 50000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate;
  echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy;
  echo 4 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor;
  echo 10 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential;
  echo 80 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold_multi_core;
  echo 3 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential_multi_core;
  echo 300000 > /sys/devices/system/cpu/cpufreq/ondemand/optimal_freq;
  echo 300000 > /sys/devices/system/cpu/cpufreq/ondemand/sync_freq;
  echo 80 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold_any_cpu_load;
  echo Ondemand CPU governor >> $ELEX_LOGFILE;
fi

#GPU Governor settings
if [ "`grep GPU_GOV=3 $ELEX_CONF`" ]; then
  echo performance > /sys/class/kgsl/kgsl-3d0/pwrscale/trustzone/governor;
  echo Performance GPU Governor >> $ELEX_LOGFILE;
else
  echo ondemand > /sys/class/kgsl/kgsl-3d0/pwrscale/trustzone/governor;
  echo Ondemand GPU Governor >> $ELEX_LOGFILE;
fi

#vibrator settings
GVIB=`grep "GVIB" $ELEX_CONF | cut -d '=' -f2`
echo $GVIB > /sys/class/timed_output/vibrator/amp
echo Vibration strength\: $GVIB >> $ELEX_LOGFILE;

#io scheduler settings
SCHED=`grep "SCHED" $ELEX_CONF | cut -d '=' -f2`
if [ "`grep SCHED=1 $ELEX_CONF`" ]; then
  echo cfq > /sys/block/mmcblk0/queue/scheduler;
  echo CFQ io scheduler >> $ELEX_LOGFILE;
elif [ "`grep SCHED=3 $ELEX_CONF`" ]; then
  echo deadline > /sys/block/mmcblk0/queue/scheduler;
  echo deadline io scheduler >> $ELEX_LOGFILE;
elif [ "`grep SCHED=4 $ELEX_CONF`" ]; then
  echo fiops > /sys/block/mmcblk0/queue/scheduler;
  echo FIOPS io scheduler >> $ELEX_LOGFILE;
elif [ "`grep SCHED=5 $ELEX_CONF`" ]; then
  echo sio > /sys/block/mmcblk0/queue/scheduler;
  echo SIO io scheduler >> $ELEX_LOGFILE;
elif [ "`grep SCHED=6 $ELEX_CONF`" ]; then
  echo bfq > /sys/block/mmcblk0/queue/scheduler;
  echo BFQ io scheduler >> $ELEX_LOGFILE;
else
  echo row > /sys/block/mmcblk0/queue/scheduler;
  echo ROW io scheduler >> $ELEX_LOGFILE;
fi

#Readahead settings
READAHEAD=`grep "READAHEAD" $ELEX_CONF | cut -d '=' -f2`
echo $READAHEAD > /sys/block/mmcblk0/queue/read_ahead_kb
echo Readahead size\: $READAHEAD >> $ELEX_LOGFILE;


#gboost settings
if [ "`grep GBOOST=0 $ELEX_CONF`" ]; then
  echo 0 > /sys/devices/system/cpu/cpufreq/elementalx/gboost;
  echo gboost disabled >> $ELEX_LOGFILE;
fi

#update saved config
cp /system/etc/elementalx.conf /sdcard/.elementalx.backup

exit 0
