@echo off
title Windows Defender Scan History Cleaner
echo ===================================================
echo Deleting Windows Defender Scan History...
echo ===================================================

echo [1] Taking ownership of the Scans folder...
takeown /F "C:\ProgramData\Microsoft\Windows Defender\Scans" /R /D Y >nul 2>&1

echo [2] Granting full control to Administrators...
icacls "C:\ProgramData\Microsoft\Windows Defender\Scans" /grant administrators:F /T >nul 2>&1

echo [3] Removing the folder and all its contents...
rd /s /q "C:\ProgramData\Microsoft\Windows Defender\Scans"

echo [4] Verifying deletion...
if exist "C:\ProgramData\Microsoft\Windows Defender\Scans" (
    echo ERROR: Folder still exists. Please restart in Safe Mode and run this script again.
    pause
    exit /b 1
) else (
    echo SUCCESS: The Scans folder has been deleted.
)

echo ===================================================
echo Operation completed.
pause