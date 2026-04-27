#!/bin/bash
# Version: 2.3 (Force Cache Refresh)

# Color
BLUE='\033[0;34m'       
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Display welcome message
display_welcome() {
  echo -e ""
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                                                 [+]${NC}"
  echo -e "${WHITE}[+]                ASTRAHOST AUTO INSTALLER         [+]${NC}"
  echo -e "${WHITE}[+]                  © Danimaru                 [+]${NC}"
  echo -e "${BLUE}[+]                                                 [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e ""
  echo -e "script ini di buat untuk mempermudah penginstalasian thema pterodactyle,"
  echo -e "dilarang keras untuk dikasih gratis."
  echo -e ""
  echo -e "𝗧𝗘𝗟𝗘𝗚𝗥𝗔𝗠 :"
  echo -e "@danimaruse"
  echo -e "𝗖𝗥𝗘𝗗𝗜𝗧𝗦 :"
  echo -e "@danimaruse"
  sleep 4
  clear
}

#Update and install jq
install_jq() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]             UPDATE & INSTALL JQ                 [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sudo apt update < /dev/null && sudo apt install -y jq < /dev/null
  if [ $? -eq 0 ]; then
    echo -e "                                                       "
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
    echo -e "${GREEN}[+]              INSTALL JQ BERHASIL                [+]${NC}"
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
  else
    echo -e "                                                       "
    echo -e "${RED}[+] =============================================== [+]${NC}"
    echo -e "${RED}[+]              INSTALL JQ GAGAL                   [+]${NC}"
    echo -e "${RED}[+] =============================================== [+]${NC}"
    exit 1
  fi
  echo -e "                                                       "
  sleep 1
  clear
}
#Check user token
check_token() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]               LICENSI ASTRAHOST                [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  echo -e "${YELLOW}MASUKAN AKSES TOKEN :${NC}"
  read -r USER_TOKEN

  if [ "$USER_TOKEN" = "astra_vip" ]; then
    echo -e "${GREEN}AKSES BERHASIL${NC}}"
  else
    echo -e "${GREEN}Silahkan beli lisensi ke @danimaruse${NC}"
    echo -e "${YELLOW}TELEGRAM : @danimaruse${NC}"
    echo -e "${YELLOW}© AstraHost Team${NC}"
    exit 1
  fi
  clear
}

# Restore base Pterodactyl files (HANYA untuk Arix - Non-Fatal)
restore_base() {
  echo -e "${YELLOW}[*] Menjalankan sistem pemulihan core Pterodactyl...${NC}"
  
  # Cek sisa disk (Minimum 300MB - lebih santai)
  FREE_DISK=$(df -m / | awk 'NR==2 {print $4}')
  if [ "$FREE_DISK" -lt 300 ]; then
    echo -e "${YELLOW}[!] Peringatan: Disk sisa ${FREE_DISK}MB, lewati pemulihan core.${NC}"
    return 0
  fi

  cd /var/www/pterodactyl < /dev/null
  
  # Download dan ekstrak
  mkdir -p /root/ptero_core < /dev/null
  echo -e "${YELLOW}[*] Mengunduh core Pterodactyl v1.11.10...${NC}"
  rm -f /root/panel.tar.gz < /dev/null
  
  if wget -qO /root/panel.tar.gz "https://github.com/pterodactyl/panel/releases/download/v1.11.10/panel.tar.gz" < /dev/null; then
    if tar -xzf /root/panel.tar.gz -C /root/ptero_core < /dev/null 2>/dev/null; then
      sudo cp -rfT /root/ptero_core/resources /var/www/pterodactyl/resources < /dev/null
      sudo cp -rfT /root/ptero_core/app /var/www/pterodactyl/app < /dev/null
      sudo rm -rf /root/ptero_core /root/panel.tar.gz < /dev/null
      echo -e "${GREEN}[+] Core berhasil dipulihkan.${NC}"
    else
      echo -e "${YELLOW}[!] Ekstraksi gagal, lanjutkan tanpa pemulihan core.${NC}"
      rm -f /root/panel.tar.gz < /dev/null
    fi
  else
    echo -e "${YELLOW}[!] Download gagal, lanjutkan tanpa pemulihan core.${NC}"
  fi
}

