#!/bin/bash

# Script de instalação pós-formatação Pop!_OS (Ubuntu 21.04)
# atualizado em 26/03/2022


# lag de teclas gnome português
# sudo nano /usr/share/X11/xkb/symbols/br
# comentar modifier_map Mod3 { Scroll_Lock };


echo "----------------------------------------------------------------------------------------------------"

# update do sistema

echo '\033[0;31m ----- Atualizando... ----- \033[0m'

sudo apt update ; sudo apt upgrade -y

echo "----------------------------------------------------------------------------------------------------"


# instalando o Flatpak e adicionando o repositório

echo "\033[0;31m ----- Instalando Flatpak e adicionando o repositório do Flathub... ----- \033[0m"

sudo apt install flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


echo "----------------------------------------------------------------------------------------------------"

<<'/GNOME_STORE' #comentado pois não é necessário no pop_os
# instalando a loja Gnome Software e o plugin para Flatpak

echo "\033[0;31m ----- Instalando a Gnome Software e o plugin para Flatpak... ----- \033[0m"

sudo apt install gnome-software gnome-software-plugin-flatpak
/GNOME_STORE

echo "----------------------------------------------------------------------------------------------------"

#FLATPAKS
# instalando pacotes Flatpak: AnyDesk, Discord, Czkawka, GreenWithEnvy (gwe), Spotify, Steam, DBeaver Community, ONLYOFFICE Desktop Editors, qBittorrent, Telegram, VLC, vscodium

echo "\033[0;31m ----- Instalando pacotes Flatpak: AnyDesk, Discord, Czkawka, GreenWithEnvy, Spotify, Steam, DBeaver Community, ONLYOFFICE Desktop Editors, qBittorrent, Telegram, VLC, skype  ----- \033[0m"

flatpak install --system flathub org.telegram.desktop org.qbittorrent.qBittorrent org.videolan.VLC org.onlyoffice.desktopeditors \
io.dbeaver.DBeaverCommunity com.valvesoftware.Steam com.leinardi.gwe \
com.github.qarmin.czkawka com.discordapp.Discord com.anydesk.Anydesk com.vscodium.codium com.spotify.Client com.skype.Client -y

echo "----------------------------------------------------------------------------------------------------"
<<'/REPOSITORIOS' #desnecessário pois já existe versão flatpak acima

echo "\033[0;31m ----- Adicionando repositórios... ----- \033[0m"

echo "VScodium"

wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium.gpg 
echo 'deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list.d/vscodium.list 

sudo apt update ; sudo apt install codium -y

echo "Repositórios adicionados com sucesso!"

/REPOSITORIOS

echo "----------------------------------------------------------------------------------------------------"

echo "\033[0;31m ----- Instalando programas... ----- \033[0m"

sudo apt update 

echo "Flameshot, virtualbox, scrcpy, gnome tweaks, brave browser, timeshift"
sudo apt install flameshot virtualbox virtualbox-guest-utils scrcpy gnome-tweaks timeshift -y


sudo apt install apt-transport-https curl -y

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

sudo apt install brave-browser -y

echo "----------------------------------------------------------------------------------------------------"


echo "\033[0;31m ----- Baixando pacotes DEB... ----- \033[0m"

cd ~/Downloads/

#echo "Google Chrome"

#wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb


echo "----------------------------------------------------------------------------------------------------"

echo "Veracrypt"

wget -c https://launchpad.net/veracrypt/trunk/1.25.9/+download/veracrypt-1.25.9-Ubuntu-21.10-amd64.deb


echo "----------------------------------------------------------------------------------------------------"


echo "Genymotion" #provavelmente já está desatualizado pois o link especifica uma versão

wget -c https://dl.genymotion.com/releases/genymotion-3.2.1/genymotion-3.2.1-linux_x64.bin
sudo chmod +x genymotion-3.2.1-linux_x64.bin
./genymotion-3.2.1-linux_x64.bin



echo "----------------------------------------------------------------------------------------------------"


echo "Dropbox"

wget -c https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb

echo "----------------------------------------------------------------------------------------------------"



echo "Teamviewer"
wget -c https://download.teamviewer.com/download/linux/teamviewer_amd64.deb

echo "----------------------------------------------------------------------------------------------------"


echo "Private Internet Access" #provavelmente já está desatualizado pois o link especifica uma versão
wget -c https://installers.privateinternetaccess.com/download/pia-linux-3.3-06906.run
sudo chmod +x pia-linux-3.3-06906.run
./pia-linux-3.3-06906.run

echo "----------------------------------------------------------------------------------------------------"

echo "Instalando pacotes DEB"

sudo dpkg -i *.deb
sudo apt update
sudo apt install -f -y

echo "Fazendo Limpeza no sistema"
sudo apt update -y && sudo apt autoremove -y

echo "----------------------------------------------------------------------------------------------------"

echo "Configurando Coolbits"

sudo nvidia-xconfig

sudo nvidia-xconfig --cool-bits=4


echo "----------------------------------------------------------------------------------------------------"
<<'/skype'
echo "Instalando Snaps exclusivamente para usar Skype -- Thanks Microsoft"

sudo apt install snapd

sudo snap install skype

/skype

echo "----------------------------------------------------------------------------------------------------"
<<'/edge'


#echo "Microsoft Edge"

#wget -c https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-beta/microsoft-edge-beta_92.0.902.40-1_amd64.deb

echo "Arrumando o Edge no Linux para atualização automática -- Thanks Microsoft"

curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
/edge

echo "----------------------------------------------------------------------------------------------------"

echo "Exibindo UUID para inclusão no fstab"

sudo blkid | grep Dados


echo "----------------------------------------CONCLUÍDO----------------------------------------"
