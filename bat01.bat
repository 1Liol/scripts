
@ECHO OFF

set "ZIP=%ProgramFiles%\7-zip\7z.exe"
set "diskletter=Z:"
set "newtime=%TIME:~0,2%%TIME:~3,2%"
set "newdate=%DATE:~0,2%%DATE:~3,2%%DATE:~8,2%"
set "num=0"
set "count=0"
set "backdir=%2\"
if not exist %1 mkdir %1
if not exist %2 mkdir %2

popd %1

REM Create vhd

   ( echo select disk 1
     echo create vdisk file=%1\backup.vhd MAXIMUM=1000 type=EXPANDABLE
     echo attach vdisk
     echo CREATE PARTITION PRIMARY
     echo FORMAT FS=NTFS QUICK
     echo ASSIGN LETTER=%diskletter%
     echo attach vdisk
     echo exit
   ) |  diskpart


REM Copy log files

xcopy %windir%\*.log %diskletter%  /s /a /d /c

REM call Bat02 for backup hosts file

call bat02.bat

REM count of files on disk

for /f  %%a in ('dir %diskletter% /a-d/b/s^| find /c /v ""') DO (set  num=%%a)

REM Deatach disk

  (  echo select vdisk file=%1\backup.vhd
     echo detach vdisk
     echo exit
  ) | diskpart

REM Create zip with vhd time:date:filecount.zip
 for /r %1 %%i in (*.vhd) DO (
 "%zip%" a -tzip "%backdir%%newtime%%newdate%%num%.zip" "%%i"
 )

REM remove vdisk

del %1\backup.vhd

popd

REM remove old backup

pushd %2

for /f %%d in ('dir /b /a-d *.zip ^| find /c /v ""') do set /a count=%%d

if %count% gtr 5 (
for /f "delims=" %%a in ('dir /t:c /o:-d /b') do set lastfolder=%%a
del "%lastfolder%"
  )
REM forfiles /p %backdir% /s /m *.* /c "cmd /c Del @path" /d -3
REM for /f "skip=4 delims=" %%i in ('dir "*.zip" /b /a:d /o:-d 2^nul') do rd /s /q "%%i"
REM
REM  echo "%%a"
REM rd /s /q "..\%backdir%\%lastfolder%"
pushd c:\scripts
