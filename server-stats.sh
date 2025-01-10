#!/bin/bash

# Function to display CPU usage
cpu_usage() {
    echo "Total CPU Usage:"
    mpstat | awk '$12 ~ /[0-9.]+/ { print 100 - $12"%"}'
}

# Function to display memory usage
memory_usage() {
    echo "Memory Usage (Used vs Free):"
    free -h | awk '/^Mem:/ {printf "Used: %s, Free: %s (%.2f%% used)\n", $3, $4, $3/($3+$4)*100}'
}

# Function to display disk usage
disk_usage() {
    echo "Disk Usage:"
    df -h --total | awk '/^total/ {printf "Used: %s, Free: %s (%s used)\n", $3, $4, $5}'
}

# Function to display top 5 processes by CPU usage
top_processes_by_cpu() {
    echo "Top 5 Processes by CPU Usage:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}

# Function to display top 5 processes by memory usage
top_processes_by_memory() {
    echo "Top 5 Processes by Memory Usage:"
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
}

# Function to display optional stats
optional_stats() {
    echo "Optional Stats:"
    echo "OS Version: $(lsb_release -d | cut -f2)"
    echo "System Uptime: $(uptime -p)"
    echo "Load Average: $(uptime | awk -F 'load average:' '{print $2}')"
    echo "Logged In Users: $(who | wc -l)"
}

# Display all stats
echo "Server Performance Stats:"
echo "-------------------------"
cpu_usage
echo
memory_usage
echo
disk_usage
echo
top_processes_by_cpu
echo
top_processes_by_memory
echo
optional_stats
