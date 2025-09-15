@echo off
echo ========================================
echo    DETENIENDO ENTORNO DOCKER PHP 5.6
echo ========================================
echo.

REM Verificar si Docker está ejecutándose
docker version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker no está ejecutándose.
    pause
    exit /b 1
)

echo Deteniendo contenedores...
docker-compose down

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo    ENTORNO DETENIDO CORRECTAMENTE
    echo ========================================
    echo.
    echo Los contenedores han sido detenidos.
    echo Los datos de MySQL se mantienen guardados.
    echo.
    echo Para volver a iniciar, ejecuta: start.bat
) else (
    echo.
    echo ERROR: No se pudo detener el entorno correctamente.
    echo Intenta con: docker-compose down --remove-orphans
)

echo.
pause

