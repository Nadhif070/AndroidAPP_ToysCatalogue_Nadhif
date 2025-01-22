<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");

$conn = new mysqli('teknologi22.xyz', 'teky6584_api_nadhif', 'RbU^?w*}JH&C', 'teky6584_api_nadhif');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Cek login untuk admin
    $queryAdmin = "SELECT * FROM admin WHERE username = '$username' AND password = '$password'";
    $resultAdmin = $conn->query($queryAdmin);

    if ($resultAdmin->num_rows > 0) {
        // Jika login berhasil sebagai admin
        echo json_encode(["status" => "success", "message" => "Login admin berhasil"]);
    } else {
        // Cek login untuk user biasa
        $queryUser = "SELECT * FROM users WHERE username = '$username'";
        $resultUser = $conn->query($queryUser);

        if ($resultUser->num_rows > 0) {
            // Jika username ditemukan, verifikasi password
            $user = $resultUser->fetch_assoc();
            if (password_verify($password, $user['password'])) {
                // Jika password cocok
                echo json_encode(["status" => "success", "message" => "Login user berhasil"]);
            } else {
                // Jika password tidak cocok
                echo json_encode(["status" => "error", "message" => "Invalid password"]);
            }
        } else {
            // Jika username tidak ditemukan di tabel users
            echo json_encode(["status" => "error", "message" => "Invalid username"]);
        }
    }
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request method"]);
}

$conn->close();
?>
