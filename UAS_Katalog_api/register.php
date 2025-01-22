<?php
// Menambahkan header CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// Database connection details
$host = 'teknologi22.xyz';
$username = 'teky6584_api_nadhif';
$password = 'RbU^?w*}JH&C';
$dbname = 'teky6584_api_nadhif';

// Membuat koneksi ke database
$conn = new mysqli($host, $username, $password, $dbname);

// Memeriksa apakah koneksi berhasil
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Connection failed: " . $conn->connect_error]));
}

// Memeriksa apakah data form sudah dikirim
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Menangkap data dari form
    $username = isset($_POST['username']) ? trim($_POST['username']) : '';
    $password = isset($_POST['password']) ? trim($_POST['password']) : '';

    // Melakukan validasi (optional)
    if (empty($username) || empty($password)) {
        echo json_encode(["status" => "error", "message" => "All fields are required."]);
        exit();
    }

    // Hash password sebelum disimpan
    $hashedPassword = password_hash($password, PASSWORD_BCRYPT);

    try {
        // Menyusun query untuk menyimpan data
        $sql = "INSERT INTO users (username, password) VALUES (?, ?)";
        
        // Menyiapkan statement
        $stmt = $conn->prepare($sql);
        
        // Bind parameter
        $stmt->bind_param("ss", $username, $hashedPassword);

        // Menjalankan query
        if ($stmt->execute()) {
            // Memberikan respons jika berhasil
            echo json_encode(["status" => "success", "message" => "Registration successful!"]);
        } else {
            // Menampilkan error jika query gagal
            echo json_encode(["status" => "error", "message" => "Error: " . $stmt->error]);
        }

        // Menutup statement
        $stmt->close();
    } catch (Exception $e) {
        // Menampilkan pesan error jika terjadi kesalahan
        echo json_encode(["status" => "error", "message" => "Error: " . $e->getMessage()]);
    }
}

// Menutup koneksi
$conn->close();
?>
