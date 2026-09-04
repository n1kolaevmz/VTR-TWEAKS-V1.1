@echo off
title VTR TWEAKS V1.1
chcp 65001 >nul
color B

net session >nul 2>&1
if %errorlevel% neq 0 (
   echo [!] ERROR, PLEASE RUN AS ADMINISTRATOR!
   pause
   exit /B
)
:: ╭──────────────────────────────────────────╮
:: │         QUESTION RESTORE POINT           │
:: ╰──────────────────────────────────────────╯
cls
echo VTR OPTIMIZER - SYSTEM RESTORE POINT
echo.
set /p CHOICE= "Do you want to create a restore point before the optimization? (Y/N): "

if /i "%CHOICE%"=="Y" (
   echo.
   echo [i] Creating Restore Point... Please wait...
   wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "VTR_Optimization_Point", 100, 7
   if %errorlevel% equ 0 (
      echo [OK] Restore Point has been completed successfully! 
   ) else (
      echo [!] Error creating a restore point.
   )
   timeout /t 3 >nul
) else (
   echo.
   echo [!] Skipping Restore Point...
   timeout /t 2 >nul
)

chcp 65001 >nul
cls

color B
title VTR TWEAKS v1.1

:: ╭──────────────────────────────────────────╮
:: │             STARTING TWEAKS              │
:: ╰──────────────────────────────────────────╯
cls
echo [!] Loading Tweaks...
echo.
timeout /t 1 >nul

:MENU
cls
echo ╭──────────────────────────────────────────╮
echo │             VTR TWEAKS v1.1              │
echo ├──────────────────────────────────────────┤
echo │                                          │ 
echo │  [1] CPU Optimization                    │
echo │  [2] GPU Optimization                    │
echo │  [3] Network Optimization                │
echo │  [4] Debloat                             │
echo │  [0] Exit                                │
echo ╰──────────────────────────────────────────╯
echo.

set /p choice="Select an option:"

if "%choice%"=="1" goto CPU_OPT
if "%choice%"=="2" goto GPU_OPT
if "%choice%"=="3" goto NET_OPT
if "%choice%"=="4" goto DEBLOAT_OPT
if "%choice%"=="0" exit

echo [!] Invalid Option!
timeout /t 2 >nul
goto MENU

:: ╭──────────────────────────────────────────╮
:: │          1. CPU OPTIMIZATION             │
:: ╰──────────────────────────────────────────╯
:CPU_OPT
cls
echo Applying CPU Optimization...
echo.
timeout /t 2 >nul

:: 1. Activating Ultimate Performance Power Plan
echo [1/4] Activating Ultimate Performance Power Plan...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f147449eb61 >nul 2>&1
powercfg /setactive e9a42b02-d5df-448d-aa00-03f147449eb61 >nul 2>&1
timeout /t 1 >nul

:: 2. Optimizing Win32PrioritySeparation
echo [2/4] Setting processor priority...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul 2>&1
timeout /t 2 >nul

:: 3. Deactivation Core Parking
echo [3/4] Deactivating Cpu Core Parking...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54336251-55d5-438b-a6a9-0163076f4e26\0cc narrow-4b95-8e3d-6b0a8d7637f6" /v "Attributes" /t REG_DWORD /d 0 /f >nul 2>&1
timeout /t 2 >nul

:: 4. Deactivation Power Throttling for games
echo [4/4] Turning off Power Throttling...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f >nul 2>&1
timeout /t 1 >nul


echo.
echo [+] CPU Optimization completed successfully!
echo.
timeout /t 3 >nul
pause
goto MENU

:: ╭──────────────────────────────────────────╮
:: │          2. GPU OPTIMIZATION             │
:: ╰──────────────────────────────────────────╯
:GPU_OPT
cls
echo Applying GPU Optimization...
echo.
timeout /t 2 >nul

:: 1. Activating Hardware-Accelerated GPU Scheduling (HAGS)
echo [1/3] Turning on HAGS...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul 2>&1
timeout /t 2 >nul

:: 2. Priority For Games
echo [2/3] Turning on GPU Priority...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
timeout /t 1 >nul

:: 3. Cleaning DirectX / GPU Shader Cache (Stutter)
echo [3/3] Cleaning DirectX Shader Cache...
del /q /f /s "%LOCALAPPDATA%\D3DSCache\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\NVIDIA\DXCache\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\AMD\DxCache\*" >nul 2>&1
timeout /t 3 >nul

echo.
echo [+] GPU Optimization completed successfully!
echo.
timeout /t 3 >nul
pause
goto MENU

:: ╭──────────────────────────────────────────╮
:: │        3. NETWORK OPTIMIZATION           │ 
:: ╰──────────────────────────────────────────╯
:NET_OPT
cls
echo Applying Network Optimization...
echo.
timeout /t 2 >nul

:: 1. Deactivating Nagle's Algorithm (Low latency)
echo [1/4] Deactivating Nagle's Algorithm...
reg add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /t REG_DWORD /d 1 /f >nul 2>&1
timeout /t 1 >nul

:: 2. Settings For TCP/IP Adapters For Minimal Ping
echo [2/4] Optimizing TCP Global settings...
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global ecncapability=disabled >nul 2>&1
netsh int tcp set global timestamps=disabled >nul 2>&1
timeout /t 1 >nul

:: 3. Clearing the DNS cache and renewing the IP
echo [3/4] Cleaning DNS Cache...
ipconfig /flushdns >nul 2>&1
timeout /t 1 >nul

:: 4. Game Network Priority 
echo [4/4] Setting Network Priority For Games...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f >nul 2>&1
timeout /t 1 >nul

echo.
echo [+] NETWORK Optimization completed successfully!
echo.
timeout /t 3 >nul
pause
goto MENU

:: ╭──────────────────────────────────────────╮
:: │               4. DEBLOAT                 │ 
:: ╰──────────────────────────────────────────╯
:DEBLOAT_OPT
cls
echo Debloating...
echo.
timeout /t 2 >nul

echo [1/5] Stopping Telemetry...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservices" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
timeout /t 1 >nul

echo [2/5] Stopping Xbox Services...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
timeout /t 2 >nul

echo [3/5] Stopping Geolocation and Maps Broker...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
timeout /t 1 >nul

echo [4/5] Disabling Background Apps...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessAppApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsRunInBackground /t REG_DWORD /d 2 /f >nul 2>&1
timeout /t 3 >nul

echo [5/5] Cleaning Task Manager Startup Registry Keys...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Cortana" /f >nul 2>&1
timeout /t 2 >nul

echo.
echo [+] Debloat completed successfully!
echo.
timeout /t 3 >nul
pause
goto MENU