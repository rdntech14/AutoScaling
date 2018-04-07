#!/bin/bash
yum install -y httpd
cd /var/www/html
echo "this is my EC2" > index.html
service httpd start
