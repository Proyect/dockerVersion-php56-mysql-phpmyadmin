#!/bin/bash
# Script de backup automático diario
# Este script se ejecuta automáticamente una vez al día

# Cambiar al directorio del proyecto
cd "$(dirname "$0")"

# Crear directorio de backups si no existe
mkdir -p backups

# Obtener fecha para el nombre del archivo
backup_file="backups/mysql_backup_daily_$(date +%Y-%m-%d).sql"

# Verificar que el contenedor MySQL esté ejecutándose
if ! docker-compose ps mysql | grep -q "Up"; then
    echo "$(date): ERROR: MySQL no está ejecutándose" >> backups/backup.log
    exit 1
fi

# Crear el backup
docker-compose exec -T mysql mysqldump -u root -prootpassword123 --all-databases --routines --triggers > "$backup_file" 2>> backups/backup.log

if [ $? -eq 0 ]; then
    echo "$(date): Backup exitoso: $backup_file" >> backups/backup.log
    
    # Comprimir el backup para ahorrar espacio
    gzip "$backup_file"
    if [ $? -eq 0 ]; then
        echo "$(date): Backup comprimido: ${backup_file}.gz" >> backups/backup.log
    fi
else
    echo "$(date): ERROR: Fallo en backup" >> backups/backup.log
fi

# Limpiar backups antiguos (mantener solo 7 días)
find backups -name "mysql_backup_daily_*.sql.gz" -mtime +7 -delete 2>/dev/null
find backups -name "mysql_backup_daily_*.sql" -mtime +7 -delete 2>/dev/null

