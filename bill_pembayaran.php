<?php
header('Content-Type: application/json');

$host = 'localhost';
$db = 'data';
$user = 'root';
$pass = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database connection failed: ' . $e->getMessage()]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $orderId = $_GET['id_order'];

    if (!$orderId) {
        http_response_code(400);
        echo json_encode(['error' => 'Invalid order ID']);
        exit;
    }

    try {
        // Get order details
        $stmt = $pdo->prepare("
            SELECT p.nama AS nama_produk, ip.quantity, p.harga AS price, (p.harga * ip.quantity) AS subtotal
            FROM item_pesanan ip
            JOIN produk p ON ip.id_produk = p.id
            WHERE ip.id_pesanan = ?
        ");
        $stmt->execute([$orderId]);
        $items = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Calculate total
        $total = array_sum(array_column($items, 'subtotal'));

        echo json_encode([
            'id_order' => $orderId,
            'items' => $items,
            'total' => $total
        ]);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Server error: ' . $e->getMessage()]);
    }
}
