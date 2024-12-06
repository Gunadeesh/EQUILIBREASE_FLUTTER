<?php
// Allow cross-origin requests
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Include config.php for the database connection
include 'config.php';

// Get the input data
$input = json_decode(file_get_contents('php://input'), true);

$patientId = $input['patientId'];
$feedbackId = $input['feedbackId'];
$imagePath = $input['image'];
$patientName = $input['patientName'];
$gender = $input['gender'];
$videoId = $input['videoId'];
$videoTitle = $input['videoTitle'];
$selectedFeedback = $input['selectedFeedback'];
$difficultyText = $input['difficulty'];
$patientComment = $input['patientComment'];
$doctorReply = $input['doctorReply'];
$status = $input['status'];  // Ensure this is properly sent from React Native

// Validate input
if (empty($patientId) || empty($feedbackId) || empty($doctorReply)) {
    echo json_encode(array('success' => false, 'message' => 'Invalid input'));
    exit();
}

// Prepare and bind for inserting/updating doctor replies
$checkStatusStmt = $conn->prepare("SELECT status FROM feedback WHERE feedback_id = ? AND patientId = ?");
$checkStatusStmt->bind_param("is", $feedbackId, $patientId);
$checkStatusStmt->execute();
$checkStatusResult = $checkStatusStmt->get_result();
$currentStatus = $checkStatusResult->fetch_assoc();

if ($currentStatus['status'] == 1) {
    echo json_encode(array('success' => false, 'message' => 'Reply Status :Already Sent.'));
    exit();
}

// Prepare and bind for inserting/updating doctor replies
$stmt = $conn->prepare("
    INSERT INTO doctorreplies 
    (patientId, name, gender, image_path, video_id, video_title, selected_feedback, difficulty_text, patient_comment, doctor_reply, status, reply_sent) 
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) 
    ON DUPLICATE KEY UPDATE 
    name = VALUES(name), 
    gender = VALUES(gender), 
    image_path = VALUES(image_path), 
    video_id = VALUES(video_id), 
    video_title = VALUES(video_title), 
    selected_feedback = VALUES(selected_feedback), 
    difficulty_text = VALUES(difficulty_text), 
    patient_comment = VALUES(patient_comment), 
    doctor_reply = VALUES(doctor_reply), 
    status = VALUES(status), 
    reply_sent = VALUES(reply_sent), 
    reply_timestamp = CURRENT_TIMESTAMP
");

$stmt->bind_param(
    "ssssssssssii", 
    $patientId, 
    $patientName, 
    $gender, 
    $imagePath, 
    $videoId, 
    $videoTitle, 
    $selectedFeedback, 
    $difficultyText, 
    $patientComment, 
    $doctorReply, 
    $status,
    $replySent
);

// Set reply_sent to 1 if reply is being sent

$replySent = 1;

if ($stmt->execute()) {
    // Only update feedback status if it was previously not set to 1
    if ($currentStatus['status'] == 0) {
        $updateStmt = $conn->prepare("UPDATE feedback SET status = 1 WHERE feedback_id = ? AND patientId = ?");
        $updateStmt->bind_param("is", $feedbackId, $patientId);
        $updateStmt->execute();
        $updateStmt->close();
    }
    echo json_encode(array('success' => true, 'message' => 'Reply and status updated successfully'));
} else {
    echo json_encode(array('success' => false, 'message' => 'Failed to execute query: ' . $stmt->error));
}

$stmt->close();
$conn->close();