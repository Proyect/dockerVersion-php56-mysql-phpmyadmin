#!/bin/bash

echo "========================================"
echo "   CONFIGURAR BACKUP AUTOMATICO LINUX"
echo "========================================"
echo

# Verificar si el usuario tiene permisos de sudo
if ! sudo -n true 2>/dev/null; then
    echo "ERROR: Este script requiere permisos de sudo."
    echo "Ejecuta: sudo ./setup-backup-linux.sh"
    exit 1
fi

echo "Configurando cron job para backup diario..."
echo

# Obtener la ruta completa del script
script_path="$(pwd)/backup-daily.sh"

# Hacer el script ejecutable
chmod +x "$script_path"

# Crear la entrada del cron job (todos los días a las 2:00 AM)
cron_entry="0 2 * * * $script_path"

# Agregar al crontab
(crontab -l 2>/dev/null; echo "$cron_entry") | crontab -

if [ $? -eq 0 ]; then
    echo "========================================"
    echo "   CRON JOB CONFIGURADO EXITOSAMENTE"
    echo "========================================"
    echo
    echo "El backup se ejecutará todos los días a las 2:00 AM"
    echo
    echo "Para ver los cron jobs activos:"
    echo "crontab -l"
    echo
    echo "Para eliminar el cron job:"
    echo "crontab -e  # y elimina la línea del backup"
    echo
    echo "Para probar el backup manualmente:"
    echo "./backup-daily.sh"
    echo
    echo "Para ver los logs del backup:"
    echo "tail -f backups/backup.log"
else
    echo "ERROR: No se pudo configurar el cron job."
    exit 1
fi

echo