# Install theme
install_theme() {
  while true; do
    echo -e "                                                       "
    echo -e "${BLUE}[+] =============================================== [+]${NC}"
    echo -e "${WHITE}[+]                   SELECT THEME                  [+]${NC}"
    echo -e "${BLUE}[+] =============================================== [+]${NC}"
    echo -e "                                                       "
    echo -e "PILIH THEME YANG INGIN DI INSTALL"
    echo "1. stellar"
    echo "2. noobee"
    echo "3. enigma"
    echo "4. arix"
    echo "x. kembali"
    echo -e "masukan pilihan (1/2/3/4/x) :"
    read -r SELECT_THEME
    case "$SELECT_THEME" in
      1)
        THEME_URL=$(echo -e "https://raw.githubusercontent.com/Danimaru-ze/AstraHost-Installer/main/StellarTheme.zip")
        THEME_FOLDER="pterodactyl"
        break
        ;;
      2)
        THEME_URL=$(echo -e "https://raw.githubusercontent.com/Danimaru-ze/AstraHost-Installer/main/C1.zip")
        THEME_FOLDER="pterodactyl"
        break
        ;;
      3)
        THEME_URL=$(echo -e "https://raw.githubusercontent.com/Danimaru-ze/AstraHost-Installer/main/C3.zip")
        THEME_FOLDER="pterodactyl"
        break
        ;; 
      4)
        # Using Arix v1.2 from GitHub or local if possible
        THEME_URL=$(echo -e "https://raw.githubusercontent.com/Danimaru-ze/AstraHost-Installer/main/arix-v1.2.zip")
        THEME_FOLDER="arix-v1.2/pterodactyl/arix/v1.2"
        break
        ;;
      x)
        return
        ;;
      *)
        echo -e "${RED}Pilihan tidak valid, silahkan coba lagi.${NC}"
        ;;
    esac
  done
  
  if [ -e /root/$THEME_FOLDER ]; then
    sudo rm -rf /root/$THEME_FOLDER
  fi
  wget -qO theme.zip "$THEME_URL" < /dev/null
  sudo unzip -o theme.zip -d /root < /dev/null
  rm theme.zip < /dev/null
  
  # Tema non-Arix: langsung install tanpa restore_base

