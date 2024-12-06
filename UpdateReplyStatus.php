<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

// Include your config file for database connection
include('config.php');

// Get POST data
file_put_contents('php://stderr', print_r(json_encode(["success" => true]), TRUE)); // Log response to server error log


$patientId = $_POST['patientId'] ?? '';
$video_id = $_POST['video_id'] ?? '';
$reply_timestamp = $_POST['reply_timestamp'] ?? '';

if (empty($patientId) || empty($video_id) || empty($reply_timestamp)) {
    echo json_encode(["success" => false, "error" => "Missing required parameters."]);
    exit;
}

$conn->begin_transaction();

try {
    // Update query for doctor_replies table
    $sql = "UPDATE doctorreplies 
            SET reply_sent = 2 
            WHERE patientId = ? 
              AND video_id = ? 
              AND reply_timestamp = ?";
    
    $stmt = $conn->prepare($sql);
    if ($stmt === false) {
        throw new Exception("Error preparing SQL statement: " . $conn->error);
    }
    
    $stmt->bind_param("sss", $patientId, $video_id, $reply_timestamp);

    if (!$stmt->execute()) {
        throw new Exception("Error updating doctor_replies table: " . $stmt->error);
    }
    
    // Commit the transaction
    $conn->commit();
    
    echo json_encode(["success" => true]);
} catch (Exception $e) {
    // Rollback the transaction on error
    $conn->rollback();
    echo json_encode(["success" => false, "error" => $e->getMessage()]);
    error_log("Error: " . $e->getMessage()); // Log error to server log
} finally {
    // Close the statement and connection
    if (isset($stmt) && $stmt !== false) {
        $stmt->close();
    }
    $conn->close();
}
?>
