#!/bin/bash

echo "========================================"
echo "   INICIANDO ENTORNO DOCKER PHP 5.6"
echo "========================================"
echo

# Verificar si Docker está ejecutándose
if ! docker version >/dev/null 2>&1; then
    echo "ERROR: Docker no está ejecutándose o no está instalado."
    echo "Por favor, inicia Docker y vuelve a intentar."
    exit 1
fi

# Verificar si existe el archivo .env
if [ ! -f .env ]; then
    echo "Copiando archivo de configuración..."
    cp env.example .env
    echo "Archivo .env creado desde env.example"
    echo
fi

# Crear directorio src si no existe
if [ ! -d "src" ]; then
    echo "Creando directorio src..."
    mkdir -p src
fi

# Crear directorio mysql-init si no existe
if [ ! -d "mysql-init" ]; then
    echo "Creando directorio mysql-init..."
    mkdir -p mysql-init
fi

echo "Construyendo y levantando contenedores..."
echo

# Construir y levantar los contenedores
docker-compose up -d --build

if [ $? -eq 0 ]; then
    echo
    echo "========================================"
    echo "   ENTORNO INICIADO CORRECTAMENTE"
    echo "========================================"
    echo
    echo "Servicios disponibles:"
    echo "- Aplicación PHP: http://localhost:8080"
    echo "- phpMyAdmin:     http://localhost:8081"
    echo "- MySQL:          localhost:3306"
    echo
    echo "Credenciales MySQL:"
    echo "- Usuario: php_user"
    echo "- Password: php_password123"
    echo "- Base de datos: php_app"
    echo
    
    # Detectar el sistema operativo para abrir el navegador
    if command -v xdg-open > /dev/null; then
        # Linux
        echo "Abriendo aplicación en el navegador..."
        xdg-open http://localhost:8080
    elif command -v open > /dev/null; then
        # macOS
        echo "Abriendo aplicación en el navegador..."
        open http://localhost:8080
    else
        echo "Presiona Enter para continuar..."
        read
    fi
else
    echo
    echo "ERROR: No se pudo iniciar el entorno."
    echo "Revisa los logs con: docker-compose logs"
    exit 1
fi

echo
echo "Para detener el entorno, ejecuta: ./stop.sh"
echo "Para ver logs: docker-compose logs -f"
echo

