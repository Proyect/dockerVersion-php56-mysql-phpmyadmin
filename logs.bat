@echo off
echo ========================================
echo    VISUALIZANDO LOGS DEL ENTORNO DOCKER
echo ========================================
echo.

REM Verificar si Docker está ejecutándose
docker version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker no está ejecutándose.
    pause
    exit /b 1
)

echo Mostrando logs en tiempo real...
echo Presiona Ctrl+C para salir
echo.

docker-compose logs -f

pause

