
@echo off

set SCRIPT_NAME=program_inventory
set OUTPUT_DIR=%USERPROFILE%\logs\%SCRIPT_NAME%

if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

:: Build timestamp: YYYYMMDD_HH_MM_SS
for /f %%a in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmmss"') do set TS=%%a

set OUTPUT=%OUTPUT_DIR%\%COMPUTERNAME%_%SCRIPT_NAME%_%TS%.txt

powershell -NoProfile -Command "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*,HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -and $_.DisplayName -notmatch 'Windows Driver Package' } | Select-Object -ExpandProperty DisplayName | Sort-Object" > "%OUTPUT%"

echo Saved to:
echo %OUTPUT%
pause
