@echo off
chcp 932 > nul
echo ===================================
echo  Chatlady Manager Setup
echo ===================================
echo.
echo Installing required software...
echo Please wait a few minutes.
echo.

python --version > nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python is not installed.
    echo Please install Python from https://www.python.org
    pause
    exit /b 1
)

echo [1/3] Upgrading pip...
python -m pip install --upgrade pip --quiet --no-warn-script-location

echo [2/3] Installing Playwright...
python -m pip install playwright --quiet --no-warn-script-location

echo [3/3] Installing Chromium...
python -m playwright install chromium

echo.
echo ===================================
echo  Setup Complete!
echo  Please launch ChatladyManager.exe
echo ===================================
echo.
pause
