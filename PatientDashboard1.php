<?php
header('Content-Type: application/json');

// Include config.php for database connection
include 'config.php';

// Fetching patient profile data
if ($_SERVER["REQUEST_METHOD"] == "GET" && isset($_GET['patientId'])) {
    $patientId = intval($_GET['patientId']);
    
    error_log("Fetching details for patient ID: " . $patientId);
    
    // Query to fetch patient's name and profile image path
    $sql = "SELECT name, image_path FROM patients WHERE patientId = ?";
    $stmt = $conn->prepare($sql);

    // Bind parameters (assuming patientId is a string)
    $stmt->bind_param("s", $_GET['patientId']);

    // Execute statement
    if ($stmt->execute()) {
        $result = $stmt->get_result();
        
        if ($result->num_rows > 0) {
            // Patient found, fetch data
            $row = $result->fetch_assoc();
            $patientName = $row['name'];
            $imagePath = $row['image_path'];

            // Construct full URL for the image
            $imageUrl = 'http://' . $_SERVER['HTTP_HOST'] . '/equilibrease/uploads/' . basename($imagePath);

            // Prepare JSON response
            $response = array(
                'patientName' => $patientName,
                'patientImage' => $imageUrl
            );

            // Output as JSON
            echo json_encode($response);
        } else {
            // No patient found for the given ID
            echo json_encode(array('error' => 'No patient found for ID: ' . $patientId));
        }
    } else {
        echo json_encode(array('error' => 'Error executing query'));
    }

    // Close statement
    $stmt->close();
} else {
    // Invalid request method or missing patientId parameter
    echo json_encode(array('error' => 'Invalid request'));
}

// Close connection
$conn->close();
?>
