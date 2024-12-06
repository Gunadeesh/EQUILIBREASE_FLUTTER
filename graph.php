<?php
// Allow cross-origin requests
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Include config.php for the database connection
include 'config.php';

// Fetch all feedback data where selected_feedback is '8 - 10 : Feeling Relieved'
$query = "SELECT video_id, selected_feedback FROM feedback WHERE selected_feedback = '8 - 10 : Feeling Relieved'";
$result = $conn->query($query);

$feedbackData = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $feedbackData[] = $row;
    }
}

// Process feedback data to count 'Feeling Relieved' feedback per video
$videoFeelingRelievedCount = [];
foreach ($feedbackData as $feedback) {
    $videoId = $feedback['video_id'];

    if (!isset($videoFeelingRelievedCount[$videoId])) {
        $videoFeelingRelievedCount[$videoId] = 0;
    }

    // Increment count for '8 - 10 : Feeling Relieved' feedback
    $videoFeelingRelievedCount[$videoId]++;
}

// Find the video(s) with the highest 'Feeling Relieved' count
$maxCount = max($videoFeelingRelievedCount);
$bestVideos = array_keys($videoFeelingRelievedCount, $maxCount);

// Fetch video titles for the best videos
$videoTitles = [];
foreach ($bestVideos as $videoId) {
    $videoQuery = "SELECT title FROM videos WHERE video_id = ?";
    $stmt = $conn->prepare($videoQuery);
    $stmt->bind_param('s', $videoId);
    $stmt->execute();
    $videoResult = $stmt->get_result();
    if ($videoResult->num_rows > 0) {
        $videoTitle = $videoResult->fetch_assoc();
        $videoTitles[$videoId] = $videoTitle['title'];
    }
}

// Return the JSON response with feelingRelievedCount and bestVideoTitles
echo json_encode([
    'success' => true,
    'bestVideoTitles' => array_values($videoTitles), // Array of titles only
    'videoScores' => $videoFeelingRelievedCount // This will now match with JavaScript side
]);

$conn->close();
?>
