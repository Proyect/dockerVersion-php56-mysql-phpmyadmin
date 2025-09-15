@echo off
echo ========================================
echo    REINICIANDO ENTORNO DOCKER PHP 5.6
echo ========================================
echo.

REM Verificar si Docker está ejecutándose
docker version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker no está ejecutándose o no está instalado.
    echo Por favor, inicia Docker Desktop y vuelve a intentar.
    pause
    exit /b 1
)

echo Deteniendo contenedores existentes...
docker-compose down

echo.
echo Construyendo y levantando contenedores...
docker-compose up -d --build

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo    ENTORNO REINICIADO CORRECTAMENTE
    echo ========================================
    echo.
    echo Servicios disponibles:
    echo - Aplicación PHP: http://localhost:8080
    echo - phpMyAdmin:     http://localhost:8081
    echo - MySQL:          localhost:3306
    echo.
    echo Presiona cualquier tecla para abrir la aplicación en el navegador...
    pause >nul
    start http://localhost:8080
) else (
    echo.
    echo ERROR: No se pudo reiniciar el entorno.
    echo Revisa los logs con: docker-compose logs
    pause
)

echo.
pause

