<?php
header('Content-Type: application/json');

// Include config.php for database connection
include 'config.php';

// Retrieve patient details from the JSON POST request
$input = json_decode(file_get_contents('php://input'), true);
$patientId = isset($input['patientId']) ? $input['patientId'] : '';
$name = isset($input['name']) ? $input['name'] : '';
$age = isset($input['age']) ? $input['age'] : '';

$response = array();

if (!empty($patientId) && !empty($name) && !empty($age)) {
    // Prepare the SQL statement to update patient details
    $stmt = $conn->prepare("UPDATE patients SET name = ?, age = ? WHERE patientId = ?");
    $stmt->bind_param("sis", $name, $age, $patientId);

    if ($stmt->execute()) {
        $response['success'] = true;
        $response['message'] = 'Patient details updated successfully';
    } else {
        $response['success'] = false;
        $response['message'] = 'Error executing query';
    }

    $stmt->close();
} else {
    $response['success'] = false;
    $response['message'] = 'Invalid input data';
}

// Close connection
$conn->close();

// Return the response as JSON
echo json_encode($response);
?>
