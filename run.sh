#!/usr/bin/env zsh

# Exit immediately if a command exits with a non-zero status
set -e

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if we're in the correct directory
if [[ ${PWD:t} != "bms_cpp" ]]; then
    echo "Error: This script must be run from the cpp_bms directory."
    exit 1
fi

# Check if conan is installed
if ! command_exists conan; then
    echo "Error: Conan is not installed. Please install Conan and try again."
    exit 1
fi

# Check if cmake is installed
if ! command_exists cmake; then
    echo "Error: CMake is not installed. Please install CMake and try again."
    exit 1
fi

# Create build directory if it doesn't exist
mkdir -p build

# Install dependencies using Conan
conan install . --output-folder=build --build=missing

# Navigate to build directory
cd build

# Configure the project with CMake
cmake -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release ..

# Build the project
cmake --build .

echo "\n[Build completed successfully]\n"

# Run the executable
./cpp_bms

# Return to the project root
cd ..

echo "\n[Run completed successfully]\n"