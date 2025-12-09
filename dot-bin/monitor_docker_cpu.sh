#!/usr/bin/env bash
set -euo pipefail # Exit on error, undefined vars, pipe fails

# Script description
# Usage: monitor_docker_cpu.sh <container_name> [cpu_threshold]
# Author: Louis Hsu
# Date: 2025/0720

LOG_FILE="/tmp/monitor_docker_cpu.log"
LOG_BACKUP="${LOG_FILE}.old"
LOG_MAXSIZE=10240

# Function: Rotate log file if too big
rotate_log() {
	if [ -f "$LOG_FILE" ]; then
		LOG_SIZE=$(stat --format=%s "$LOG_FILE")
		if [ "$LOG_SIZE" -ge "$LOG_MAXSIZE" ]; then
			mv -f "$LOG_FILE" "$LOG_BACKUP"
		fi
	fi
}

# Call log rotation at the very beginning
rotate_log

# Check parameters
if [ $# -lt 1 ]; then
	echo "Usage: $0 <container_name> [cpu_threshold]"
	exit 1
fi

CONTAINER_NAME="$1"
THRESHOLD="${2:-60}" # default 60 if no 2nd parameter

# Retrieve container id
CONTAINER_ID=$(docker ps --filter "name=${CONTAINER_NAME}" --format "{{.ID}}")

if [ -z "$CONTAINER_ID" ]; then
	echo "=== $(date '+%Y-%m-%d %H:%M:%S') - Start container \"${CONTAINER_NAME}\" monitoring ===" >>"$LOG_FILE"
	echo "Container ${CONTAINER_NAME} is not running." >>"$LOG_FILE"
	echo "=== $(date '+%Y-%m-%d %H:%M:%S') - Finished ===" >>"$LOG_FILE"
	exit 0
fi

# Get CPU usage
CPU_USAGE=$(docker stats --no-stream --format "{{.CPUPerc}}" $CONTAINER_ID | tr -d '%')

# Round CPU usage as an integer
CPU_INT=${CPU_USAGE%.*}

if [ "$CPU_INT" -ge "$THRESHOLD" ]; then
	echo "=== $(date '+%Y-%m-%d %H:%M:%S') - Start container \"${CONTAINER_NAME}\" monitoring ===" >>"$LOG_FILE"
	echo "Restarting container \"${CONTAINER_NAME}\" (CPU: ${CPU_USAGE}%)" >>"$LOG_FILE"
	docker restart $CONTAINER_ID
	echo "=== $(date '+%Y-%m-%d %H:%M:%S') - Finished ===" >>"$LOG_FILE"
fi
