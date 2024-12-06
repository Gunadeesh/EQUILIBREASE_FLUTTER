<?php
// Allow cross-origin requests
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Include the configuration file for database connection
include 'config.php';

// Decode JSON data from POST request
$data = json_decode(file_get_contents("php://input"), true);

// Check if the data contains all required fields
if (!isset($data['patientId'], $data['videoId'], $data['selectedFeedback'])) {
    echo json_encode(array("success" => false, "message" => "Missing required fields"));
    exit();
}

// Extract feedback data
$patientId = $data['patientId'];
$videoId = $data['videoId'];
$selectedFeedback = $data['selectedFeedback'];
$havingDifficulties = isset($data['havingDifficulties']) ? $data['havingDifficulties'] : false;
$difficultyText = isset($data['difficultyText']) ? $data['difficultyText'] : '';

// Check if the video exists
$videoCheckStmt = $conn->prepare("SELECT video_id FROM videos WHERE video_id = ?");
$videoCheckStmt->bind_param("s", $videoId);
$videoCheckStmt->execute();
$videoCheckStmt->store_result();

if ($videoCheckStmt->num_rows == 0) {
    // Video does not exist
    echo json_encode(array("success" => false, "message" => "Video does not exist"));
    $videoCheckStmt->close();
    $conn->close();
    exit();
}

$videoCheckStmt->close();

// Prepare SQL statement for inserting feedback
$stmt = $conn->prepare("INSERT INTO feedback (patientId, video_id, selected_feedback, difficulty_text, status) VALUES (?, ?, ?, ?, 0)");
$stmt->bind_param("ssss", $patientId, $videoId, $selectedFeedback, $difficultyText);

// Execute SQL statement
if ($stmt->execute()) {
    // Return success response to Flutter application
    echo json_encode(array("success" => true, "message" => "Feedback successfully submitted"));
} else {
    // Return error response if execution fails
    echo json_encode(array("success" => false, "message" => "Error submitting feedback"));
}

// Close statement and connection
$stmt->close();
$conn->close();
?>
