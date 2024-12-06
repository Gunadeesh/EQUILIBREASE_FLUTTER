<?php
include 'config.php';

// Check if patientId is set in the GET request
if (isset($_GET['patientId'])) {
    $patientId = $_GET['patientId'];

    // Update the column name to match your database schema
    $query = "SELECT f.feedback_id, f.video_id, f.selected_feedback, f.difficulty_text, v.title
              FROM feedback f
              LEFT JOIN videos v ON f.video_id = v.video_id
              WHERE f.patientId = ?" ;
    
    if ($stmt = $conn->prepare($query)) {
        $stmt->bind_param('s', $patientId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $data = array();
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
        
        echo json_encode($data);
    } else {
        echo json_encode(['error' => 'Failed to prepare the SQL statement.']);
    }
} else {
    echo json_encode(['error' => 'patientId is not set in the GET request.']);
}
?>
