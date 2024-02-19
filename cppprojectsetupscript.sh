#!/bin/bash

if [ "$#" -eq 0 ]; then
    echo "Failed to provide name for project - stopping"
    exit
fi

mkdir "$1"
cd "$1"

mkdir "src"
mkdir "include"
mkdir "storage"
mkdir "build"

cmake_content=$(cat <<EOF
cmake_minimum_required(VERSION 3.27.9)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
project(hello VERSION 1.0)
file(GLOB_RECURSE SRC_FILES src/*.cpp)
file(GLOB_RECURSE HEADER_FILES include/*.h)
file(GLOB_RECURSE C_FILES src/*.c)

add_executable(hello \${SRC_FILES} \${HEADER_FILES} \${C_FILES})
target_include_directories(hello PUBLIC \${CMAKE_CURRENT_SOURCE_DIR}/include)
target_link_libraries(hello)
EOF
)

touch "CMakeLists.txt"
echo "$cmake_content" > CMakeLists.txt
