#!/bin/bash

echo "========================================"
echo "   CREANDO BACKUP DE LA BASE DE DATOS"
echo "========================================"
echo

# Verificar si Docker está ejecutándose
if ! docker version >/dev/null 2>&1; then
    echo "ERROR: Docker no está ejecutándose."
    exit 1
fi

# Crear directorio de backups si no existe
if [ ! -d "backups" ]; then
    echo "Creando directorio de backups..."
    mkdir -p backups
fi

# Obtener fecha y hora para el nombre del archivo
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
backup_file="backups/mysql_backup_${timestamp}.sql"

echo "Creando backup: $backup_file"
echo

# Verificar que el contenedor MySQL esté ejecutándose
if ! docker-compose ps mysql | grep -q "Up"; then
    echo "ERROR: El contenedor MySQL no está ejecutándose."
    echo "Inicia el entorno con: ./start.sh"
    exit 1
fi

# Crear el backup
echo "Ejecutando mysqldump..."
docker-compose exec -T mysql mysqldump -u root -prootpassword123 --all-databases --routines --triggers > "$backup_file"

if [ $? -eq 0 ]; then
    echo
    echo "========================================"
    echo "   BACKUP CREADO EXITOSAMENTE"
    echo "========================================"
    echo
    echo "Archivo: $backup_file"
    echo "Tamaño: $(du -h "$backup_file" | cut -f1)"
    echo
    echo "Para restaurar este backup, usa: ./restore.sh"
else
    echo
    echo "ERROR: No se pudo crear el backup."
    echo "Verifica que MySQL esté funcionando correctamente."
    exit 1
fi

echo

