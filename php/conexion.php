<?php
$servername = "localhost"; // Dirección del servidor
$username = "root"; // Nombre de usuario de MySQL (predeterminado en XAMPP)
$password = ""; // Contraseña de MySQL (deja en blanco si no tiene)
$dbname = "vaccination_db"; // Reemplaza con el nombre de tu base de datos

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}
?>
