<?php
// Allow cross-origin requests
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// MySQL database credentials
include 'config.php';
// Fetch patient details
$sql = "SELECT patientId, name, sex, image_path FROM patients";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $patients = array();
    while($row = $result->fetch_assoc()) {
        // Adjust image_path to form correct URL
        $row['image_path'] = 'http://' . $_SERVER['HTTP_HOST'] . '/equilibrease/uploads/' . basename($row['image_path']);
        $patients[] = $row;
    }
    echo json_encode(array("success" => true, "patients" => $patients));
} else {
    echo json_encode(array("success" => false, "message" => "No patients found"));
}

// Close connection
$conn->close();
?>
