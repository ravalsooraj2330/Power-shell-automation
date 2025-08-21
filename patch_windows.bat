@echo off
:: Windows Patching Automation (Batch)
:: Logs to C:\Logs\PatchReport.log (creates folder if missing)
:: Runs scan → download → install → optional reboot

setlocal enabledelayedexpansion

set LOGDIR=C:\Logs
set LOGFILE=%LOGDIR%\PatchReport.log
if not exist "%LOGDIR%" mkdir "%LOGDIR%"

echo [%date% %time%] --- Patch run started --- >> "%LOGFILE%"

:: Prefer UsoClient on newer Windows; fall back to wuauclt
where UsoClient >nul 2>&1
if %errorlevel%==0 (
  echo [%date% %time%] Using UsoClient >> "%LOGFILE%"
  UsoClient StartScan          >> "%LOGFILE%" 2>&1
  UsoClient StartDownload      >> "%LOGFILE%" 2>&1
  UsoClient StartInstall       >> "%LOGFILE%" 2>&1
) else (
  echo [%date% %time%] Using wuauclt >> "%LOGFILE%"
  wuauclt /detectnow               >> "%LOGFILE%" 2>&1
  wuauclt /updatenow               >> "%LOGFILE%" 2>&1
)

:: Optional reboot flag
if /I "%1"=="--reboot" (
  echo [%date% %time%] Reboot requested. Scheduling in 2 minutes... >> "%LOGFILE%"
  shutdown /r /t 120 /c "Windows patching complete — automated reboot"
) else (
  echo [%date% %time%] No reboot flag provided. Skipping reboot. >> "%LOGFILE%"
)

echo [%date% %time%] --- Patch run finished --- >> "%LOGFILE%"
endlocal
