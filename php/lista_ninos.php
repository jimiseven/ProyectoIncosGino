<?php
// Conexión a la base de datos
include 'conexion.php'; // Asegúrate de que este archivo contenga los datos correctos de conexión

// Consulta SQL para obtener los datos de los niños
$sql = "SELECT first_name, last_name_father, last_name_mother, birth_date FROM children";
$result = $conn->query($sql);

// Función para calcular la edad en meses
function calcularEdadEnMeses($fechaNacimiento) {
    $fechaActual = new DateTime();
    $fechaNacimiento = new DateTime($fechaNacimiento);
    $diferencia = $fechaActual->diff($fechaNacimiento);
    return ($diferencia->y * 12) + $diferencia->m;
}

// Generar las filas de la tabla
$tablaFilas = '';

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $nombreCompleto = $row['first_name'] . ' ' . $row['last_name_father'] . ' ' . $row['last_name_mother'];
        $edadEnMeses = calcularEdadEnMeses($row['birth_date']);
        $tablaFilas .= "<tr>
                          <th scope='row'>$nombreCompleto</th>
                          <td>$edadEnMeses</td>
                        </tr>";
    }
} else {
    $tablaFilas = "<tr><td colspan='2'>No se encontraron registros</td></tr>";
}

// Cerrar la conexión a la base de datos
$conn->close();

// Imprimir las filas de la tabla
echo $tablaFilas;
?>
