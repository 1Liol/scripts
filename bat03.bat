@ECHO ON 
setlocal
set "msbuild=c:\Windows\Microsoft.NET\Framework64\v4.0.30319\msbuild.exe"
set "project=c:\Users\hxc_000\Documents\Visual Studio 2015\Projects\WindowsFormsApplication1"
set "outDir=c:\test"
pushd "%project%"
"%msbuild%" /property:WarningLevel=2;OutDir=%outDir% WindowsFormsApplication1.sln