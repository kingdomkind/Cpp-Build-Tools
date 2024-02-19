#!/bin/bash

recognised_directories=("src" "build" "include" "storage")
current_directory=$(pwd)
current_folder=$(basename "$current_directory")

contains=false
for element in "${recognised_directories[@]}"; do
  if [ "$current_folder" == "$element" ]; then
    contains=true
  fi
done

if [ "$contains" == true ]; then
  cd ..
  current_directory=$(pwd)
fi


if [ "$contains" == false ]; then
  check_directory="$current_directory/src"

  if ! [ -d "$check_directory" ]; then
    echo "No suitable directory was found!"
    exit
  fi
fi

cd "$current_directory/build"
cmake ..
make
mv compile_commands.json ../
./hello

