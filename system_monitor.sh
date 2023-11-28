#!/bin/zsh
CPU_THRESHOLD=80
MEMORY_THRESHOLD=70
DISK_THRESHOLD=90

cpu_usage=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')
memory_usage=$(top -l 1 | grep "PhysMem" | awk '{print $2}' | sed 's/M//')
disk_usage=$(df -H | grep '/dev/disk1s1' | awk '{print $5}' | sed 's/%//')

if [ "$cpu_usage" -gt "$CPU_THRESHOLD" ]; then
    echo "Warning: CPU usage is high at ${cpu_usage}%"
fi
if [ "$memory_usage" -gt "$MEMORY_THRESHOLD" ]; then
    echo "Warning: Memory usage is high at ${memory_usage}%"
fi
if [ "$disk_usage" -gt "$DISK_THRESHOLD" ]; then
    echo "Warning: Disk usage is high at ${disk_usage}%"
fi
