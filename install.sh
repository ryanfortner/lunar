#!/bin/bash
#Script created by oxmc
#Made for Lunar-Client by gl91306

#install modprobe if not already installed
if ! command -v modprobe >/dev/null;then
  
  if [ -f /usr/bin/apt ];then
    sudo apt update
    sudo apt install -y modprobe || echo "Failed to install modprobe."
  else
    error "Failed to find any package manager to install modprobe."
  fi
fi

#Run modprobe fuse
sudo modprobe fuse

#Download client
wget https://github.com/gl91306/lunar/blob/master/lunarclient-2.7.3a-armv7l.AppImage?raw=true
if [ ! -d ~/lwjgl3arm32 ]; then
    mkdir ~/lwjgl3arm32
fi
if [ ! -d ~/lwjgl2arm32 ]; then
    mkdir ~/lwjgl2arm32
fi
if [ ! -f jdk-8u251-linux-arm32-vfp-hflt.tar.gz ]; then
    wget https://github.com/mikehooper/Minecraft/raw/main/jdk-8u251-linux-arm32-vfp-hflt.tar.gz
fi
if [ ! -f lwjgl3arm32.tar.gz ]; then
    wget https://github.com/mikehooper/Minecraft/raw/main/lwjgl3arm32.tar.gz
fi
if [ ! -f lwjgl2arm32.tar.gz ]; then
    wget https://github.com/mikehooper/Minecraft/raw/main/lwjgl2arm32.tar.gz
fi
if [ ! -d /opt/jdk ]; then
    sudo mkdir /opt/jdk
fi
sudo tar -zxf jdk-8u251-linux-arm32-vfp-hflt.tar.gz -C /opt/jdk
tar -zxf lwjgl3arm32.tar.gz -C ~/lwjgl3arm32
tar -zxf lwjgl2arm32.tar.gz -C ~/lwjgl2arm32
sudo update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_251/bin/java 0
sudo update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_251/bin/javac 0
sudo update-alternatives --set java /opt/jdk/jdk1.8.0_251/bin/java
sudo update-alternatives --set javac /opt/jdk/jdk1.8.0_251/bin/javac
cd lwjgl2arm32
wget https://github.com/gl91306/lunar/raw/master/libwebp-imageio32.so
cd
cd lwjgl3arm32
wget https://github.com/gl91306/lunar/raw/master/libwebp-imageio32.so
cd
cd /opt/jdk/jdk1.8.0_251
sudo rm -rf /jre
echo please wait a bit, as this step takes a bit
sudo svn checkout https://github.com/gl91306/lunar/trunk/jre
cd
#Change perms of Launcher
sudo chmod +x $HOME/lunarclient-2.7.3a-armv7l.AppImage

#Run launcher
$HOME/lunarclient-2.7.3a-armv7l.AppImage

#Handle error about jvm
#Copy jdk version into ~/.lunarclient/jre/zulu8.52.0.23-ca-fx-jre8.0.282-linux_x64

#Then make menu button
echo "Creating a desktop entry for Lunar-Client..."
echo "[Desktop Entry]
Name=\"Lunar-Client for Rpi\"
Comment=\"Lunar-Client for Rpi made by PiKATchu on Discord.\"
Exec=$HOME/lunarclient-2.7.3a-armv7l.AppImage
Icon=$HOME/.lunarclient/icon.png
Categories=Utility;
Type=Application
Terminal=false" > "$HOME/.local/share/applications/Lunar-Client.desktop"
