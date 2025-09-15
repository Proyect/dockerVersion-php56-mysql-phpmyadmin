#!/bin/bash

echo "========================================"
echo "   REINICIANDO ENTORNO DOCKER PHP 5.6"
echo "========================================"
echo

# Verificar si Docker está ejecutándose
if ! docker version >/dev/null 2>&1; then
    echo "ERROR: Docker no está ejecutándose o no está instalado."
    echo "Por favor, inicia Docker y vuelve a intentar."
    exit 1
fi

echo "Deteniendo contenedores existentes..."
docker-compose down

echo
echo "Construyendo y levantando contenedores..."
docker-compose up -d --build

if [ $? -eq 0 ]; then
    echo
    echo "========================================"
    echo "   ENTORNO REINICIADO CORRECTAMENTE"
    echo "========================================"
    echo
    echo "Servicios disponibles:"
    echo "- Aplicación PHP: http://localhost:8080"
    echo "- phpMyAdmin:     http://localhost:8081"
    echo "- MySQL:          localhost:3306"
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
    echo "ERROR: No se pudo reiniciar el entorno."
    echo "Revisa los logs con: docker-compose logs"
    exit 1
fi

echo

