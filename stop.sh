#!/bin/bash

echo "========================================"
echo "   DETENIENDO ENTORNO DOCKER PHP 5.6"
echo "========================================"
echo

# Verificar si Docker está ejecutándose
if ! docker version >/dev/null 2>&1; then
    echo "ERROR: Docker no está ejecutándose."
    exit 1
fi

echo "Deteniendo contenedores..."
docker-compose down

if [ $? -eq 0 ]; then
    echo
    echo "========================================"
    echo "   ENTORNO DETENIDO CORRECTAMENTE"
    echo "========================================"
    echo
    echo "Los contenedores han sido detenidos."
    echo "Los datos de MySQL se mantienen guardados."
    echo
    echo "Para volver a iniciar, ejecuta: ./start.sh"
else
    echo
    echo "ERROR: No se pudo detener el entorno correctamente."
    echo "Intenta con: docker-compose down --remove-orphans"
    exit 1
fi

echo

