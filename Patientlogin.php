<?php
// Include config.php for the database connection
include 'config.php';

// Start session
session_start();

// Fetching login credentials
if ($_SERVER["REQUEST_METHOD"] == "GET" && isset($_GET['patientId']) && isset($_GET['password'])) {
    $patientId = $conn->real_escape_string($_GET['patientId']);
    $password = $conn->real_escape_string($_GET['password']);

    // Prepare statement for enhanced security (avoid SQL injection)
    $stmt = $conn->prepare("SELECT * FROM patients WHERE patientId = ? AND password = ?");
    $stmt->bind_param("ss", $patientId, $password);

    // Execute query
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // Login successful
        // Fetch patient details based on patientId
        $sql = "SELECT name FROM patients WHERE patientId = ?";
        $stmt_details = $conn->prepare($sql);
        $stmt_details->bind_param("s", $patientId);
        $stmt_details->execute();
        $result_details = $stmt_details->get_result();

        if ($result_details->num_rows > 0) {
            // Fetching data from the result set
            $row = $result_details->fetch_assoc();
            $patientName = $row['name'];

            // Set session variables
            $_SESSION['patientId'] = $patientId;
            $_SESSION['patientName'] = $patientName;

            // Prepare JSON response
            $response = array(
                'success' => true,
                'patientId' => $patientId,
                'patientName' => $patientName
            );

            // Output as JSON
            header('Content-Type: application/json');
            echo json_encode($response);
        } else {
            // Handle case where patient details are not found
            echo json_encode(array('error' => 'Patient details not found'));
        }

        // Close statement
        $stmt_details->close();
    } else {
        // Login failed
        echo json_encode(array('error' => 'Invalid credentials'));
    }

    // Close statement
    $stmt->close();
} else {
    // Invalid request
    http_response_code(400); // Bad Request
    echo json_encode(array('error' => 'Invalid request'));
}

// Close connection
$conn->close();
?>
