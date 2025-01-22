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

// Ambil data JSON dari request
$data = json_decode(file_get_contents('php://input'), true);

if (isset($data['id'], $data['name'], $data['image'], $data['price'])) {
    $id = $data['id'];
    $name = $data['name'];
    $image = $data['image'];
    $price = $data['price'];

    // Query untuk mengupdate data mainan
    $query = "UPDATE available_toys SET name = ?, image = ?, price = ? WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("ssii", $name, $image, $price, $id);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Toy updated successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to update toy"]);
    }

    $stmt->close();
} else {
    echo json_encode(["status" => "error", "message" => "Invalid input"]);
}

$conn->close();
?>
