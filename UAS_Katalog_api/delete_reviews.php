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

// Mendapatkan data dari permintaan
$data = json_decode(file_get_contents("php://input"), true);

$username = $data['username'];
$rating = $data['rating'];

// Validasi data
if (empty($username) || empty($rating)) {
    echo json_encode(["status" => "error", "message" => "Username and rating are required."]);
    $conn->close();
    exit;
}

// Menghapus review berdasarkan username dan rating
$sql = "DELETE FROM reviews WHERE username = ? AND rating = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("si", $username, $rating);

if ($stmt->execute()) {
    echo json_encode(["status" => "success", "message" => "Review deleted successfully."]);
} else {
    echo json_encode(["status" => "error", "message" => "Failed to delete review."]);
}

$stmt->close();
$conn->close();
?>
