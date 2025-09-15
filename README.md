# Entorno Docker PHP 5.6 + MySQL + phpMyAdmin

Este proyecto configura un entorno de desarrollo completo con PHP 5.6, MySQL y phpMyAdmin usando Docker.

## 🚀 Características

- **PHP 5.6** con Apache
- **MySQL 5.7** como base de datos
- **phpMyAdmin** para administración de base de datos
- Extensiones PHP incluidas: mysqli, pdo_mysql, gd, zip, curl, json, mbstring, xml, xsl, intl, mcrypt
- Configuración optimizada para desarrollo

## 📋 Requisitos

- Docker
- Docker Compose

## 🛠️ Instalación

### Opción 1: Automática (Recomendada)

**Para Windows:**
```bash
start.bat
```

**Para Linux/Mac:**
```bash
./start.sh
```

### Opción 2: Manual

1. **Clona o descarga este proyecto**

2. **Copia el archivo de variables de entorno:**
   ```bash
   cp env.example .env
   ```

3. **Edita el archivo `.env` con tus configuraciones:**
   ```env
   MYSQL_ROOT_PASSWORD=tu_password_root
   MYSQL_DATABASE=nombre_base_datos
   MYSQL_USER=usuario_mysql
   MYSQL_PASSWORD=password_usuario
   ```

4. **Construye y ejecuta los contenedores:**
   ```bash
   docker-compose up -d --build
   ```

## 🌐 Acceso a los servicios

- **Aplicación PHP:** http://localhost:8080
- **phpMyAdmin:** http://localhost:8081
- **MySQL:** localhost:3306

## 📁 Estructura del proyecto

```
.
├── Dockerfile              # Configuración del contenedor PHP
├── docker-compose.yml      # Orquestación de servicios
├── php.ini                 # Configuración personalizada de PHP
├── env.example            # Variables de entorno de ejemplo
├── README.md              # Este archivo
└── src/                   # Código fuente de tu aplicación PHP
```

## 🔧 Scripts de Automatización

### Scripts Principales

| Script | Windows | Linux/Mac | Descripción |
|--------|---------|-----------|-------------|
| **Iniciar** | `start.bat` | `./start.sh` | Inicia el entorno completo |
| **Detener** | `stop.bat` | `./stop.sh` | Detiene todos los servicios |
| **Reiniciar** | `restart.bat` | `./restart.sh` | Reinicia el entorno |
| **Limpiar** | `clean.bat` | `./clean.sh` | Limpieza completa (elimina datos) |
| **Logs** | `logs.bat` | `./logs.sh` | Ver logs en tiempo real |

### Scripts de Backup

| Script | Windows | Linux/Mac | Descripción |
|--------|---------|-----------|-------------|
| **Backup Manual** | `backup.bat` | `./backup.sh` | Crear backup inmediato |
| **Restaurar** | `restore.bat` | `./restore.sh` | Restaurar desde backup |
| **Backup Diario** | `backup-daily.bat` | `./backup-daily.sh` | Script para backup automático |
| **Configurar Auto** | `setup-backup-windows.bat` | `./setup-backup-linux.sh` | Configurar backup automático |
| **Limpiar Backups** | `clean-backups.bat` | `./clean-backups.sh` | Eliminar backups antiguos |

### Comandos Docker Manuales

### Iniciar los servicios
```bash
docker-compose up -d
```

### Detener los servicios
```bash
docker-compose down
```

### Ver logs
```bash
docker-compose logs -f
```

### Acceder al contenedor PHP
```bash
docker-compose exec php bash
```

### Acceder a MySQL
```bash
docker-compose exec mysql mysql -u root -p
```

### Reconstruir contenedores
```bash
docker-compose up -d --build
```

## 📝 Desarrollo

1. Coloca tu código PHP en la carpeta `src/`
2. Los cambios se reflejarán automáticamente en http://localhost:8080
3. Usa phpMyAdmin en http://localhost:8081 para administrar la base de datos

## 🔐 Credenciales por defecto

- **MySQL Root:** root / rootpassword123
- **Usuario MySQL:** php_user / php_password123
- **Base de datos:** php_app

## 🐛 Solución de problemas

### Puerto ya en uso
Si el puerto 8080 o 8081 están ocupados, modifica los puertos en `docker-compose.yml`:
```yaml
ports:
  - "8082:80"  # Cambia 8080 por 8082
```

### Problemas de permisos
```bash
sudo chown -R $USER:$USER src/
```

### Limpiar volúmenes
```bash
docker-compose down -v
```

## 📚 Extensiones PHP incluidas

- mysqli
- pdo_mysql
- gd
- zip
- curl
- json
- mbstring
- xml
- xsl
- intl
- mcrypt

## 🤝 Contribuir

1. Fork el proyecto
2. Crea una rama para tu feature
3. Commit tus cambios
4. Push a la rama
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT.
