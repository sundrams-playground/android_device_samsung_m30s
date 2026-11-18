#!/system/bin/sh
# DEBUG ONLY (eng builds): snapshot boot logs to /cache/bootlog/<boot_id>/
# so a boot that hangs without adb can be inspected from recovery.
T=/dev/m30s-bootlog
SELF_MNT=/dev/m30s-bootlog-cache
BOOT_ID=$(cut -c1-8 /proc/sys/kernel/random/boot_id)
mkdir -p $T
dest=""
n=0
while true; do
    up=$(cut -d" " -f1 /proc/uptime)
    dmesg > $T/dmesg.txt 2>&1
    timeout 10 logcat -b all -d > $T/logcat.txt 2>&1
    getprop > $T/props.txt 2>&1
    ps -A -o PID,PPID,USER,STAT,WCHAN,LABEL,CMD > $T/ps.txt 2>&1
    cat /proc/mounts > $T/mounts.txt 2>&1
    echo "uptime=$up iter=$n" > $T/status.txt
    if [ -z "$dest" ]; then
        if grep -q " /cache " /proc/mounts; then
            dest=/cache/bootlog/$BOOT_ID
        elif [ ${up%%.*} -ge 30 ]; then
            mkdir -p $SELF_MNT
            mount -t ext4 -o noatime,nosuid,nodev /dev/block/by-name/cache $SELF_MNT && dest=$SELF_MNT/bootlog/$BOOT_ID
        fi
        if [ -n "$dest" ]; then
            mkdir -p $dest
            echo "$BOOT_ID $(date)" >> ${dest%/*}/boots.txt
        fi
    fi
    if [ -n "$dest" ]; then
        cp $T/*.txt $dest/ && sync
    fi
    n=$((n+1))
    if [ ${up%%.*} -lt 300 ]; then sleep 3; else sleep 30; fi
done
