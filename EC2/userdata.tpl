#!/bin/bash
yum -y install httpd
echo "This is coming from Terraform" >> /vra/www/html/index.html
service httpd start
chkconfig httpd on