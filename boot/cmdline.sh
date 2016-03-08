#!/sbin/sh

if [ -f /sdcard/.elementalx.backup ]; then
  ELEX_CONF="/sdcard/.elementalx.backup"

  CPU0=`grep "CPU0" $ELEX_CONF | cut -d '=' -f2`
  CPU1=`grep "CPU1" $ELEX_CONF | cut -d '=' -f2`
  CPU2=`grep "CPU2" $ELEX_CONF | cut -d '=' -f2`
  CPU3=`grep "CPU3" $ELEX_CONF | cut -d '=' -f2`
  UV=`grep "UV" $ELEX_CONF | cut -d '=' -f2`
  OPT=`grep "OPT" $ELEX_CONF | cut -d '=' -f2`

  case $CPU0 in
	1)
	  max_oc0="max_oc0=1497600"
	  ;;
	2)
	  max_oc0="max_oc0=1728000"
	  ;;
	3)
	  max_oc0="max_oc0=1958400"
	  ;;
	4)
	  max_oc0="max_oc0=2265600"
	  ;;
  	5)
	  max_oc0="max_oc0=2342400"
	  ;;
  	6)
	  max_oc0="max_oc0=2419200"
	  ;;
	7)
	  max_oc0="max_oc0=2496000"
	  ;;
	8)
	  max_oc0="max_oc0=2572800"
	  ;;
	9)
	  max_oc0="max_oc0=2649600"
	  ;;
	10)
	  max_oc0="max_oc0=2726400"
	  ;;
	11)
	  max_oc0="max_oc0=2803200"
	  ;;
	12)
	  max_oc0="max_oc0=2880000"
	  ;;
	13)
	  max_oc0="max_oc0=2956800"
	  ;;
  esac

  case $CPU1 in
	1)
	  max_oc1="max_oc1=1497600"
	  ;;
	2)
	  max_oc1="max_oc1=1728000"
	  ;;
	3)
	  max_oc1="max_oc1=1958400"
	  ;;
	4)
	  max_oc1="max_oc1=2265600"
	  ;;
  	5)
	  max_oc1="max_oc1=2342400"
	  ;;
  	6)
	  max_oc1="max_oc1=2419200"
	  ;;
	7)
	  max_oc1="max_oc1=2496000"
	  ;;
	8)
	  max_oc1="max_oc1=2572800"
	  ;;
	9)
	  max_oc1="max_oc1=2649600"
	  ;;
	10)
	  max_oc1="max_oc1=2726400"
	  ;;
	11)
	  max_oc1="max_oc1=2803200"
	  ;;
	12)
	  max_oc1="max_oc1=2880000"
	  ;;
	13)
	  max_oc1="max_oc1=2956800"
	  ;;
  esac

  case $CPU2 in
	1)
	  max_oc2="max_oc2=1497600"
	  ;;
	2)
	  max_oc2="max_oc2=1728000"
	  ;;
	3)
	  max_oc2="max_oc2=1958400"
	  ;;
	4)
	  max_oc2="max_oc2=2265600"
	  ;;
  	5)
	  max_oc2="max_oc2=2342400"
	  ;;
  	6)
	  max_oc2="max_oc2=2419200"
	  ;;
	7)
	  max_oc2="max_oc2=2496000"
	  ;;
	8)
	  max_oc2="max_oc2=2572800"
	  ;;
	9)
	  max_oc2="max_oc2=2649600"
	  ;;
	10)
	  max_oc2="max_oc2=2726400"
	  ;;
	11)
	  max_oc2="max_oc2=2803200"
	  ;;
	12)
	  max_oc2="max_oc2=2880000"
	  ;;
	13)
	  max_oc2="max_oc2=2956800"
	  ;;
  esac

  case $CPU3 in
	1)
	  max_oc3="max_oc3=1497600"
	  ;;
	2)
	  max_oc3="max_oc3=1728000"
	  ;;
	3)
	  max_oc3="max_oc3=1958400"
	  ;;
	4)
	  max_oc3="max_oc3=2265600"
	  ;;
  	5)
	  max_oc3="max_oc3=2342400"
	  ;;
  	6)
	  max_oc3="max_oc3=2419200"
	  ;;
	7)
	  max_oc3="max_oc3=2496000"
	  ;;
	8)
	  max_oc3="max_oc3=2572800"
	  ;;
	9)
	  max_oc3="max_oc3=2649600"
	  ;;
	10)
	  max_oc3="max_oc3=2726400"
	  ;;
	11)
	  max_oc3="max_oc3=2803200"
	  ;;
	12)
	  max_oc3="max_oc3=2880000"
	  ;;
	13)
	  max_oc3="max_oc3=2956800"
	  ;;
  esac

  case $OPT in
	1)
	  l2_opt="l2_opt=0"
	  ;;
	2)
	  l2_opt="l2_opt=1"
	  ;;
  esac

  case $UV in
	1)
	  vdd_uv="vdd_uv=0"
	  ;;
	2)
	  vdd_uv="vdd_uv=1"
	  ;;
	3)
	  vdd_uv="vdd_uv=2"
	  ;;
	4)
	  vdd_uv="vdd_uv=3"
	  ;;
	5)
	  vdd_uv="vdd_uv=4"
	  ;;
	6)
	  vdd_uv="vdd_uv=5"
	  ;;
	7)
	  vdd_uv="vdd_uv=6"
	  ;;
  esac

  echo "cmdline = console=ttyHSL0,115200,n8 androidboot.hardware=hammerhead user_debug=31 maxcpus=2 msm_watchdog_v2.enable=1" $l2_opt $vdd_uv $max_oc0 $max_oc1 $max_oc2 $max_oc3 > /tmp/cmdline.cfg

else

  echo "cmdline = console=ttyHSL0,115200,n8 androidboot.hardware=hammerhead user_debug=31 maxcpus=2 msm_watchdog_v2.enable=1 l2_opt=1 vdd_uv=0" > /tmp/cmdline.cfg

fi
