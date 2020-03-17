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

mysql> create database logs_db;

mysql> use logs_db;

mysql> create table logs (logName VARCHAR(100) NOT NULL, lastModify VARCHAR(30) NOT NULL);


