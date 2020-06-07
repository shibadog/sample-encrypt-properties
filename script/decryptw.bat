@echo off

set SCRIPT_HOME=%~dp0
set VERSION=1.9.3

IF NOT EXIST %SCRIPT_HOME%\work (
    CALL :JASYPT_SETUP
)

for /f "usebackq tokens=*" %%i in (`type %SCRIPT_HOME%\work\path.txt`) do @set ENC=%SCRIPT_HOME%\work\%%i\bin\decrypt.bat

%ENC% %*

GOTO END

:JASYPT_SETUP
mkdir %SCRIPT_HOME%\work
set JASYPT_URL=http://github.com/jasypt/jasypt/releases/download/jasypt-%VERSION%/jasypt-%VERSION%-dist.zip
powershell -Command "wget %JASYPT_URL% -o %SCRIPT_HOME%\work\jasypt.zip"
powershell -Command "Expand-Archive %SCRIPT_HOME%\work\jasypt.zip -DestinationPath %SCRIPT_HOME%\work"
dir /b %SCRIPT_HOME%\work\jasypt-* > %SCRIPT_HOME%\work\path.txt
EXIT /b 1

:END