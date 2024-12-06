<?php
// Allow cross-origin requests
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Include the config file for database connection
include 'config.php';

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(array("success" => false, "message" => "Method not allowed"));
    exit();
}

// Check if all required form-data fields are present
if (
    isset($_POST['name']) && 
    isset($_POST['age']) && 
    isset($_POST['sex']) && 
    isset($_POST['patientId']) && 
    isset($_POST['password']) && 
    isset($_POST['occupation']) && 
    isset($_POST['diagnosis']) && 
    isset($_POST['comorbidities']) && 
    isset($_POST['investigations']) && 
    isset($_POST['examination']) && 
    isset($_POST['medications']) && 
    isset($_FILES['image']) && $_FILES['image']['error'] === UPLOAD_ERR_OK
) {
    // Escape user inputs for security (prevent SQL injection)
    $name = htmlspecialchars(strip_tags($_POST['name']));
    $age = htmlspecialchars(strip_tags($_POST['age']));
    $sex = htmlspecialchars(strip_tags($_POST['sex']));
    $patientId = htmlspecialchars(strip_tags($_POST['patientId']));
    $password = htmlspecialchars(strip_tags($_POST['password'])); // Store the password as plain text
    $occupation = htmlspecialchars(strip_tags($_POST['occupation']));
    $diagnosis = htmlspecialchars(strip_tags($_POST['diagnosis']));
    $comorbidities = htmlspecialchars(strip_tags($_POST['comorbidities']));
    $investigations = htmlspecialchars(strip_tags($_POST['investigations']));
    $examination = htmlspecialchars(strip_tags($_POST['examination']));
    $medications = htmlspecialchars(strip_tags($_POST['medications']));

    // Handle file upload
    $target_dir = "C:/xampp/htdocs/equilibrease/uploads/";

    // Generate a unique name for the file
    $unique_name = uniqid() . '_' . time();
    $imageFileType = strtolower(pathinfo($_FILES["image"]["name"], PATHINFO_EXTENSION));
    $target_file = $target_dir . $unique_name . '.' . $imageFileType;

    // Check if file is an image
    $check = getimagesize($_FILES["image"]["tmp_name"]);
    if ($check === false) {
        echo json_encode(array("success" => false, "message" => "File is not an image."));
        exit();
    }

    // Allow certain file formats (add more as necessary)
    if (!in_array($imageFileType, array("jpg", "jpeg", "png"))) {
        echo json_encode(array("success" => false, "message" => "Sorry, only JPG, JPEG, and PNG files are allowed."));
        exit();
    }

    // Move the uploaded file to the target directory
    if (!move_uploaded_file($_FILES["image"]["tmp_name"], $target_file)) {
        echo json_encode(array("success" => false, "message" => "Sorry, there was an error uploading your file."));
        exit();
    }

    // Prepare SQL statement with prepared statement
    $stmt = $conn->prepare("INSERT INTO patients (name, age, sex, patientId, password, occupation, diagnosis, comorbidities, investigations, examination, medications, image_path) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

    // Bind parameters to the SQL statement
    $stmt->bind_param("sissssssssss", $name, $age, $sex, $patientId, $password, $occupation, $diagnosis, $comorbidities, $investigations, $examination, $medications, $target_file);

    // Execute the SQL statement
    if ($stmt->execute()) {
        // Data inserted successfully
        $response = array("success" => true);
    } else {
        // Error inserting data
        $response = array("success" => false, "message" => "Error: " . $stmt->error);
    }

    // Close prepared statement and database connection
    $stmt->close();
    $conn->close();

} else {
    // Incomplete data or missing image file
    $response = array("success" => false, "message" => "No image file uploaded or error in upload.");
}

// Return JSON response to client
echo json_encode($response);
?>
