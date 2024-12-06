<?php   
// Allow cross-origin requests
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Include the config file for database connection
include 'config.php';

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(array("success" => false, "message" => "Method not allowed"));
    exit();
}

// Get POST data and ensure it's safe to use in SQL queries
$doctor_ID = $conn->real_escape_string($_POST['doctor_ID']);
$name = $conn->real_escape_string($_POST['name']);
$password = $conn->real_escape_string($_POST['password']);

// Check if doctor_ID starts with 'DBZ'
if (substr($doctor_ID, 0, 3) !== 'DBZ') {
    echo json_encode(array("success" => false, "message" => "Only authorized doctors can add records."));
    exit();
}

// Insert data into the doctors table
$sql = "INSERT INTO doctors (doctor_ID, name, password) VALUES ('$doctor_ID', '$name', '$password')";

$response = array();
if ($conn->query($sql) === TRUE) {
    $response['success'] = true;
} else {
    $response['success'] = false;
    $response['error'] = $conn->error; // Return error message for debugging
}

// Return response in JSON format
echo json_encode($response);

// Close the database connection
$conn->close();
?>
