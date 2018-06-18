@echo off

set SCRIPT_HOME=%~dp0

IF NOT EXIST %SCRIPT_HOME%\work (
    CALL :JASYPT_SETUP
)

for /f "usebackq tokens=*" %%i in (`type %SCRIPT_HOME%\work\path.txt`) do @set ENC=%SCRIPT_HOME%\work\%%i\bin\encrypt.bat

%ENC% %*

GOTO END

:JASYPT_SETUP
mkdir %SCRIPT_HOME%\work
set JASYPT_URL=https://sourceforge.net/projects/jasypt/files/latest/download?source=files
bitsadmin.exe /TRANSFER jasyptdownload %JASYPT_URL% %SCRIPT_HOME%\work\jasypt.zip
powershell -Command "Expand-Archive %SCRIPT_HOME%\work\jasypt.zip -DestinationPath %SCRIPT_HOME%\work"
dir /b %SCRIPT_HOME%\work\jasypt-* > %SCRIPT_HOME%\work\path.txt
EXIT /b 1

:END