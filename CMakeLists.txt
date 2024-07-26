cmake_minimum_required(VERSION 3.15)
project(cpp_bms)

set(CMAKE_CXX_STANDARD 17)

find_package(fmt CONFIG REQUIRED)

add_executable(cpp_bms src/main.cpp)
target_link_libraries(cpp_bms PRIVATE fmt::fmt)