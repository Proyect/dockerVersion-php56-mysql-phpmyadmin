@echo off
echo ========================================
echo    INICIANDO ENTORNO DOCKER PHP 5.6
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

REM Verificar si existe el archivo .env
if not exist .env (
    echo Copiando archivo de configuración...
    copy env.example .env
    echo Archivo .env creado desde env.example
    echo.
)

REM Crear directorio src si no existe
if not exist src (
    echo Creando directorio src...
    mkdir src
)

REM Crear directorio mysql-init si no existe
if not exist mysql-init (
    echo Creando directorio mysql-init...
    mkdir mysql-init
)

echo Construyendo y levantando contenedores...
echo.

REM Construir y levantar los contenedores
docker-compose up -d --build

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo    ENTORNO INICIADO CORRECTAMENTE
    echo ========================================
    echo.
    echo Servicios disponibles:
    echo - Aplicación PHP: http://localhost:8080
    echo - phpMyAdmin:     http://localhost:8081
    echo - MySQL:          localhost:3306
    echo.
    echo Credenciales MySQL:
    echo - Usuario: php_user
    echo - Password: php_password123
    echo - Base de datos: php_app
    echo.
    echo Presiona cualquier tecla para abrir la aplicación en el navegador...
    pause >nul
    start http://localhost:8080
) else (
    echo.
    echo ERROR: No se pudo iniciar el entorno.
    echo Revisa los logs con: docker-compose logs
    pause
)

echo.
echo Para detener el entorno, ejecuta: stop.bat
echo Para ver logs: docker-compose logs -f
echo.
pause

