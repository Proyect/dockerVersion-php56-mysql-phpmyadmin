#!/bin/bash

echo "========================================"
echo "   VISUALIZANDO LOGS DEL ENTORNO DOCKER"
echo "========================================"
echo

# Verificar si Docker está ejecutándose
if ! docker version >/dev/null 2>&1; then
    echo "ERROR: Docker no está ejecutándose."
    exit 1
fi

echo "Mostrando logs en tiempo real..."
echo "Presiona Ctrl+C para salir"
echo

docker-compose logs -f

