# windows-defender-cleaner
Windows Defender History Cleaner – A batch script to forcibly delete Windows Defender scan history, cache, and quarantine logs. Useful for red team labs, forensics cleanup, and privacy testing.
# 🧹 Windows Defender History Cleaner

A powerful batch script to **forcibly delete** the entire Windows Defender scan history, cache files, and quarantine records located in `C:\ProgramData\Microsoft\Windows Defender\Scans`.

> ⚠️ **Disclaimer**: This script is intended for **educational purposes, red team labs, and authorized security testing only**. Use it only on systems you own or have explicit permission to test.

---

## 📋 What It Does

- Takes **ownership** of the `Scans` folder (`takeown`).
- Grants **full control** to the Administrators group (`icacls`).
- **Forcibly removes** the folder and all its subfolders (`rd /s /q`).
- **Verifies** deletion and reports success or failure.
- Clears **System, Security, and Application** event logs (optional addition).

---

## ⚙️ How to Use

### Prerequisites
- Windows 7 / 8 / 10 / 11
- **Administrator privileges** (right-click → Run as administrator)
- **Safe Mode** (recommended for 100% success, as Defender locks files when running)

### Steps
1. Download or create `DeleteDefender.bat`.
2. Right‑click the file and select **"Run as administrator"**.
3. Wait for the script to complete.
4. Restart your PC normally.

---

## 🚀 Why Safe Mode?

Windows Defender runs as a protected service (`MsMpEng.exe`). Even with admin rights, many cache files are locked while the service is active.  
**Safe Mode** prevents Defender from starting, ensuring all files are unlocked and deletable.

---

## 🔧 The Script

```batch
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
