#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if the 'conan' and 'cmake' commands are available
if ! command -v conan &> /dev/null || ! command -v cmake &> /dev/null; then
    echo "Error: 'conan' or 'cmake' command not found."
    exit 1
fi

# Remove the existing build directory if it exists
if [ -d "build" ]; then
    echo "Removing existing build directory..."
    rm -rf build
fi

# Create a fresh build directory
mkdir -p build/Release

# Install dependencies using Conan
echo "Installing dependencies using Conan..."
conan install . -g CMakeDeps -g CMakeToolchain --build=missing -v || { echo "Conan install failed"; exit 1; }

# Ensure the Conan toolchain file was generated correctly
TOOLCHAIN_PATH="build/Release/generators/conan_toolchain.cmake"
if [ ! -f "$TOOLCHAIN_PATH" ]; then
    echo "Error: Conan toolchain file 'conan_toolchain.cmake' not found in build/Release/generators directory."
    exit 1
fi

# Configure the project with CMake
echo "Configuring the project with CMake..."
cd build
cmake -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_PATH" -DCMAKE_BUILD_TYPE=Release .. || { echo "CMake configuration failed"; exit 1; }

# Build the project
echo "Building the project..."
cmake --build . || { echo "Build failed"; exit 1; }

# Run the executable
echo "Running the executable..."
./bms_cpp || { echo "Execution failed"; exit 1; }

# Return to the project root
cd ..

echo "[Build and run completed successfully]"
