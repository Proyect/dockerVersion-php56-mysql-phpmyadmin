<?php
// Página de prueba para verificar que PHP 5.6 funciona correctamente
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP 5.6 + MySQL + phpMyAdmin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .info-box {
            background: #e8f4f8;
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
            border-left: 4px solid #2196F3;
        }
        .success {
            color: #4CAF50;
            font-weight: bold;
        }
        .link {
            display: inline-block;
            background: #2196F3;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin: 5px;
        }
        .link:hover {
            background: #1976D2;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🐳 Entorno Docker PHP 5.6 + MySQL + phpMyAdmin</h1>
        
        <div class="info-box">
            <h2>✅ Estado del Sistema</h2>
            <p><strong>PHP Version:</strong> <?php echo phpversion(); ?></p>
            <p><strong>Servidor:</strong> <?php echo $_SERVER['SERVER_SOFTWARE']; ?></p>
            <p><strong>Fecha/Hora:</strong> <?php echo date('Y-m-d H:i:s'); ?></p>
        </div>

        <div class="info-box">
            <h2>🔧 Extensiones PHP Cargadas</h2>
            <table>
                <tr>
                    <th>Extensión</th>
                    <th>Estado</th>
                </tr>
                <?php
                $extensions = ['mysqli', 'pdo_mysql', 'gd', 'zip', 'curl', 'json', 'mbstring', 'xml', 'xsl', 'intl', 'mcrypt'];
                foreach ($extensions as $ext) {
                    $status = extension_loaded($ext) ? '✅ Cargada' : '❌ No disponible';
                    echo "<tr><td>{$ext}</td><td>{$status}</td></tr>";
                }
                ?>
            </table>
        </div>

        <div class="info-box">
            <h2>🗄️ Conexión a MySQL</h2>
            <?php
            $host = 'mysql';
            $dbname = 'php_app';
            $username = 'php_user';
            $password = 'php_password123';
            
            try {
                $pdo = new PDO("mysql:host={$host};dbname={$dbname}", $username, $password);
                $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                echo '<p class="success">✅ Conexión a MySQL exitosa</p>';
                
                // Mostrar información de la base de datos
                $stmt = $pdo->query("SELECT VERSION() as version");
                $version = $stmt->fetch(PDO::FETCH_ASSOC);
                echo "<p><strong>MySQL Version:</strong> {$version['version']}</p>";
                
            } catch(PDOException $e) {
                echo '<p style="color: red;">❌ Error de conexión: ' . $e->getMessage() . '</p>';
            }
            ?>
        </div>

        <div class="info-box">
            <h2>🔗 Enlaces Útiles</h2>
            <a href="http://localhost:8081" class="link" target="_blank">📊 phpMyAdmin</a>
            <a href="phpinfo.php" class="link">ℹ️ phpinfo()</a>
        </div>

        <div class="info-box">
            <h2>📝 Información del Sistema</h2>
            <table>
                <tr>
                    <th>Configuración</th>
                    <th>Valor</th>
                </tr>
                <tr>
                    <td>Memory Limit</td>
                    <td><?php echo ini_get('memory_limit'); ?></td>
                </tr>
                <tr>
                    <td>Max Execution Time</td>
                    <td><?php echo ini_get('max_execution_time'); ?> segundos</td>
                </tr>
                <tr>
                    <td>Upload Max Filesize</td>
                    <td><?php echo ini_get('upload_max_filesize'); ?></td>
                </tr>
                <tr>
                    <td>Post Max Size</td>
                    <td><?php echo ini_get('post_max_size'); ?></td>
                </tr>
                <tr>
                    <td>Timezone</td>
                    <td><?php echo date_default_timezone_get(); ?></td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>

