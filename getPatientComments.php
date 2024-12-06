<?php
header('Content-Type: application/json');

// Database connection
include 'config.php';

// Fetch all feedback where status = 0
$sql = "SELECT * FROM feedback WHERE status = 0";
$result = $conn->query($sql);

$comments = array();
while ($row = $result->fetch_assoc()) {
    $comments[] = $row;
}

echo json_encode(array('success' => true, 'comments' => $comments));

$conn->close();
?>
