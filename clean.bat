@echo off
echo ========================================
echo    LIMPIEZA COMPLETA DEL ENTORNO DOCKER
echo ========================================
echo.
echo ADVERTENCIA: Esta acción eliminará TODOS los datos de MySQL
echo y volverá a crear el entorno desde cero.
echo.
set /p confirm="¿Estás seguro? (s/N): "
if /i not "%confirm%"=="s" (
    echo Operación cancelada.
    pause
    exit /b 0
)

echo.
echo Deteniendo y eliminando contenedores...
docker-compose down -v

echo.
echo Eliminando imágenes de PHP...
docker rmi php56_app 2>nul

echo.
echo Eliminando volúmenes huérfanos...
docker volume prune -f

echo.
echo Limpiando sistema Docker...
docker system prune -f

echo.
echo ========================================
echo    LIMPIEZA COMPLETADA
echo ========================================
echo.
echo El entorno ha sido completamente limpiado.
echo Para volver a iniciar, ejecuta: start.bat
echo.
pause

