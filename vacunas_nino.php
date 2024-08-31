<?php
// Conexión a la base de datos
include 'php/conexion.php';

// Obtener el id del niño desde la URL
$idNino = isset($_GET['id']) ? intval($_GET['id']) : 0;

// Consulta SQL para obtener los datos del niño y sus vacunas
$sqlNino = "SELECT first_name, last_name_father, last_name_mother FROM children WHERE id = $idNino";
$resultNino = $conn->query($sqlNino);

$sqlVacunas = "SELECT v.name, vac.dose_number, vac.administration_date, vac.next_dose_date, vac.status
               FROM vaccinations vac
               JOIN vaccines v ON vac.vaccine_id = v.id
               WHERE vac.child_id = $idNino";
$resultVacunas = $conn->query($sqlVacunas);

// Verificar si se encontró el niño
if ($resultNino->num_rows > 0) {
    $nino = $resultNino->fetch_assoc();
    $nombreCompleto = $nino['first_name'] . ' ' . $nino['last_name_father'] . ' ' . $nino['last_name_mother'];
} else {
    echo "Niño no encontrado";
    exit;
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vacunas de <?php echo $nombreCompleto; ?></title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="styles.css">
</head>

<body>
    <div class="container mt-5">
        <h2>Vacunas de <?php echo $nombreCompleto; ?></h2>
        <table class="table">
            <thead class="thead-dark">
                <tr>
                    <th scope="col">Vacuna</th>
                    <th scope="col">Número de Dosis</th>
                    <th scope="col">Fecha de Administración</th>
                    <th scope="col">Próxima Dosis</th>
                    <th scope="col">Estado</th>
                </tr>
            </thead>
            <tbody>
                <?php
                if ($resultVacunas->num_rows > 0) {
                    // Iterar a través de los resultados y llenar la tabla
                    while ($row = $resultVacunas->fetch_assoc()) {
                        echo "<tr>
                    <td>{$row['name']}</td>
                    <td>{$row['dose_number']}</td>
                    <td>{$row['administration_date']}</td>
                    <td>{$row['next_dose_date']}</td>
                    <td>{$row['status']}</td>
                  </tr>";
                    }
                } else {
                    echo "<tr><td colspan='5'>No se encontraron vacunas para este niño</td></tr>";
                }
                ?>
            </tbody>
        </table>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="js/jquery.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
</body>

</html>