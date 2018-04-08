#!/bin/bash
backup_dir=/opt/backup_source/
DATE=`date +"%Y%m%d"`
SOURCE='angelshub
html
kcvn
xx
sentosadental
sugarcrm
xx
tcexam
udr_homepage'
exec >> /opt/backup_source/logs/backup.$DATE.log
exec 2>&1
mkdir -p $backup_dir

for site in $SOURCE
do
        echo -e "\e[1;36m BACKUP SOURCE $site \e[0m"
	mkdir -p $backup_dir/$site
	echo -e "\e[1;36m Compressing ... \e[0m"
	cd $backup_dir/$site/
	tar -zcf $site-$DATE.tar.gz /var/www/$site

    echo -e "\e[1;36m BACKUP $site-$DATE DONE!!!!! \e[0m"
    echo -e "\e[1;36m `ls -ahl $backup_dir/$site/$site-$DATE.tar.gz `\e[0m"
    echo -e "\e[1;36m `du -sh $backup_dir/$site/$site-$DATE.tar.gz `\e[0m"
    echo "---------------------------------------------"-
done
