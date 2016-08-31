@echo off

REM Batch script to copy uncommented entries of your hosts file
set "BackupHostsFile=%diskletter%\BackupHostsFile.txt"
If Exist "%BackupHostsFile%" Del "%BackupHostsFile%"
set "hostspath=%windir%\System32\drivers\etc\hosts"
REM Find /V "#" : To display all lines NOT containing the specified string "#"
for /f "delims=" %%a in ('Type "%hostspath%" ^| find /v "#"') Do (
    If Not %%a==""  echo %%a >> "%BackupHostsFile%"
)
