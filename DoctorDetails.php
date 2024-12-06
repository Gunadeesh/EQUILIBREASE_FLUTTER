<?php
header('Content-Type: application/json');
include 'config.php';

// Check if doctorId is passed
if (isset($_GET['doctorId'])) {
    $doctorId = $_GET['doctorId'];

    // Prepare SQL statement to fetch doctor's details
    if ($stmt = $conn->prepare("SELECT doctor_ID, name, password FROM doctors WHERE doctor_ID = ?")) {
        $stmt->bind_param("s", $doctorId);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            // Fetch the doctor's details
            $doctor = $result->fetch_assoc();
            echo json_encode(['success' => true, 'doctor' => $doctor]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Doctor not found']);
        }

        $stmt->close();
    } else {
        echo json_encode(['success' => false, 'message' => 'Error preparing statement']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'No doctorId provided']);
}

$conn->close();
?>
