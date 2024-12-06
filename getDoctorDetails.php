<?php
  include 'config.php'; // Include database connection

  if (isset($_GET['doctor_ID'])) {
    $doctor_ID = $_GET['doctor_ID'];

    $query = "SELECT * FROM doctors WHERE doctor_ID = '$doctor_ID'";
    $result = mysqli_query($conn, $query);

    if (mysqli_num_rows($result) > 0) {
      $doctor = mysqli_fetch_assoc($result);
      echo json_encode($doctor);
    } else {
      echo json_encode(['error' => 'Doctor not found']);
    }
  }
?>
