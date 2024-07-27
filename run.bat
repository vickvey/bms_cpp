@echo off
setlocal

REM Exit immediately if a command exits with a non-zero status
set "ERRORLEVEL=0"

REM Check if the 'conan' and 'cmake' commands are available
where conan >nul 2>&1 || (echo Error: 'conan' command not found. & exit /b 1)
where cmake >nul 2>&1 || (echo Error: 'cmake' command not found. & exit /b 1)

REM Remove the existing build directory if it exists
if exist "build" (
    echo Removing existing build directory...
    rmdir /s /q "build"
)

REM Create a fresh build directory
mkdir "build\Release"

REM Install dependencies using Conan
echo Installing dependencies using Conan...
conan install . -g CMakeDeps -g CMakeToolchain --build=missing -v || (echo Conan install failed & exit /b 1)

REM Ensure the Conan toolchain file was generated correctly
set "TOOLCHAIN_PATH=build\Release\generators\conan_toolchain.cmake"
if not exist "%TOOLCHAIN_PATH%" (
    echo Error: Conan toolchain file 'conan_toolchain.cmake' not found in build\Release\generators directory.
    exit /b 1
)

REM Configure the project with CMake
echo Configuring the project with CMake...
cd build
cmake -DCMAKE_TOOLCHAIN_FILE="%TOOLCHAIN_PATH%" -DCMAKE_BUILD_TYPE=Release .. || (echo CMake configuration failed & exit /b 1)

REM Build the project
echo Building the project...
cmake --build . || (echo Build failed & exit /b 1)

REM Run the executable
echo Running the executable...
bms_cpp.exe || (echo Execution failed & exit /b 1)

REM Return to the project root
cd ..

echo [Build and run completed successfully]

endlocal
