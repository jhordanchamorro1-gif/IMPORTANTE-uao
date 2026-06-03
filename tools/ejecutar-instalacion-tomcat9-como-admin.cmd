@echo off
setlocal

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Solicitando permisos de administrador...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process cmd.exe -ArgumentList '/c ""%~f0""' -Verb RunAs"
    exit /b
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0instalar-tomcat9.ps1" -Silent

if %errorLevel% neq 0 (
    echo.
    echo Hubo un error durante la instalacion de Tomcat 9. Revisa la salida en pantalla.
    pause
    exit /b 1
)

echo.
echo Instalacion de Tomcat 9 completada.
pause
