@echo off
echo ========================================
echo    CONFIGURAR BACKUP AUTOMATICO WINDOWS
echo ========================================
echo.

REM Verificar permisos de administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Este script requiere permisos de administrador.
    echo Haz clic derecho en el archivo y selecciona "Ejecutar como administrador"
    pause
    exit /b 1
)

echo Creando tarea programada para backup diario...
echo.

REM Obtener la ruta completa del script
set "script_path=%~dp0backup-daily.bat"

REM Crear la tarea programada
schtasks /create /tn "MySQL Backup Diario" /tr "%script_path%" /sc daily /st 02:00 /ru "SYSTEM" /f

if %errorlevel% equ 0 (
    echo ========================================
    echo    TAREA PROGRAMADA CREADA EXITOSAMENTE
    echo ========================================
    echo.
    echo La tarea se ejecutará todos los días a las 2:00 AM
    echo.
    echo Para ver la tarea:
    echo - Abre "Programador de tareas" en Windows
    echo - Busca "MySQL Backup Diario"
    echo.
    echo Para eliminar la tarea:
    echo schtasks /delete /tn "MySQL Backup Diario" /f
    echo.
    echo Para probar la tarea:
    echo schtasks /run /tn "MySQL Backup Diario"
) else (
    echo ERROR: No se pudo crear la tarea programada.
    echo Verifica que tengas permisos de administrador.
)

echo.
pause

