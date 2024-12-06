<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include 'config.php';

$sql = "
    SELECT 
        p.patientId, 
        p.name, 
        p.age, 
        p.sex,
        p.image_path, 
        GROUP_CONCAT(f.video_id) AS videos,  -- Concatenate multiple video IDs
        CASE 
            WHEN f.video_id IS NOT NULL THEN 'Yes' 
            ELSE 'No' 
        END as query 
    FROM patients p
    INNER JOIN feedback f ON p.patientId = f.patientId
    GROUP BY p.patientId
";

$result = $conn->query($sql);

$patients = [];
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $row['image_path'] = 'http://' . $_SERVER['HTTP_HOST'] . '/equilibrease/uploads/' . basename($row['image_path']);
        $patients[] = $row;
    }
    echo json_encode(array("success" => true, "patients" => $patients));
} else {
    echo json_encode(array("success" => false, "message" => "No patients found"));
}

$conn->close();
?>
