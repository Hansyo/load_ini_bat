@echo off
setlocal enabledelayedexpansion

rem Load ini file used to set variables on terraterm macro

rem Set ini file path from argv
set INI_FILE=%1

rem Check ini file
if NOT EXIST %INI_FILE% (
  echo Usage: load_ini.bat [ini file path]
  exit 1
)

rem Load ini file
set DEVICE_COUNT=0
set DEVICENAME=""

rem Read ini file
for /f "tokens=1,2 delims==" %%a in (%INI_FILE%) do (
  set tmp_A=%%a
  set tmp_A=!tmp_A: =!
  set tmp_B=%%b
  set tmp_B=!tmp_B: =!
  if "!tmp_A!"=="[!tmp_A:~1,-1!]" (
    set /a DEVICE_COUNT=!DEVICE_COUNT!+1
    set DEVICENAME=!tmp_A:~1,-1!
    set DEVICENAME_!DEVICE_COUNT!=!DEVICENAME!
    echo DEVICENAME_!DEVICE_COUNT!=!DEVICENAME!
  ) else (
    if "!tmp_B!"=="" (
      echo Invalid ini file
      exit 1
    )
    set !DEVICENAME!_!tmp_A!=!tmp_B!
    echo !DEVICENAME!_!tmp_A!=!tmp_B!
  )
)
echo TOTAL_DEVICE_NUM=!DEVICE_COUNT!

exit /b 0
