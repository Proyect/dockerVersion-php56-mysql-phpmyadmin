@echo off
echo ========================================
echo    CREANDO BACKUP DE LA BASE DE DATOS
echo ========================================
echo.

REM Verificar si Docker está ejecutándose
docker version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker no está ejecutándose.
    pause
    exit /b 1
)

REM Crear directorio de backups si no existe
if not exist backups (
    echo Creando directorio de backups...
    mkdir backups
)

REM Obtener fecha y hora para el nombre del archivo
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "timestamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

set "backup_file=backups\mysql_backup_%timestamp%.sql"

echo Creando backup: %backup_file%
echo.

REM Verificar que el contenedor MySQL esté ejecutándose
docker-compose ps mysql | findstr "Up" >nul
if %errorlevel% neq 0 (
    echo ERROR: El contenedor MySQL no está ejecutándose.
    echo Inicia el entorno con: start.bat
    pause
    exit /b 1
)

REM Crear el backup
echo Ejecutando mysqldump...
docker-compose exec -T mysql mysqldump -u root -prootpassword123 --all-databases --routines --triggers > "%backup_file%"

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo    BACKUP CREADO EXITOSAMENTE
    echo ========================================
    echo.
    echo Archivo: %backup_file%
    echo Tamaño: 
    for %%A in ("%backup_file%") do echo %%~zA bytes
    echo.
    echo Para restaurar este backup, usa: restore.bat
) else (
    echo.
    echo ERROR: No se pudo crear el backup.
    echo Verifica que MySQL esté funcionando correctamente.
)

echo.
pause

