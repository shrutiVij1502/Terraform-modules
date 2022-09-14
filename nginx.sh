#!/bin/bash

yum update
yum -y install nginx
service nginx start
sudo echo test >/var/www/html/index.html
sudo service nginx restart
