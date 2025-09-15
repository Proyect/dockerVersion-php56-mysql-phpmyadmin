@echo off
REM Script de backup automático diario
REM Este script se ejecuta automáticamente una vez al día

REM Cambiar al directorio del proyecto
cd /d "%~dp0"

REM Crear directorio de backups si no existe
if not exist backups mkdir backups

REM Obtener fecha para el nombre del archivo
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "backup_file=backups\mysql_backup_daily_%YYYY%-%MM%-%DD%.sql"

REM Verificar que el contenedor MySQL esté ejecutándose
docker-compose ps mysql | findstr "Up" >nul
if %errorlevel% neq 0 (
    echo %date% %time% - ERROR: MySQL no está ejecutándose >> backups\backup.log
    exit /b 1
)

REM Crear el backup
docker-compose exec -T mysql mysqldump -u root -prootpassword123 --all-databases --routines --triggers > "%backup_file%" 2>> backups\backup.log

if %errorlevel% equ 0 (
    echo %date% %time% - Backup exitoso: %backup_file% >> backups\backup.log
    
    REM Comprimir el backup para ahorrar espacio
    powershell -command "Compress-Archive -Path '%backup_file%' -DestinationPath '%backup_file%.zip' -Force"
    if exist "%backup_file%.zip" del "%backup_file%"
) else (
    echo %date% %time% - ERROR: Fallo en backup >> backups\backup.log
)

REM Limpiar backups antiguos (mantener solo 7 días)
forfiles /p backups /m mysql_backup_daily_*.sql /d -7 /c "cmd /c del @path" 2>nul
forfiles /p backups /m mysql_backup_daily_*.zip /d -7 /c "cmd /c del @path" 2>nul

