#!/bin/bash

while true; do
  read -p "This will remove all files inside src/ folder, u sure you want to proceed ? (y/n) " yn
  case $yn in
    [Yy]* )
      echo 'Removing src/* files...'
      rm -rf src/*
      echo 'Parsing .json into .yml files...'
      ruby lib/json_to_yml.rb
      echo 'Done.'
      break;;
    [Nn]* ) exit;;
    * ) echo "Please answer yes or no.";;
  esac
done
