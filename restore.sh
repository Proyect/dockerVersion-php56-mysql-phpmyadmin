#!/bin/bash

echo "========================================"
echo "   RESTAURAR BACKUP DE LA BASE DE DATOS"
echo "========================================"
echo

# Verificar si Docker está ejecutándose
if ! docker version >/dev/null 2>&1; then
    echo "ERROR: Docker no está ejecutándose."
    exit 1
fi

# Verificar que existe el directorio de backups
if [ ! -d "backups" ]; then
    echo "ERROR: No existe el directorio de backups."
    echo "Ejecuta primero: ./backup.sh"
    exit 1
fi

# Mostrar backups disponibles
echo "Backups disponibles:"
echo
ls -la backups/mysql_backup_*.sql 2>/dev/null
if [ $? -ne 0 ]; then
    echo "No se encontraron backups."
    exit 1
fi

echo
read -p "Ingresa el nombre del archivo de backup (sin ruta): " backup_file
if [ -z "$backup_file" ]; then
    echo "ERROR: No se especificó archivo de backup."
    exit 1
fi

# Verificar que el archivo existe
if [ ! -f "backups/$backup_file" ]; then
    echo "ERROR: El archivo backups/$backup_file no existe."
    exit 1
fi

echo
echo "ADVERTENCIA: Esta acción eliminará TODOS los datos actuales"
echo "y los reemplazará con los datos del backup."
echo

read -p "¿Estás seguro? (s/N): " confirm
if [[ ! "$confirm" =~ ^[Ss]$ ]]; then
    echo "Operación cancelada."
    exit 0
fi

echo
echo "Verificando que MySQL esté ejecutándose..."
if ! docker-compose ps mysql | grep -q "Up"; then
    echo "ERROR: El contenedor MySQL no está ejecutándose."
    echo "Inicia el entorno con: ./start.sh"
    exit 1
fi

echo
echo "Restaurando backup: $backup_file"
echo "Esto puede tomar varios minutos..."
echo

# Restaurar el backup
docker-compose exec -T mysql mysql -u root -prootpassword123 < "backups/$backup_file"

if [ $? -eq 0 ]; then
    echo
    echo "========================================"
    echo "   BACKUP RESTAURADO EXITOSAMENTE"
    echo "========================================"
    echo
    echo "La base de datos ha sido restaurada desde: $backup_file"
    echo
    echo "Puedes verificar los datos en: http://localhost:8081"
else
    echo
    echo "ERROR: No se pudo restaurar el backup."
    echo "Verifica que el archivo no esté corrupto."
    exit 1
fi

echo

