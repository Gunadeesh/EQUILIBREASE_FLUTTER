<?php
// Allow cross-origin requests
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Sat, 26 Jul 1997 05:00:00 GMT"); // Date in the past

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Include the config.php file for database connection
include 'config.php';

// Fetch top new users
$sql = "SELECT patientId, name, sex, image_path FROM patients ORDER BY id DESC LIMIT 2"; // Adjust the query to fetch top 2 users
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $newUsers = array();
    while($row = $result->fetch_assoc()) {
        // Adjust image_path to form correct URL
        $row['image_path'] = 'http://' . $_SERVER['HTTP_HOST'] . '/equilibrease/uploads/' . basename($row['image_path']);
        $newUsers[] = $row;
    }
    echo json_encode(array("success" => true, "newUsers" => $newUsers));
} else {
    echo json_encode(array("success" => false, "message" => "No new users found"));
}

// Close connection
$conn->close();
?>
