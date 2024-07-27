cmake_minimum_required(VERSION 3.15)
project(bms_cpp)

# Define the path to the Conan toolchain file
set(CONAN_TOOLCHAIN_FILE "${CMAKE_BINARY_DIR}/Release/generators/conan_toolchain.cmake")

# Include the Conan toolchain file if it exists
if(EXISTS "${CONAN_TOOLCHAIN_FILE}")
    include(${CONAN_TOOLCHAIN_FILE})
else()
    message(FATAL_ERROR "Conan toolchain file not found at ${CONAN_TOOLCHAIN_FILE}. Run 'conan install' to generate it.")
endif()

# Find packages
find_package(fmt REQUIRED)
find_package(stduuid REQUIRED)

# Define executable
add_executable(bms_cpp src/main.cpp)
target_link_libraries(bms_cpp PRIVATE fmt::fmt stduuid::stduuid)
