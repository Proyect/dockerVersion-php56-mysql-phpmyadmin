#!/bin/bash

echo "========================================"
echo "   LIMPIAR BACKUPS ANTIGUOS"
echo "========================================"
echo

# Verificar que existe el directorio de backups
if [ ! -d "backups" ]; then
    echo "ERROR: No existe el directorio de backups."
    exit 1
fi

echo "Backups actuales:"
ls -la backups/mysql_backup_*.sql 2>/dev/null
if [ $? -ne 0 ]; then
    echo "No se encontraron backups."
    exit 1
fi

echo
echo "ADVERTENCIA: Esta acción eliminará backups antiguos"
echo "(más de 7 días) para liberar espacio en disco."
echo

read -p "¿Continuar? (s/N): " confirm
if [[ ! "$confirm" =~ ^[Ss]$ ]]; then
    echo "Operación cancelada."
    exit 0
fi

echo
echo "Eliminando backups antiguos (más de 7 días)..."

# Eliminar backups SQL antiguos
deleted_sql=$(find backups -name "mysql_backup_*.sql" -mtime +7 -delete -print 2>/dev/null | wc -l)
if [ $deleted_sql -gt 0 ]; then
    echo "- $deleted_sql backups SQL antiguos eliminados"
else
    echo "- No se encontraron backups SQL antiguos"
fi

# Eliminar backups GZ antiguos
deleted_gz=$(find backups -name "mysql_backup_*.sql.gz" -mtime +7 -delete -print 2>/dev/null | wc -l)
if [ $deleted_gz -gt 0 ]; then
    echo "- $deleted_gz backups GZ antiguos eliminados"
else
    echo "- No se encontraron backups GZ antiguos"
fi

# Mostrar espacio liberado
echo
echo "Espacio actual en backups:"
du -sh backups 2>/dev/null || echo "No se pudo calcular el espacio"

echo
echo "========================================"
echo "   LIMPIEZA COMPLETADA"
echo "========================================"
echo
echo "Los backups antiguos han sido eliminados."
echo "Se mantienen los backups de los últimos 7 días."
echo
