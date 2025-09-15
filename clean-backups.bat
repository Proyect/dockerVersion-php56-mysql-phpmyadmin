@echo off
echo ========================================
echo    LIMPIAR BACKUPS ANTIGUOS
echo ========================================
echo.

REM Verificar que existe el directorio de backups
if not exist backups (
    echo ERROR: No existe el directorio de backups.
    pause
    exit /b 1
)

echo Backups actuales:
dir /b backups\mysql_backup_*.sql 2>nul
if %errorlevel% neq 0 (
    echo No se encontraron backups.
    pause
    exit /b 1
)

echo.
echo ADVERTENCIA: Esta acción eliminará backups antiguos
echo (más de 7 días) para liberar espacio en disco.
echo.
set /p confirm="¿Continuar? (s/N): "
if /i not "%confirm%"=="s" (
    echo Operación cancelada.
    pause
    exit /b 0
)

echo.
echo Eliminando backups antiguos (más de 7 días)...

REM Eliminar backups SQL antiguos
forfiles /p backups /m mysql_backup_*.sql /d -7 /c "cmd /c del @path" 2>nul
if %errorlevel% equ 0 (
    echo - Backups SQL antiguos eliminados
) else (
    echo - No se encontraron backups SQL antiguos
)

REM Eliminar backups ZIP antiguos
forfiles /p backups /m mysql_backup_*.zip /d -7 /c "cmd /c del @path" 2>nul
if %errorlevel% equ 0 (
    echo - Backups ZIP antiguos eliminados
) else (
    echo - No se encontraron backups ZIP antiguos
)

REM Mostrar espacio liberado
echo.
echo Espacio actual en backups:
dir backups /-c | findstr "bytes"

echo.
echo ========================================
echo    LIMPIEZA COMPLETADA
echo ========================================
echo.
echo Los backups antiguos han sido eliminados.
echo Se mantienen los backups de los últimos 7 días.
echo.
pause
