#!/bin/sh
MD5FILE=/root/.md5cron
FILE_TO_CHECK=/etc/crontab

MD5PRINT=`md5sum $FILE_TO_CHECK | cut -d " " -f1`
if [ -f $MD5FILE ]
then
	OLDMD5PRINT=`cat $MD5FILE`
	if [ "$OLDMD5PRINT" != "$MD5PRINT" ]
	then
		echo "The cron file has been changed" | mail -s "the file has been changed" root
	fi
	echo $MD5PRINT > $MD5FILE
fi