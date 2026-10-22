1. Instalasi & Konfigurasi Server
sudo apt update && sudo apt upgrade -y
sudo apt install -y nginx mysql-server git curl wget htop net-tools \
  php8.3-fpm php8.3-mysql php8.3-mbstring php8.3-xml php8.3-curl \
  php8.3-gd php8.3-zip php8.3-bcmath php8.3-intl php8.3-opcache

cd ~ && curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

sudo systemctl enable --now nginx mysql php8.3-fpm
systemctl is-enabled nginx mysql php8.3-fpm   # harus semua "enabled"

systemctl status nginx --no-pager
systemctl status php8.3-fpm --no-pager
systemctl status mysql --no-pager
php -v ; mysql --version ; nginx -v ; composer --version ; git --version


