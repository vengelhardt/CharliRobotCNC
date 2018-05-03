#!/bin/bash
# Indique au système que l'argument qui suit est le programme utilisé pour exécuter ce fichier
# Pour l'instant le dts est stocké dans  home/machinekit/boneDeviceTree/overlay/DM-GPIO-Test.dts
# Liens interessants :
# http://derekmolloy.ie/beaglebone/beaglebone-gpio-programming-on-arm-embedded-linux/

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

echo 67 | sudo tee $GPIO/export         # P8.04	xok out
echo 68 | sudo tee $GPIO/export         # P8.06 yok out
echo 44 | sudo tee $GPIO/export         # P8.08 zok out

echo Definition de la direction
echo "in" | sudo tee $GPIO/gpio30/direction
echo "in" | sudo tee $GPIO/gpio31/direction
echo "in" | sudo tee $GPIO/gpio23/direction

echo "out" | sudo tee $GPIO/gpio67/direction
echo "out" | sudo tee $GPIO/gpio68/direction
echo "out" | sudo tee $GPIO/gpio44/direction

exit 0


