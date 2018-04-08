#!/bin/bash
backup_dir=/opt/backup_database/
DATE=`date +"%Y%m%d"`
DATABASE='kcvn
kcvn_d
xx
sentosa
sugarcrm
xxx
tcexam
udr_homepage'
MYSQLUSER=root
MYSQLPWD='xxx'
exec >> /opt/backup_database/logs/backup.$DATE.log
exec 2>&1
mkdir -p $backup_dir/

for schema in $DATABASE
do
        echo -e "\e[1;36m BACKUP DATABASE $schema \e[0m"
	mkdir -p $backup_dir/$schema
        /bin/mysqldump -u$MYSQLUSER -p$MYSQLPWD --databases  $schema --triggers --routines --events --flush-logs > $backup_dir/$schema/$schema-$DATE.sql

        echo -e "\e[1;36m Compressing ... \e[0m"
	cd $backup_dir/$schema/
	tar -zcvf $schema-$DATE.sql.tar.gz $schema-$DATE.sql
        rm -f $backup_dir/$schema/$schema-$DATE.sql

        echo -e "\e[1;36m BACKUP $schema-$DATE DONE!!!!! \e[0m"
        echo -e "\e[1;36m `ls -ahl $backup_dir/$schema/$schema-$DATE.sql.tar.gz `\e[0m"
	echo -e "\e[1;36m `du -sh $backup_dir/$schema/$schema-$DATE.sql.tar.gz `\e[0m"

        echo "---------------------------------------------"-
done
