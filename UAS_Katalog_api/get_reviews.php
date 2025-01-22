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

// Mengambil data review dari database
$sql = "SELECT username, rating, review FROM reviews";
$result = $conn->query($sql);

$reviews = [];
while ($row = $result->fetch_assoc()) {
    $reviews[] = $row;
}

echo json_encode(["status" => "success", "data" => $reviews]);

$conn->close();
?>
