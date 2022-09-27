#!/bin/sh
sudo apt update && sudo apt-upgrade
##INSTALL PHP
#php7.4-xml provides php-dom php-simplexml php-xmlreader php-xmlwriter
sudo apt install libxml2 php7.4 libapache2-mod-php7.4 php7.4-common php-ctype php-curl php7.4-xml php7.4-gd php7.4-json php7.4-mbstring php-posix php-zip php-mysql php7.4-bz2 php7.4-intl
