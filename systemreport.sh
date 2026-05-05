#!/bin/bash

LOGFILE=~/scripts/systemreport.log
DATE=$(date '+%Y-%m-%d %H:%M:%S')
log() {
	echo "$1" | tee -a $LOGFILE
}

log "===== System Report =====" 
log "Report Generated: $DATE" 
log "Hostname: $(hostname)"
log "Logged in as: $(whoami)"
log "Disk Usage: $(df -h | awk 'NR==2 {print $5}') used" 
log "Memory Free: $(free -m | awk 'NR==2 {print $4}')MB free"

log "--- Services ---" 

for service in sshd firewalld chronyd
do
	if systemctl is-active --quiet $service
	then
		log "$service: running" 
	else 
		log "$service: NOT running" 
	fi
done


log "===== System Report Completed =====" 

