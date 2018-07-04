#!/bin/bash

# Compile et déplace le fichier cape si pas fait 
export CAPE_FILE=/lib/firmware/CNC-00A0.dtbo
if [ ! -f "$CAPE_FILE" ]; then
	echo "Génération du fichier overlay"
	dtc -O dtb -o CNC-00A0.dtbo -b 0 -@ CNC.dts
	sudo cp CNC-00A0.dtbo /lib/firmware/
else
	echo "Overlay deja genere"
fi

# Installation du pilote écran 7 pouces si pas installé
export LCD_FILE=/usr/share/gmoccapy_lcd7
if [ ! -d "$LCD_FILE" ]; then
        echo "Installation de l ecran"
	git clone https://github.com/vichente1/gmoccapy_lcd7.git
	cd gmoccapy_lcd7/	
	sudo cp bin/gmoccapy_lcd7 /usr/bin/
	sudo chmod a+x /usr/bin/gmoccapy_lcd7
	sudo cp -r share/gmoccapy_lcd7/ /usr/share/
	sudo apt-get update
	sudo apt-get install matchbox
	sudo cp keyboard-cnc.xml /usr/share/matchbox-keyboard
	sudo chmod a+x /usr/share/matchbox-keyboard/keyboard-cnc.xml
else
	echo "Ecran deja installe"
fi

echo Initialisation des pins
echo Declaration des variables :
export SLOTS=/sys/devices/bone_capemgr.*/slots
export PINS=/sys/kernel/debug/pinctrl/44e10800.pinmux/pins
export GPIO=/sys/class/gpio
# CAPE :

echo Chargement de la cape
echo CNC | sudo tee $SLOTS

echo Definition des GPIOs
# echo 23 | sudo tee $GPIO/export		# Mettre le numéro de la colonne GPIO associé 23 pour 8.13 
echo 30 | sudo tee $GPIO/export		# P9.11	xlim in	
echo 31 | sudo tee $GPIO/export		# P9.13 ylim in
echo 23 | sudo tee $GPIO/export         # P8.13 zlim in

echo 4  | sudo tee $GPIO/export         # P9.18	xok out
echo 5  | sudo tee $GPIO/export         # P9.17 yok out
echo 26 | sudo tee $GPIO/export         # P8.14 zok out

echo 14 | sudo tee $GPIO/export         # P9.26	xen out
echo 15 | sudo tee $GPIO/export         # P9.24 yen out
echo 68 | sudo tee $GPIO/export         # P8.10 yok out

echo 47 | sudo tee $GPIO/export         # P8.15 RELAY

echo Definition de la direction
echo "in" | sudo tee $GPIO/gpio30/direction
echo "in" | sudo tee $GPIO/gpio31/direction
echo "in" | sudo tee $GPIO/gpio23/direction

echo "out" | sudo tee $GPIO/gpio4/direction
echo "out" | sudo tee $GPIO/gpio5/direction
echo "out" | sudo tee $GPIO/gpio26/direction

echo "out" | sudo tee $GPIO/gpio47/direction

echo "out" | sudo tee $GPIO/gpio14/direction
echo "out" | sudo tee $GPIO/gpio15/direction
echo "out" | sudo tee $GPIO/gpio68/direction

exit 0


