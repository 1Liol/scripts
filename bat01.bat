:1.Create two scripts that receive folder path as parameter and do the following
:a.Create and mount vhd in folder from parameters (use diskpart)
:b.First batch: copy all .log files from windows folder to vhd
:i.Second batch: first batch action + if system "hosts" file contains any uncommented entries, then copy it too
:c.Detach and pack vhd with 7-zip (assume x86 version is installed)
:d.Change archive name to include date and time of run and file count of files on vhd
:e.Remove oldest archives in folder from parameters if there are more than 5 files in that folder.

@ECHO OFF
set "ZIP=%ProgramFiles%\7-zip\7z.exe"
set "diskletter=Z:"
set "newtime=%TIME:~0,2%%TIME:~3,2%"
set "newdate=%DATE:~0,2%%DATE:~3,2%%DATE:~8,2%"
set "num=0"
set "count=0"
set "batdir=%CD%"
set "tmpbackup=%1"
set "backdir=%2\"
if not defined tmpbackup goto end
if not defined backdir goto end2
if not exist %1 mkdir %1
if not exist %2 mkdir %2

call :CreateDisk


:CreateDisk
popd %tmpbackup%
REM Create vhd
   ( echo select disk 1
     echo create vdisk file=%tmpbackup%\backup.vhd MAXIMUM=1000 type=EXPANDABLE
     echo attach vdisk
     echo CREATE PARTITION PRIMARY
     echo FORMAT FS=NTFS QUICK
     echo ASSIGN LETTER=%diskletter%
     echo attach vdisk
     echo exit
   ) |  diskpart

echo %ErrorLever%
goto:pause

REM Copy log files

xcopy %windir%\*.log %diskletter%  /s /a /d /c > %diskletter%\.copylog.log 2>&1

REM call Bat02 for backup hosts file


call %batdir%\bat02.bat

REM count of files on disk

for /f  %%a in ('dir %diskletter% /a-d/b/s^| find /c /v ""') DO (set  num=%%a)

REM Deatach disk

  (  echo select vdisk file=%tmpbackup%\backup.vhd
     echo detach vdisk
     echo exit
  ) | diskpart

REM Create zip with vhd time:date:filecount.zip
 for /r %tmpbackup% %%i in (*.vhd) DO (
 "%zip%" a -tzip "%backdir%%newtime%%newdate%%num%.zip" "%%i"
 )

REM remove vdisk

del %tmpbackup%\backup.vhd

REM remove old backup


pushd %backdir%

for /f %%d in ('dir /b /a-d *.zip ^| find /c /v ""') do set /a count=%%d

if %count% gtr 5 (
for /f "delims=" %%a in ('dir /t:c /o:-d /b') do set lastfolder=%%a
del "%lastfolder%"
echo "Delited old backup %lastfolder"
echo "Backup complited"
  )

del /q %tmpbackup%
exit /b

:end
echo "Define tmp directory e.g %0 c:\test"
exit /b
:end2
echo "Define backup directory e.g %0 c:\test c:\backup"
exit /b
