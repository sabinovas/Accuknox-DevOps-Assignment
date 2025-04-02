#!/bin/bash

# Set threshold values
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80
LOG_FILE="/var/log/system_health.log"

# Function to check CPU usage
check_cpu() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    CPU_INT=${CPU_USAGE%.*}  # Convert float to integer
    if [ "$CPU_INT" -ge "$CPU_THRESHOLD" ]; then
        echo "$(date) - High CPU usage detected: ${CPU_USAGE}%" | tee -a $LOG_FILE
    fi
}

# Function to check memory usage
check_memory() {
    MEMORY_USAGE=$(free | awk '/Mem/{printf("%.0f"), $3/$2*100}')
    if [ "$MEMORY_USAGE" -ge "$MEMORY_THRESHOLD" ]; then
        echo "$(date) - High Memory usage detected: ${MEMORY_USAGE}%" | tee -a $LOG_FILE
    fi
}

# Function to check disk usage
check_disk() {
    DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
    if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
        echo "$(date) - Low Disk Space! Used: ${DISK_USAGE}%" | tee -a $LOG_FILE
    fi
}

# Function to check running processes
check_processes() {
    echo "$(date) - Running processes count: $(ps aux --no-heading | wc -l)" | tee -a $LOG_FILE
}

# Run the checks
check_cpu
check_memory
check_disk
check_processes


