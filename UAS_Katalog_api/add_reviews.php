<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");

// Koneksi ke database
$conn = new mysqli('teknologi22.xyz', 'teky6584_api_nadhif', 'RbU^?w*}JH&C', 'teky6584_api_nadhif');

// Cek koneksi
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Connection failed: " . $conn->connect_error]));
}

// Mengambil data dari request POST
$username = isset($_POST['username']) ? $_POST['username'] : '';
$rating = isset($_POST['rating']) ? $_POST['rating'] : 0;
$review = isset($_POST['review']) ? $_POST['review'] : '';

// Validasi input
if (empty($username) || $rating < 1 || $rating > 5 || empty($review)) {
    echo json_encode(["status" => "error", "message" => "All fields are required and rating must be between 1 and 5"]);
    exit();
}

// Menyimpan review ke database
$sql = "INSERT INTO reviews (username, rating, review) VALUES (?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("sis", $username, $rating, $review);

if ($stmt->execute()) {
    echo json_encode(["status" => "success", "message" => "Review added successfully!"]);
} else {
    echo json_encode(["status" => "error", "message" => "Error: " . $stmt->error]);
}

$stmt->close();
$conn->close();
?>
