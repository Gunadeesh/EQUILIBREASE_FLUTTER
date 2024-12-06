<?php
header("Content-Type: application/json");

// Include database connection
include('config.php');

// Retrieve patientId from the GET request
$patientId = $_GET['patientId'];

// Prepare SQL query to count notifications with status = 1 for the given patientId
$sql = "SELECT COUNT(*) AS count FROM doctorreplies WHERE patientId = ? AND reply_sent = 1";
$stmt = $conn->prepare($sql);

// Bind parameters and execute the statement
$stmt->bind_param("s", $patientId);
$stmt->execute();

// Get the result and fetch the count
$result = $stmt->get_result();
$row = $result->fetch_assoc();

// Encode the count as JSON and send the response
echo json_encode(array("count" => $row['count']));

// Close the statement and connection
$stmt->close();
$conn->close();
?>
