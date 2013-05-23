#!/bin/bash
#in case file doesn't exist 
if test -r ~/.spoolcron/cron.daily; then
    day=`cat ~/.spoolcron/cron.daily`
fi
if [ `date +%Y%m%d` = "$day" ]; then
    exit 0;
fi

/usr/bin/anacron -t ~/.anacrontab -S ~/.spoolcron/         

