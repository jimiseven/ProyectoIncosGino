<?php
// Conexión a la base de datos
include 'php/conexion.php'; // Asegúrate de que este archivo contenga los datos correctos de conexión

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

?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Lista de Niños</title>
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="css/bootstrap.min.css" />
  <link rel="stylesheet" href="styles.css">
</head>

<body>
  <div class="container mt-5">
    <!-- Barra de búsqueda -->
    <div class="d-flex justify-content-end mb-3">
      <nav class="navbar navbar-light bg-light">
        <form class="form-inline" id="searchForm">
          <input class="form-control mr-sm-2" type="search" placeholder="Buscar por nombre" aria-label="Search" id="searchInput">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Buscar</button>
        </form>
      </nav>
    </div>

    <!-- Tabla de niños -->
    <table class="table">
      <thead class="thead-dark">
        <tr>
          <th scope="col">Nombre Completo</th>
          <th scope="col">Edad en Meses</th>
        </tr>
      </thead>
      <tbody id="tableBody">
        <?php
        if ($result->num_rows > 0) {
            // Iterar a través de los resultados y llenar la tabla
            while($row = $result->fetch_assoc()) {
                $nombreCompleto = $row['first_name'] . ' ' . $row['last_name_father'] . ' ' . $row['last_name_mother'];
                $edadEnMeses = calcularEdadEnMeses($row['birth_date']);
                echo "<tr>
                        <th scope='row'>$nombreCompleto</th>
                        <td>$edadEnMeses</td>
                      </tr>";
            }
        } else {
            echo "<tr><td colspan='2'>No se encontraron registros</td></tr>";
        }
        ?>
      </tbody>
    </table>
  </div>

  <!-- Cerrar la conexión a la base de datos -->
  <?php $conn->close(); ?>

  <!-- Bootstrap JS and dependencies -->
  <script src="js/jquery.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/bootstrap.bundle.min.js"></script>

  <!-- Script para búsqueda -->
  <script>
    document.getElementById('searchForm').addEventListener('submit', function(event) {
      event.preventDefault();
      var searchInput = document.getElementById('searchInput').value.toLowerCase();
      var tableRows = document.querySelectorAll('#tableBody tr');
      
      tableRows.forEach(function(row) {
        var rowData = row.querySelector('th').textContent.toLowerCase();
        if (rowData.includes(searchInput)) {
          row.style.display = '';
        } else {
          row.style.display = 'none';
        }
      });
    });
  </script>
</body>

</html>
