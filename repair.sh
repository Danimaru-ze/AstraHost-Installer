if (( $EUID != 0 )); then
    echo "Silahkan masuk ke direktori root"
    exit
fi
repairPanel(){
    echo -e "\e[33m[*] Mendeteksi versi PHP...\e[0m"
    PHP_VER=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")
    echo -e "\e[32m[+] PHP $PHP_VER terdeteksi.\e[0m"
    
    echo -e "\e[33m[*] Menginstall extension PHP yang diperlukan ($PHP_VER)...\e[0m"
    sudo apt-get update -y < /dev/null
    sudo apt-get install -y php$PHP_VER-bcmath php$PHP_VER-xml php$PHP_VER-mbstring php$PHP_VER-gd php$PHP_VER-curl php$PHP_VER-zip < /dev/null

    # === Dependency Check & Version Sync (Node 18 Protection) ===
    echo -e "\e[33m[*] Menyeimbangkan dependensi sistem (Nuclear Node Fix)...\e[0m"
    sudo rm -f /etc/apt/sources.list.d/nodesource* < /dev/null
    sudo apt-get clean < /dev/null
    sudo apt-get update < /dev/null
    sudo apt-get purge -y nodejs < /dev/null
    curl -sL https://deb.nodesource.com/setup_22.x < /dev/null | sudo -E bash - < /dev/null
    sudo apt install -y nodejs < /dev/null
    # Ensure npm is present
    sudo apt install -y npm < /dev/null || true

    cd /var/www/pterodactyl

    php artisan down
    sudo rm -rf /var/www/pterodactyl/resources

    echo -e "\e[33m[*] Mendownload Pterodactyl Core (Stable Download)...\e[0m"
    sudo wget -qO /root/panel.tar.gz https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz < /dev/null

    echo -e "\e[33m[*] Mengekstrak file (Smart Restoration)...\e[0m"
    sudo tar -xzvf /root/panel.tar.gz -C /var/www/pterodactyl < /dev/null

    chmod -R 755 storage/* bootstrap/cache

    composer install --no-dev --optimize-autoloader

    php artisan view:clear

    php artisan config:clear

    php artisan migrate --seed --force

    chown -R www-data:www-data /var/www/pterodactyl/*

    php artisan queue:restart

    php artisan up
}
if [[ "$1" == "-y" || "$REPAIR_AUTO" == "true" ]]; then
    repairPanel
else
    while true; do
        read -p "apakah kamu yakin untuk mengUninstall theme ? [y/n] " yn
        case $yn in
            [Yy]* ) repairPanel; break;;
            [Nn]* ) exit;;
            * ) echo "silahkan pilih (y/yes) (n/no).";;
        esac
    done
fi
exit
