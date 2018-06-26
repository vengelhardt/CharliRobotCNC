#!/bin/bash
export DIRECTORY=/sys/dvices

if [ ! -d "$DIRECTORY" ]; then
  echo Pas de Fichier
fi
