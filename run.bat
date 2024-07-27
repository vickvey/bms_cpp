@echo off
setlocal

REM Exit immediately if a command exits with a non-zero status
set "ERRLEVEL=0"

REM Function to check if a command exists
where /Q "%1"
if %ERRORLEVEL% NEQ 0 exit /b 1

REM Check if we're in the correct directory
if not "%~nx0"=="bms_cpp" (
    echo Error: This script must be run from the cpp_bms directory.
    exit /b 1
)

REM Check if conan is installed
where conan >nul 2>&1 || (
    echo Error: Conan is not installed. Please install Conan and try again.
    exit /b 1
)

REM Check if cmake is installed
where cmake >nul 2>&1 || (
    echo Error: CMake is not installed. Please install CMake and try again.
    exit /b 1
)

REM Create build directory if it doesn't exist
if not exist build mkdir build

REM Install dependencies using Conan
conan install . --output-folder=build --build=missing

REM Navigate to build directory
cd build

REM Configure the project with CMake
cmake -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release ..

REM Build the project
cmake --build . --config Release

REM Run the executable
cpp_bms.exe

REM Return to the project root
cd ..

echo [Build completed successfully]
echo [Run completed successfully]

endlocal
