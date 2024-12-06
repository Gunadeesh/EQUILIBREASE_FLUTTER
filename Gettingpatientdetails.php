<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Include config.php for database connection
include 'config.php';

// Retrieve patientId from the request (supports both GET and POST)
$input = json_decode(file_get_contents("php://input"), true);
$patientId = $input['patientId'] ?? $_GET['patientId'] ?? '';

// Initialize response array
$response = array();

if (!empty($patientId)) {
    // Prepare the SQL statement to fetch patient details
    $stmt = $conn->prepare("SELECT * FROM patients WHERE patientId = ?");
    $stmt->bind_param("s", $patientId);

    if ($stmt->execute()) {
        $result = $stmt->get_result();
        if ($result->num_rows > 0) {
            $patient = $result->fetch_assoc();

            // Construct the full URL for the image path
            $imageUrl = 'http://' . $_SERVER['HTTP_HOST'] . '/equilibrease/uploads/' . basename($patient['image_path']);

            $response['success'] = true;
            $response['patient'] = array(
                'name' => $patient['name'],
                'patientId' => $patient['patientId'],
                'image_path' => $imageUrl,
                'age' => $patient['age'],
                'sex' => $patient['sex'],
                'occupation' => $patient['occupation'],
                'diagnosis' => $patient['diagnosis'],
                'comorbidities' => $patient['comorbidities'],
                'investigations' => $patient['investigations'],
                'examination' => $patient['examination'],
                'medications' => $patient['medications'],
            );
        } else {
            $response['success'] = false;
            $response['message'] = 'Patient not found';
        }
    } else {
        $response['success'] = false;
        $response['message'] = 'Error executing query';
    }

    $stmt->close();
} else {
    $response['success'] = false;
    $response['message'] = 'Invalid patient ID';
}

// Close connection
$conn->close();

// Return the response as JSON
echo json_encode($response);
?>
