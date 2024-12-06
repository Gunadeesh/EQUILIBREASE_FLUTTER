<?php
// Include the config.php file to reuse the database connection
include 'config.php';

// Start session
session_start();

// Fetching login credentials
if ($_SERVER["REQUEST_METHOD"] == "GET" && isset($_GET['doctor_ID']) && isset($_GET['password'])) {
    $doctor_ID = $conn->real_escape_string($_GET['doctor_ID']);
    $password = $conn->real_escape_string($_GET['password']);

    // Prepare statement for enhanced security (avoid SQL injection)
    $stmt = $conn->prepare("SELECT * FROM doctors WHERE doctor_ID = ? AND password = ?");
    $stmt->bind_param("ss", $doctor_ID, $password);

    // Execute query
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // Login successful
        // Fetch doctor details based on doctor_ID
        $sql = "SELECT name FROM doctors WHERE doctor_ID = ?";
        $stmt_details = $conn->prepare($sql);
        $stmt_details->bind_param("s", $doctor_ID);
        $stmt_details->execute();
        $result_details = $stmt_details->get_result();

        if ($result_details->num_rows > 0) {
            // Fetching data from the result set
            $row = $result_details->fetch_assoc();
            $doctorName = $row['name'];

            // Set session variables
            $_SESSION['doctor_ID'] = $doctor_ID;
            $_SESSION['doctorName'] = $doctorName;

            // Prepare JSON response
            $response = array(
                'success' => true,
                'doctor_ID' => $doctor_ID,
                'doctorName' => $doctorName
            );

            // Output as JSON
            header('Content-Type: application/json');
            echo json_encode($response);
        } else {
            // Handle case where doctor details are not found
            echo json_encode(array('error' => 'Doctor details not found'));
        }

        // Close statement
        $stmt_details->close();
    } else {
        // Login failed
        echo json_encode(array('error' => 'Invalid Doctor ID or Password'));
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
