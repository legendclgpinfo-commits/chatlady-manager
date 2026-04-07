@echo off
chcp 932 > nul
echo ===================================
echo  Chatlady Manager Setup
echo ===================================
echo.
echo Installing required software...
echo Please wait a few minutes.
echo.

REM ===== Python確認・自動インストール =====
python --version > nul 2>&1
if %errorlevel% neq 0 (
    echo [1/5] Downloading Python installer...
    curl -o "%TEMP%\python_installer.exe" https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to download Python.
        echo Please check your internet connection.
        pause
        exit /b 1
    )

    echo [1/5] Installing Python...
    "%TEMP%\python_installer.exe" /passive InstallAllUsers=1 PrependPath=1 Include_test=0
    if %errorlevel% neq 0 (
        echo [ERROR] Python installation failed.
        echo Please install Python manually from https://www.python.org
        pause
        exit /b 1
    )

    del "%TEMP%\python_installer.exe"
    echo [1/5] Python installed successfully!

    set "PATH=%PATH%;C:\Program Files\Python312;C:\Program Files\Python312\Scripts"
) else (
    echo [1/5] Python is already installed. Skipping.
)

echo.

echo [2/5] Upgrading pip...
python -m pip install --upgrade pip --quiet --no-warn-script-location

echo [3/5] Installing Playwright...
python -m pip install playwright --quiet --no-warn-script-location

echo [4/5] Installing Chromium...
python -m playwright install chromium

echo [5/5] Setting Playwright browser path...
setx PLAYWRIGHT_BROWSERS_PATH "%LOCALAPPDATA%\ms-playwright"

echo.
echo ===================================
echo  Setup Complete!
echo  Please launch ChatladyManager.exe
echo ===================================
echo.
pause
