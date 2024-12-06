<?php
// Allow cross-origin requests
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Include the configuration file for database connection
include 'config.php';

// Fetch feedback count where status is 0
$query = "SELECT COUNT(*) as count FROM feedback WHERE status = 0";
$result = $conn->query($query);

// Check if query was successful
if ($result) {
    $row = $result->fetch_assoc();
    $count = $row['count'];

    // Return the count as JSON
    echo json_encode(array("success" => true, "count" => $count));
} else {
    // Return error response
    echo json_encode(array("success" => false, "message" => "Error fetching feedback count"));
}

// Close connection
$conn->close();
?>
