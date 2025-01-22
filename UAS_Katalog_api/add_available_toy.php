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

// Ambil data dari request
$data = json_decode(file_get_contents("php://input"), true);

if (!empty($data['name']) && !empty($data['image']) && !empty($data['price'])) {
    $name = $conn->real_escape_string($data['name']);
    $image = $conn->real_escape_string($data['image']);
    $price = $conn->real_escape_string($data['price']);

    $query = "INSERT INTO available_toys (name, image, price) VALUES ('$name', '$image', '$price')";
    if ($conn->query($query)) {
        echo json_encode(["status" => "success", "message" => "Toy added successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to add toy"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Invalid input"]);
}

$conn->close();
?>
