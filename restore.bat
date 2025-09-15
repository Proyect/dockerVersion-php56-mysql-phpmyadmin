@echo off
echo ========================================
echo    RESTAURAR BACKUP DE LA BASE DE DATOS
echo ========================================
echo.

REM Verificar si Docker está ejecutándose
docker version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker no está ejecutándose.
    pause
    exit /b 1
)

REM Verificar que existe el directorio de backups
if not exist backups (
    echo ERROR: No existe el directorio de backups.
    echo Ejecuta primero: backup.bat
    pause
    exit /b 1
)

REM Mostrar backups disponibles
echo Backups disponibles:
echo.
dir /b backups\mysql_backup_*.sql 2>nul
if %errorlevel% neq 0 (
    echo No se encontraron backups.
    pause
    exit /b 1
)

echo.
set /p backup_file="Ingresa el nombre del archivo de backup (sin ruta): "
if "%backup_file%"=="" (
    echo ERROR: No se especificó archivo de backup.
    pause
    exit /b 1
)

REM Verificar que el archivo existe
if not exist "backups\%backup_file%" (
    echo ERROR: El archivo backups\%backup_file% no existe.
    pause
    exit /b 1
)

echo.
echo ADVERTENCIA: Esta acción eliminará TODOS los datos actuales
echo y los reemplazará con los datos del backup.
echo.
set /p confirm="¿Estás seguro? (s/N): "
if /i not "%confirm%"=="s" (
    echo Operación cancelada.
    pause
    exit /b 0
)

echo.
echo Verificando que MySQL esté ejecutándose...
docker-compose ps mysql | findstr "Up" >nul
if %errorlevel% neq 0 (
    echo ERROR: El contenedor MySQL no está ejecutándose.
    echo Inicia el entorno con: start.bat
    pause
    exit /b 1
)

echo.
echo Restaurando backup: %backup_file%
echo Esto puede tomar varios minutos...
echo.

REM Restaurar el backup
docker-compose exec -T mysql mysql -u root -prootpassword123 < "backups\%backup_file%"

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo    BACKUP RESTAURADO EXITOSAMENTE
    echo ========================================
    echo.
    echo La base de datos ha sido restaurada desde: %backup_file%
    echo.
    echo Puedes verificar los datos en: http://localhost:8081
) else (
    echo.
    echo ERROR: No se pudo restaurar el backup.
    echo Verifica que el archivo no esté corrupto.
)

echo.
pause

