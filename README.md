# k8s containerized logging

Shany Abady 17/03/2020

Description

Create random logs and write them to database.
Display logs index using web server.

Note: Proper changes should be made according to the environment being used. The following was tested on an on-premise k8s cluster.

Use Dockerfile to create image.
The gen-logs.sh is responsible for generating the logs and insterting rows to the database.

Persistent volume folders should be created:
/mnt/sql
/mnt/logs

Mysql requires initialization (create logs database and table) as described below - This can be done using a MapConfig.

Any changes made to environment variables should be updated in yaml files.

Initiating mysql

[root@k120 ]# kubectl exec -it k8s-mysql -- /bin/bash

root@k8s-mysql:/# echo $MYSQL_ROOT_PASSWORD

test

root@k8s-mysql:/# mysql --user=root --password=$MYSQL_ROOT_PASSWORD
. . .

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.01 sec)

mysql> create database challenge;
Query OK, 1 row affected (0.00 sec)

mysql> use challenge;
Database changed
mysql> create table logs (
    -> logName varchar(255),
    -> lastModify varchar(255)
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> show tables;
+---------------------+
| Tables_in_challenge |
+---------------------+
| logs                |
+---------------------+
1 row in set (0.00 sec)

mysql> select * from logs;
+-------------------------------+-------------------------------+
| logName                       | lastModify                    |
+-------------------------------+-------------------------------+
| /mnt/logs/dummies-2rmmr.log.1 | 2020-03-11 07:58:32.188940769 |
+-------------------------------+-------------------------------+
1 row in set (0.00 sec)
