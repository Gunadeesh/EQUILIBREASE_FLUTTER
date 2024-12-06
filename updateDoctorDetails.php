<?php
  include 'config.php'; // Include database connection

  include 'config.php'; // Include database connection

  if ($_SERVER['REQUEST_METHOD'] == 'POST') {
      // Read JSON input
      $data = json_decode(file_get_contents('php://input'), true);
  
      $doctor_ID = isset($data['doctor_ID']) ? $data['doctor_ID'] : null;
      $name = isset($data['name']) ? $data['name'] : null;
      $password = isset($data['password']) ? $data['password'] : null;
  
      if ($doctor_ID && $name && $password) {
          // Sanitize and escape inputs
          $doctor_ID = mysqli_real_escape_string($conn, $doctor_ID);
          $name = mysqli_real_escape_string($conn, $name);
          $password = mysqli_real_escape_string($conn, $password);
  
          // Update query
          $query = "UPDATE doctors SET name='$name', password='$password' WHERE doctor_ID='$doctor_ID'";
  
          if (mysqli_query($conn, $query)) {
              echo json_encode(['success' => 'Doctor details updated successfully']);
          } else {
              echo json_encode(['error' => 'Failed to update doctor details', 'mysqli_error' => mysqli_error($conn)]);
          }
      } else {
          echo json_encode(['error' => 'Required data missing']);
      }
  } else {
      echo json_encode(['error' => 'Invalid request method']);
  }
  $data = json_decode(file_get_contents('php://input'), true);
error_log(print_r($data, true)); // Log the received data

  