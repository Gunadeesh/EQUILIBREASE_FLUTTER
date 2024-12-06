<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

header("Content-Type: application/json");
include('config.php');

$patientId = $_GET['patientId'];

$sql = "SELECT patientId, name, gender, image_path, video_id, video_title, selected_feedback, difficulty_text, patient_comment, doctor_reply, reply_timestamp, status, reply_sent 
        FROM doctorreplies 
        WHERE patientId = ? AND reply_sent = 1";

$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $patientId);
$stmt->execute();
$result = $stmt->get_result();

$notifications = [];
while ($row = $result->fetch_assoc()) {
    $notifications[] = $row;
}

echo json_encode(array("notifications" => $notifications));

$stmt->close();
$conn->close();
?>
