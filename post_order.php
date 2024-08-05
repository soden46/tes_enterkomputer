<?php
header('Content-Type: application/json');

// Database configuration
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

// Fungsi untuk mengambil Printer produk
function getPrintersForProduct($productId, $pdo)
{
    try {
        $stmt = $pdo->prepare("SELECT p.nama FROM printer_produk pp JOIN printer p ON pp.id_printer = p.id WHERE pp.id_produk = ?");
        $stmt->execute([$productId]);
        return $stmt->fetchAll(PDO::FETCH_COLUMN);
    } catch (PDOException $e) {
        throw new Exception('Error fetching printers: ' . $e->getMessage());
    }
}

// Handle POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);

    $tableNumber = $data['nomor_meja'];
    $items = $data['item'];

    if (!$tableNumber || !is_array($items)) {
        http_response_code(400);
        echo json_encode(['error' => 'Invalid input']);
        exit;
    }

    try {
        $pdo->beginTransaction();

        // Insert order
        $stmt = $pdo->prepare("INSERT INTO pesanan (nomor_meja) VALUES (?)");
        $stmt->execute([$tableNumber]);
        $orderId = $pdo->lastInsertId();

        $printers = [];
        $billDetails = [];

        foreach ($items as $item) {
            $productId = $item['id_produk'];
            $quantity = $item['quantity'];

            // Insert order item
            $stmt = $pdo->prepare("INSERT INTO item_pesanan (id_pesanan, id_produk, quantity) VALUES (?, ?, ?)");
            $stmt->execute([$orderId, $productId, $quantity]);

            // Get product details
            $stmt = $pdo->prepare("SELECT nama, harga FROM produk WHERE id = ?");
            $stmt->execute([$productId]);
            $product = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($product) {
                $subtotal = $product['harga'] * $quantity;
                $billDetails[] = [
                    'nama_produk' => $product['nama'],
                    'quantity' => $quantity,
                    'harga' => $product['harga'],
                    'subtotal' => $subtotal,
                ];

                // Mengambil printer
                $productPrinters = getPrintersForProduct($productId, $pdo);
                foreach ($productPrinters as $printer) {
                    if (!in_array($printer, $printers)) {
                        $printers[] = $printer;
                    }
                }
            }
        }

        $total = array_sum(array_column($billDetails, 'subtotal'));

        // Insert payment details
        $stmt = $pdo->prepare("INSERT INTO pembayaran (id_pesanan, id_produk, quantity) VALUES (?, ?, ?)");
        foreach ($items as $item) {
            $stmt->execute([$orderId, $item['id_produk'], $item['quantity']]);
        }

        $pdo->commit();

        echo json_encode([
            'id_order' => $orderId,
            'print_stations' => $printers,
        ]);
    } catch (Exception $e) {
        $pdo->rollBack();
        http_response_code(500);
        echo json_encode(['error' => 'Server error: ' . $e->getMessage()]);
    }
}
