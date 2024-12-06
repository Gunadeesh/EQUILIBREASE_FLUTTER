<?php
// Allow cross-origin requests
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Include the config.php file for database connection
include 'config.php';

// Fetch patient details
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Check if patientId is provided
    if (isset($_GET['patientId']) && !empty($_GET['patientId'])) {
        $patientId = $_GET['patientId'];

        // SQL query to fetch patient details by patient ID
        $query = "SELECT * FROM patients WHERE patientId = ?";
        $stmt = $conn->prepare($query);

        if ($stmt) {
            $stmt->bind_param('s', $patientId);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                $patient = $result->fetch_assoc();

                // Adjust image path to form correct URL
                $patient['image_path'] = 'http://' . $_SERVER['HTTP_HOST'] . '/equilibrease/uploads/' . basename($patient['image_path']);

                echo json_encode(['success' => true, 'patient' => $patient]);
            } else {
                echo json_encode(['success' => false, 'message' => 'Patient not found']);
            }

            $stmt->close();
        } else {
            echo json_encode(['success' => false, 'message' => 'Failed to prepare statement']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'No patientId provided']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
}

// Close connection
$conn->close();
?>
