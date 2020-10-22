#! /bin/bash
sudo yum update
sudo yum install -y httpd
sudo chkconfig httpd on
sudo service httpd start
sudo su -
sudo echo "<h1> Hello Plexure! </h1>" > /var/www/html/index.html
