#!/bin/bash

URL="http://localhost:4499"  # Change this to your application URL
LOG_FILE="/var/log/app_health.log"

check_application() {
    STATUS_CODE=$(curl -o /dev/null -s -w "%{http_code}\n" "$URL")

    if [ "$STATUS_CODE" -eq 200 ]; then
        echo "$(date) - Application is UP (HTTP $STATUS_CODE)" | tee -a $LOG_FILE
    else
        echo "$(date) - Application is DOWN (HTTP $STATUS_CODE)" | tee -a $LOG_FILE
    fi
}

# Run the check
check_application

