@echo off
REM Change to the directory where the .bat file is located
cd /d "%~dp0"

REM URL of the latest .exe file from GitHub (properly encoded)
set URL=https://github.com/FluffyAsianKid/StudySyntaxReport_release/raw/main/Syntax-SOS-BPD/StudySyntaxReport.exe

REM Name of the .exe file to be updated
set EXE_NAME=StudySyntaxReport.exe

REM Temporary file to download the new .exe
set TEMP_EXE=%EXE_NAME%.new

REM Log file for debugging
set LOG_FILE=update.log

REM Clear log file
echo Starting update at %date% %time% > %LOG_FILE%

REM Download the latest .exe file using PowerShell with robust error handling
echo Downloading latest version of %EXE_NAME%... >> %LOG_FILE%
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; try { Invoke-WebRequest -Uri '%URL%' -OutFile '%TEMP_EXE%' -ErrorAction Stop; Write-Output 'Download succeeded.' } catch { Write-Output 'Download failed: ' + $_.Exception.Message; exit 1 }" >> %LOG_FILE% 2>&1

REM Check if the download was successful
if exist %TEMP_EXE% (
    echo Download succeeded. >> %LOG_FILE%
    echo Replacing old version with new version... >> %LOG_FILE%
    del %EXE_NAME% >> %LOG_FILE% 2>&1
    rename %TEMP_EXE% %EXE_NAME% >> %LOG_FILE% 2>&1
    echo Update complete. >> %LOG_FILE%
    echo Update complete.
) else (
    echo Download failed. >> %LOG_FILE%
    echo Failed to download the latest version. Please check the URL or your internet connection. >> %LOG_FILE%
    echo Failed to download the latest version. Please check the URL or your internet connection.
)

REM Pause to see the output
pause

REM Clean up
set URL=
set EXE_NAME=
set TEMP_EXE=
set LOG_FILE=
