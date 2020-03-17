#!/bin/bash

LOG_FILE_INDEX=1
LOG_FILE=/mnt/logs/`hostname`.log.$LOG_FILE_INDEX
LOG_LINE_LIMIT=10
LOG_LINE_COUNT=0

# generate log files
while ($true); do 
	sleep $[$RANDOM % 3]s
	date >> $LOG_FILE
	LOG_LINE_COUNT=$((LOG_LINE_COUNT+1))
	[ $LOG_LINE_COUNT -eq $LOG_LINE_LIMIT ] && {
		# write to DB
		time_stamp=`stat $LOG_FILE | grep Change | awk '{print $2,$3}'`
                mysql --user=$USER --password=$DB_PASSWD -h $DB_HOST $DB_NAME -e "INSERT INTO $TABLE (\`logName\`, \`lastModify\`) VALUES ('$LOG_FILE', '$time_stamp')"
		# New log file
		LOG_FILE_INDEX=$((LOG_FILE_INDEX+1))
		LOG_FILE=/mnt/logs/`hostname`.log.$LOG_FILE_INDEX
		LOG_LINE_COUNT=0
	}
done

