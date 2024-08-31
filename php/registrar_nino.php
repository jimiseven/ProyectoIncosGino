<?php
include 'conexion.php'; // Incluye el archivo de conexión a la base de datos

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Recibir datos del formulario
    $nombresNino = $_POST['nombresNino'];
    $apellidoPaternoNino = $_POST['apellidoPaternoNino'];
    $apellidoMaternoNino = $_POST['apellidoMaternoNino'];
    $fechaNacimientoNino = $_POST['fechaNacimientoNino'];
    $certificadoNacimientoNino = $_POST['certificadoNacimientoNino'];
    $ciNino = $_POST['ciNino'];
    $fechaRegistroNino = $_POST['fechaRegistroNino'];
    $ciResponsable = $_POST['ciResponsable'];
    $nombresResponsable = $_POST['nombresResponsable'];
    $apellidoPaternoResponsable = $_POST['apellidoPaternoResponsable'];
    $apellidoMaternoResponsable = $_POST['apellidoMaternoResponsable'];
    $celularResponsable = $_POST['celularResponsable'];
    $parentescoResponsable = $_POST['parentescoResponsable'];

    // Insertar datos en la tabla children
    $sql = "INSERT INTO children (first_name, last_name_father, last_name_mother, birth_date, birth_certificate_number, identity_card_number, registration_date, guardian_first_name, guardian_last_name_father, guardian_last_name_mother, guardian_identity_card_number, guardian_relationship, guardian_phone_number) 
            VALUES ('$nombresNino', '$apellidoPaternoNino', '$apellidoMaternoNino', '$fechaNacimientoNino', '$certificadoNacimientoNino', '$ciNino', '$fechaRegistroNino', '$nombresResponsable', '$apellidoPaternoResponsable', '$apellidoMaternoResponsable', '$ciResponsable', '$parentescoResponsable', '$celularResponsable')";

    if ($conn->query($sql) === TRUE) {
        echo "Registro exitoso";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    // Cerrar la conexión
    $conn->close();
}
?>
