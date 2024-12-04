#!/bin/bash

clear
on(){
  if [[ -n $(nmcli general status | awk '{print $4}' | grep 'desactivado') ]] ; then
    printf "\nActivando wifi..."
    nmcli radio wifi on
    sleep 5
  fi
}

onoff(){
  if [ "$res" == "w" ] ; then
    if [[ -n $(nmcli general status | awk '{print $4}' | grep 'desactivado') ]]; then
      nmcli radio wifi on
      printf "\nRed WIFI activada"
    else
      nmcli radio wifi off
      printf "\nRed WIFI desactivada"
    fi
  fi
}

mos(){
  on
  nmcli device wifi list
}

con(){
  nmcli connect up "$red"
  printf "\n"
}

gua(){
  nmcli connection show
}

cont(){
  read -rp "Presiona cualquier tecla para continuar..." -n 1
}

del(){
  nmcli connection delete "$dele"
}

cre(){
  nmcli device wifi connect $nom password $pass
}
#sudo apt install nodejs npm  sudo npm install -g bash-language-server
echo "---------------ADMINISTRADOR DE REDES------------------
-------------------------------------------------------"

stty -icanon min 1 time 0

while true ; do
  clear
  read -rp "Seleccione una opcion
  [1] Crear nueva red
  [2] Borrar una red
  [3] Encender/apagar red
  [4] Conectar a una red
  [5] Mostrar redes guardadas
  [6] Mostrar redes disponibles
  [q] Salir
  Seleccione una opcion: " -n 1 re

  case $re in
    q) #listo
      clear
      break
    ;;
    1)
      clear
      on
      echo "Encendiendo WI-FI"
      sleep 3
      mos
      read -rp "Coloca el  nombre de la red que desea agregar(BSSID/SSID): " nom
      read -rp "Coloca la contraseña: " pass
      cre
    ;;
    2) #listo
      read -rp "Coloca el  nombre de la red que desea eliminar: " dele
      del
    ;;
    3) #listo
      clear
      nmcli general status | awk '{print $4}'
      read -rp "Coloque W para encender/apagar la red WIFI: " -n 1 res
      onoff
      printf "\n"
      cont

    ;;
    4) #listo
      on
      gua
      read -rp "Coloque el nombre de la red que desea conectar: " red
      con
      cont
    ;;
    5) #listo
      mos
      cont
    ;;
    6) #listo
      mos
      cont
    ;;
    *)
      echo "Opcion no disponible"
    ;;

  esac

done
