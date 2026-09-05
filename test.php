<?php
echo '<h1>PHP is working!</h1>';
echo '<p>PHP version: ' . phpversion() . '</p>';
echo '<p>PDO MySQL: ' . (extension_loaded('pdo_mysql') ? 'YES' : 'NO') . '</p>';
echo '<p>JSON: ' . (function_exists('json_encode') ? 'YES' : 'NO') . '</p>';

$host = 'sql309.infinityfree.com';
$user = 'if0_42777612';
$pass = 'Itecnom3';
$name = 'if0_42777612_rutesolo';

try {
    $pdo = new PDO('mysql:host=' . $host . ';dbname=' . $name . ';charset=utf8mb4', $user, $pass);
    echo '<p style="color:green"><b>DB: CONNECTED</b></p>';
    $tables = $pdo->query('SHOW TABLES')->fetchAll(PDO::FETCH_COLUMN);
    echo '<p>Tables: ' . (count($tables) ? implode(', ', $tables) : 'none - please import schema.sql') . '</p>';
} catch (Exception $e) {
    echo '<p style="color:red"><b>DB FAILED:</b> ' . htmlspecialchars($e->getMessage()) . '</p>';
}