if [ "$SELECT_THEME" -eq 1 ]; then
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                  INSTALLASI THEMA               [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                                   "
  echo -e "${YELLOW}[*] Menyiapkan lingkungan instalasi tema (Smart Merge)...${NC}"
  # === Dependency Check & Version Sync ===
  echo -e "${YELLOW}[*] Menyeimbangkan dependensi sistem...\e[0m"
  PHP_VER=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")
  sudo apt-get install -y php$PHP_VER-bcmath php$PHP_VER-xml php$PHP_VER-mbstring php$PHP_VER-gd php$PHP_VER-curl php$PHP_VER-zip < /dev/null
  
  # Clean Node Swap (Nuclear Purge)
  echo -e "${YELLOW}[*] Menghapus Node lama (Nuclear Purge) untuk menghindari konflik...\e[0m"
  sudo rm -f /etc/apt/sources.list.d/nodesource* < /dev/null
  sudo apt-get clean < /dev/null
  sudo apt-get update < /dev/null
  sudo apt-get purge -y nodejs < /dev/null
  curl -sL https://deb.nodesource.com/setup_22.x < /dev/null | sudo -E bash - < /dev/null
  sudo apt install -y nodejs < /dev/null; sudo apt install -y npm < /dev/null || true < /dev/null
  sudo npm i -g yarn < /dev/null
  
  # Smart Merge (No rm -rf)
  echo -e "${YELLOW}[*] Menimpa tema (Smart Merge)...${NC}"
  sudo cp -rfT /root/pterodactyl /var/www/pterodactyl < /dev/null
  
  cd /var/www/pterodactyl
  
  # Deep Clean Workspace
  echo -e "${YELLOW}[*] Membersihkan cache build lama (Nuclear Option)...\e[0m"
  rm -rf node_modules yarn.lock < /dev/null
  
  yarn install --ignore-engines < /dev/null
  yarn add react-feather md5 path-browserify --ignore-engines < /dev/null
  php artisan migrate < /dev/null
  export NODE_OPTIONS="--openssl-legacy-provider --max-old-space-size=4096"
  yarn build:production < /dev/null || { echo -e "${RED}ERROR: Build failed!${NC}"; exit 1; }
  php artisan view:clear < /dev/null
  sudo rm -rf /root/pterodactyl < /dev/null

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                   INSTALL SUCCESS               [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e ""
  sleep 2
  if [ "$REPAIR_AUTO" = "true" ]; then
    exit 0
  fi
  clear
  return

elif [ "$SELECT_THEME" -eq 2 ]; then
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                  INSTALLASI THEMA               [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  echo -e "${YELLOW}[*] Menyiapkan lingkungan instalasi tema...${NC}"
  
  # Dependency check
  PHP_VER=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")
  sudo apt-get install -y php$PHP_VER-bcmath php$PHP_VER-xml php$PHP_VER-mbstring php$PHP_VER-gd php$PHP_VER-curl php$PHP_VER-zip < /dev/null
  
  # Cek versi Node.js saat ini
  CURRENT_NODE=$(node -v 2>/dev/null | sed 's/v//' | cut -d'.' -f1)
  echo -e "${YELLOW}[*] Versi Node.js saat ini: $(node -v 2>/dev/null || echo 'tidak terinstall')${NC}"

  if [ "$CURRENT_NODE" -lt 22 ] 2>/dev/null || [ -z "$CURRENT_NODE" ]; then
    # Node bukan v22+, lakukan upgrade
    echo -e "${YELLOW}[*] Mengupgrade Node.js ke versi 22 (diperlukan untuk build)...${NC}"
    sudo rm -f /etc/apt/sources.list.d/nodesource* < /dev/null
    sudo apt-get clean < /dev/null
    sudo apt-get update < /dev/null
    sudo apt-get purge -y nodejs < /dev/null
    curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
    sudo apt-get install -y nodejs < /dev/null
    sudo npm i -g yarn < /dev/null

    # Verifikasi upgrade berhasil
    NEW_NODE=$(node -v 2>/dev/null | sed 's/v//' | cut -d'.' -f1)
    echo -e "${YELLOW}[*] Versi Node.js setelah upgrade: $(node -v 2>/dev/null)${NC}"
    if [ "$NEW_NODE" -lt 22 ] 2>/dev/null; then
      echo -e "${RED}[!] PERINGATAN: Upgrade Node.js gagal, menggunakan --ignore-engines sebagai fallback...${NC}"
    else
      echo -e "${GREEN}[+] Node.js v22 berhasil terinstall!${NC}"
    fi
  else
    echo -e "${GREEN}[+] Node.js sudah versi 22+, skip upgrade.${NC}"
  fi
  
  # Smart Merge
  echo -e "${YELLOW}[*] Menimpa tema (Smart Merge)...${NC}"
  sudo cp -rfT /root/pterodactyl /var/www/pterodactyl < /dev/null
  
  # Buat Avatar.tsx yang hilang dari tema Noobee
  echo -e "${YELLOW}[*] Membuat file Avatar.tsx yang hilang...${NC}"
  cat > /var/www/pterodactyl/resources/scripts/components/Avatar.tsx << 'AVATAREOF'
import React from 'react';
import { useStoreState } from 'easy-peasy';
import { ApplicationStore } from '@/state';
import tw from 'twin.macro';
import styled from 'styled-components/macro';

const AvatarBox = styled.div`
    ${tw`flex items-center justify-center rounded-full bg-blue-600 text-white font-bold`}
    user-select: none;
    font-size: 0.7rem;
    width: 100%;
    height: 100%;
`;

const _UserAvatar = () => {
    const email = useStoreState((state: ApplicationStore) => state.user.data!.email);
    const letter = email ? email.charAt(0).toUpperCase() : '?';
    return <AvatarBox>{letter}</AvatarBox>;
};

const _Avatar = ({ size = 48 }: { size?: number }) => {
    const email = useStoreState((state: ApplicationStore) => state.user.data!.email);
    const letter = email ? email.charAt(0).toUpperCase() : '?';
    return (
        <AvatarBox style={{ width: size, height: size }}>
            {letter}
        </AvatarBox>
    );
};

_Avatar.displayName = 'Avatar';
_UserAvatar.displayName = 'Avatar.User';

const Avatar = Object.assign(_Avatar, { User: _UserAvatar });

export default Avatar;
AVATAREOF

  # Buat Icon.tsx yang dibutuhkan StatBlock.tsx tema Noobee
  echo -e "${YELLOW}[*] Membuat file Icon.tsx yang hilang...${NC}"
  cat > /var/www/pterodactyl/resources/scripts/components/elements/Icon.tsx << 'ICONEOF'
import React, { CSSProperties } from 'react';
import { IconDefinition } from '@fortawesome/fontawesome-svg-core';
import tw from 'twin.macro';

interface Props {
    icon: IconDefinition;
    className?: string;
    style?: CSSProperties;
}

const Icon = ({ icon, className, style }: Props) => {
    const [width, height, , , paths] = icon.icon;

    return (
        <svg
            xmlns={'http://www.w3.org/2000/svg'}
            viewBox={`0 0 ${width} ${height}`}
            css={tw`fill-current inline-block`}
            className={className}
            style={style}
        >
            {(Array.isArray(paths) ? paths : [paths]).map((path, index) => (
                <path key={`svg_path_${index}`} d={path} />
            ))}
        </svg>
    );
};

export default Icon;
ICONEOF

  cd /var/www/pterodactyl

  # Deep Clean Workspace
  rm -rf node_modules yarn.lock < /dev/null
  
  yarn install --ignore-engines < /dev/null
  yarn add react-feather md5 path-browserify @tailwindcss/line-clamp @tailwindcss/forms --ignore-engines < /dev/null
  php artisan migrate --force < /dev/null
  export NODE_OPTIONS="--openssl-legacy-provider --max-old-space-size=4096"
  yarn build:production < /dev/null || { echo -e "${RED}ERROR: Build failed!${NC}"; exit 1; }
  php artisan view:clear < /dev/null
  php artisan config:clear < /dev/null
  php artisan config:cache < /dev/null
  php artisan route:clear < /dev/null
  php artisan optimize < /dev/null
  php artisan queue:restart < /dev/null
  echo -e "${YELLOW}[*] Set permissions...${NC}"
  sudo chown -R www-data:www-data /var/www/pterodactyl < /dev/null
  sudo chmod -R 755 /var/www/pterodactyl/storage /var/www/pterodactyl/bootstrap/cache < /dev/null
  sudo rm -rf /root/pterodactyl < /dev/null

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                  INSTALL SUCCESS                [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  if [ "$REPAIR_AUTO" = "true" ]; then
    exit 0
  fi
  clear
  return

elif [ "$SELECT_THEME" -eq 3 ]; then
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                  INSTALLASI THEMA               [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                                   "

    # Menanyakan informasi kepada pengguna untuk tema Enigma
    echo -e "${YELLOW}Masukkan link wa (https://wa.me...) : ${NC}"
    read LINK_WA
    echo -e "${YELLOW}Masukkan link group (https://.....) : ${NC}"
    read LINK_GROUP
    echo -e "${YELLOW}Masukkan link channel (https://...) : ${NC}"
    read LINK_CHNL

    # Mengganti placeholder dengan nilai dari pengguna
    sudo sed -i "s|LINK_WA|$LINK_WA|g" /root/pterodactyl/resources/scripts/components/dashboard/DashboardContainer.tsx
    sudo sed -i "s|LINK_GROUP|$LINK_GROUP|g" /root/pterodactyl/resources/scripts/components/dashboard/DashboardContainer.tsx
    sudo sed -i "s|LINK_CHNL|$LINK_CHNL|g" /root/pterodactyl/resources/scripts/components/dashboard/DashboardContainer.tsx

  echo -e "${YELLOW}[*] Membersihkan tema lama sebelum install ulang...${NC}"
  
  # Dependency check
  PHP_VER=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")
  sudo apt-get install -y php$PHP_VER-bcmath php$PHP_VER-xml php$PHP_VER-mbstring php$PHP_VER-gd php$PHP_VER-curl php$PHP_VER-zip < /dev/null
  
  # Clean Node Swap (Nuclear Purge)
  echo -e "${YELLOW}[*] Menghapus Node lama (Nuclear Purge) untuk menghindari konflik...\e[0m"
  sudo rm -f /etc/apt/sources.list.d/nodesource* < /dev/null
  sudo apt-get clean < /dev/null
  sudo apt-get update < /dev/null
  sudo apt-get purge -y nodejs < /dev/null
  curl -sL https://deb.nodesource.com/setup_22.x < /dev/null | sudo -E bash - < /dev/null
  sudo apt install -y nodejs < /dev/null; sudo apt install -y npm < /dev/null || true < /dev/null
  sudo npm i -g yarn < /dev/null
  
  # Smart Merge
  echo -e "${YELLOW}[*] Menimpa tema (Smart Merge)...${NC}"
  sudo cp -rfT /root/pterodactyl /var/www/pterodactyl < /dev/null

  cd /var/www/pterodactyl
  
  # Deep Clean Workspace
  rm -rf node_modules yarn.lock < /dev/null
  
  yarn install --ignore-engines < /dev/null
  yarn add react-feather md5 path-browserify --ignore-engines < /dev/null
  php artisan migrate < /dev/null
  export NODE_OPTIONS="--openssl-legacy-provider --max-old-space-size=4096"
  yarn build:production < /dev/null || { echo -e "${RED}ERROR: Build failed!${NC}"; exit 1; }
  php artisan view:clear < /dev/null
  sudo rm -rf /root/pterodactyl < /dev/null

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                   INSTALL SUCCESS               [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e ""
  sleep 2
  if [ "$REPAIR_AUTO" = "true" ]; then
    exit 0
  fi
  clear
  return

elif [ "$SELECT_THEME" -eq 4 ]; then
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                  INSTALLASI THEMA               [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                                   "
  
  # Nuclear Node v18 Protection
  echo -e "${YELLOW}[*] Menghapus Node lama (Nuclear Purge) untuk menghindari konflik...\e[0m"
  sudo rm -f /etc/apt/sources.list.d/nodesource* < /dev/null
  sudo apt-get clean < /dev/null
  sudo apt-get update < /dev/null
  sudo apt-get purge -y nodejs < /dev/null
  curl -sL https://deb.nodesource.com/setup_22.x < /dev/null | sudo -E bash - < /dev/null
  sudo apt install -y nodejs < /dev/null; sudo apt install -y npm < /dev/null || true < /dev/null
  sudo npm i -g yarn < /dev/null

  cd /var/www/pterodactyl
  
  # Deep Clean Workspace
  rm -rf node_modules yarn.lock < /dev/null

  # Install Arix required dependencies (MUST BE BEFORE BUILD)
  echo -e "${YELLOW}[*] Menginstall NPM packages tambahan (Arix Dependencies)...${NC}"
  yarn install --ignore-engines < /dev/null
  yarn add react-icons bbcode-to-react i18next-browser-languagedetector path-browserify @tailwindcss/line-clamp @tailwindcss/forms md5 --ignore-engines < /dev/null

  echo -e "${YELLOW}[*] Menimpa file tema Arix v1.2 (Smart Merge)...${NC}"
  # Arix specific path - Corrected for the zip structure (unzips to /root/pterodactyl)
  sudo cp -rfT /root/pterodactyl /var/www/pterodactyl
  
  # === NUCLEAR HOTFIX ERROR 500 (SANCTUM) ===
  echo -e "${YELLOW}[*] Menjalankan Nuclear Hotfix Error 500 (Global Search & Destroy)...${NC}"
  # Cari di semua file di folder app/ dan hapus baris yang bermasalah (termasuk variasi spasi)
  sudo grep -rl "Sanctum::ignoreMigrations" /var/www/pterodactyl/app/ | xargs sudo sed -i 's/Sanctum::ignoreMigrations()[[:space:]]*;//g' || true

  # === NUCLEAR HOTFIX BUILD (WEBPACK PATH) ===
  echo -e "${YELLOW}[*] Menjalankan Nuclear Hotfix Build (Robust Webpack Polyfill)...${NC}"
  if [ -f "webpack.config.js" ]; then
    # Jika path-browserify belum ada di config
    if ! grep -q "path-browserify" webpack.config.js; then
      # Sisipkan fallback path di dalam block resolve
      sudo sed -i "/extensions: \[/i \        fallback: { path: require.resolve('path-browserify') }," webpack.config.js
    fi
  fi
  
  php artisan migrate --force < /dev/null
  export NODE_OPTIONS="--openssl-legacy-provider --max-old-space-size=4096"
  yarn build:production < /dev/null || { echo -e "${RED}ERROR: Build failed!${NC}"; exit 1; }
  php artisan view:clear < /dev/null
  sudo rm -rf /root/pterodactyl
  
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                   INSTALL SUCCESS               [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e ""
  sleep 2
  if [ "$REPAIR_AUTO" = "true" ]; then
    exit 0
  fi
  clear
  return
fi
}


# Uninstall theme
uninstall_theme() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                    DELETE THEME                 [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  export REPAIR_AUTO=true; cd /root && wget -qO repair.sh https://raw.githubusercontent.com/Danimaru-ze/AstraHost-Installer/main/repair.sh?v=$(date +%s) && bash repair.sh
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 DELETE THEME SUKSES             [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  clear
}
create_node() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                    CREATE NODE                     [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  #!/bin/bash
#!/bin/bash

# Minta input dari pengguna
read -p "Masukkan nama lokasi: " location_name
read -p "Masukkan deskripsi lokasi: " location_description
read -p "Masukkan domain: " domain
read -p "Masukkan nama node: " node_name
read -p "Masukkan RAM (dalam MB): " ram
read -p "Masukkan jumlah maksimum disk space (dalam MB): " disk_space
read -p "Masukkan Locid: " locid

# Ubah ke direktori pterodactyl
cd /var/www/pterodactyl || { echo "Direktori tidak ditemukan"; exit 1; }

# Membuat lokasi baru
php artisan p:location:make <<EOF
$location_name
$location_description
EOF

# Membuat node baru
php artisan p:node:make <<EOF
$node_name
$location_description
$locid
https
$domain
yes
no
no
$ram
$ram
$disk_space
$disk_space
100
8080
2022
/var/lib/pterodactyl/volumes
EOF

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]        CREATE NODE & LOCATION SUKSES             [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  clear
  exit 0
}
uninstall_panel() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                    UNINSTALL PANEL                 [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "


bash <(curl -s https://pterodactyl-installer.se) <<EOF
y
y
y
y
EOF


  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 UNINSTALL PANEL SUKSES             [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  clear
  exit 0
}
configure_wings() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                    CONFIGURE WINGS                 [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  #!/bin/bash

# Minta input token dari pengguna
read -p "Masukkan token Configure menjalankan wings: " wings

eval "$wings"
# Menjalankan perintah systemctl start wings
sudo systemctl start wings

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 CONFIGURE WINGS SUKSES             [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  clear
  exit 0
}
hackback_panel() {
  echo -e "                                                       "
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "${BLUE}[+]                    HACK BACK PANEL                 [+]${NC}"
  echo -e "${BLUE}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  # Minta input dari pengguna
read -p "Masukkan Username Panel: " user
read -p "password login " psswdhb
  #!/bin/bash
cd /var/www/pterodactyl || { echo "Direktori tidak ditemukan"; exit 1; }

# Membuat lokasi baru
php artisan p:user:make <<EOF
yes
hackback@gmail.com
$user
$user
$user
$psswdhb
EOF
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 AKUN TELAH DI ADD             [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  
  exit 0
}
ubahpw_vps() {
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                    UBAH PASSWORD VPS       [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
read -p "Masukkan Pw Baru: " pw
read -p "Masukkan Ulang Pw Baru " pw

passwd <<EOF
$pw
$pw

EOF


  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 GANTI PW VPS SUKSES         [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  
  exit 0
}
# Main script
display_welcome
install_jq
check_token

while true; do
  clear
  echo -e "                                                                     "
  echo -e "${RED}        _,gggggggggg.                                     ${NC}"
  echo -e "${RED}    ,ggggggggggggggggg.                                   ${NC}"
  echo -e "${RED}  ,ggggg        gggggggg.                                 ${NC}"
  echo -e "${RED} ,ggg'               'ggg.                                ${NC}"
  echo -e "${RED}',gg       ,ggg.      'ggg:                               ${NC}"
  echo -e "${RED}'ggg      ,gg'''  .    ggg       AstraHost PteroMaster Private   ${NC}"
  echo -e "${RED}gggg      gg     ,     ggg      ------------------------  ${NC}"
  echo -e "${WHITE}ggg:     gg.     -   ,ggg       • Developer : @danimaruse    ${NC}"
  echo -e "${WHITE} ggg:     ggg._    _,ggg        • Credit  : Danimaru ${NC}"
  echo -e "${WHITE} ggg.    '.'''ggggggp           • Support by AstraHost Team  ${NC}"
  echo -e "${WHITE}  'ggg    '-.__                                           ${NC}"
  echo -e "${WHITE}    ggg                                                   ${NC}"
  echo -e "${WHITE}      ggg                                                 ${NC}"
  echo -e "${WHITE}        ggg.                                              ${NC}"
  echo -e "${WHITE}          ggg.                                            ${NC}"
  echo -e "${WHITE}             b.                                           ${NC}"
  echo -e "                                                                     "
  echo -e "BERIKUT LIST INSTALL :"
  echo "1. Install theme"
  echo "2. Uninstall theme"
  echo "3. Configure Wings"
  echo "4. Create Node"
  echo "5. Uninstall Panel"
  echo "6. Stellar Theme"
  echo "7. Hack Back Panel"
  echo "8. Ubah Pw Vps"
  echo "x. Exit"
  echo -e "Masukkan pilihan 1/2/x:"
  MENU_CHOICE=""
  read -r MENU_CHOICE
  # Jika input kosong dan sedang mode REPAIR_AUTO, anggap input bermasalah dan keluar
  if [ -z "$MENU_CHOICE" ] && [ "$REPAIR_AUTO" = "true" ]; then
    echo -e "${RED}ERROR: Input tidak terbaca. Terminal mungkin memakan stdin.${NC}"
    exit 1
  fi
  clear

  case "$MENU_CHOICE" in
    1)
      install_theme
      ;;
    2)
      uninstall_theme
      ;;
      3)
      configure_wings
      ;;
      4)
      create_node
      ;;
      5)
      uninstall_panel
      ;;
      6)
      install_themeSteeler
      ;;
      7)
      hackback_panel
      ;;
      8)
      ubahpw_vps
      ;;
    x)
      echo "Keluar dari skrip."
      exit 0
      ;;
    *)
      echo "Pilihan tidak valid, silahkan coba lagi."
      ;;
  esac
done
