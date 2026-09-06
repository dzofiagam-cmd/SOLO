<?php

header('Content-Type: application/json; charset=utf-8');
$config = is_file(__DIR__ . '/config.php') ? require __DIR__ . '/config.php' : array();
header('Access-Control-Allow-Origin: ' . (isset($config['cors_origin']) ? $config['cors_origin'] : '*'));
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

function respond($data, $status = 200)
{
    http_response_code($status);
    echo json_encode(array('data' => $data), JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

function fail($message, $status)
{
    http_response_code($status);
    echo json_encode(array('error' => array('message' => $message)), JSON_UNESCAPED_UNICODE);
    exit;
}

function setupFail($code, $message)
{
    http_response_code(503);
    echo json_encode(array(
        'error' => array(
            'code'    => $code,
            'message' => $message,
        ),
    ), JSON_UNESCAPED_UNICODE);
    exit;
}

function integerParam($name, $required = false)
{
    $value = isset($_GET[$name]) ? $_GET[$name] : null;
    if ($value === null || $value === '') {
        if ($required) fail("Parameter '{$name}' diperlukan.", 400);
        return null;
    }
    if (filter_var($value, FILTER_VALIDATE_INT) === false || (int) $value < 1) {
        fail("Parameter '{$name}' harus integer positif.", 400);
    }
    return (int) $value;
}

function coordinate($name)
{
    $value = isset($_GET[$name]) ? $_GET[$name] : null;
    if ($value === null || $value === '') return null;
    if (!is_numeric($value) || !is_finite((float) $value)) fail("Parameter '{$name}' harus numerik.", 400);
    $number = (float) $value;
    if ($name === 'origin_lat' && ($number < -90 || $number > 90)) fail('origin_lat harus -90 hingga 90.', 400);
    if ($name === 'origin_lng' && ($number < -180 || $number > 180)) fail('origin_lng harus -180 hingga 180.', 400);
    return $number;
}

try {
    require __DIR__ . '/db.php';
    $path = parse_url(isset($_SERVER['REQUEST_URI']) ? $_SERVER['REQUEST_URI'] : '', PHP_URL_PATH);
    if (!$path) $path = '';
    $path = preg_replace('#^.*/api(?:/index\.php)?#', '', $path);
    $path = trim($path, '/');
    if ($_SERVER['REQUEST_METHOD'] !== 'GET') fail('Method not allowed.', 405);

    if ($path === 'health') {
        try {
            db()->query('SELECT 1')->fetchColumn();
            $tables = db()->query("SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name IN ('destinations', 'transport_modes', 'routes')")->fetchColumn();
            if ((int) $tables !== 3) {
                setupFail('schema_missing', 'Schema belum lengkap.');
            }
            respond(array('status' => 'ok', 'database' => 'connected', 'schema' => 'ready'));
        } catch (PDOException $error) {
            error_log('RuteSolo health database error: ' . $error->getMessage());
            setupFail('database_unavailable', 'Koneksi database gagal.');
        }
    }

    if ($path === 'destinations') {
        $rows = db()->query('SELECT id, name, category, description, tags, latitude, longitude, image_url FROM destinations ORDER BY id')->fetchAll();
        foreach ($rows as &$row) {
            $row['id']        = (int)   $row['id'];
            $row['latitude']  = (float) $row['latitude'];
            $row['longitude'] = (float) $row['longitude'];
            $row['tags']      = $row['tags'] === null ? array() : json_decode($row['tags'], true);
        }
        respond($rows);
    }

    if ($path === 'modes') {
        $rows = db()->query('SELECT id, slug, name, icon, color FROM transport_modes ORDER BY id')->fetchAll();
        foreach ($rows as &$row) $row['id'] = (int) $row['id'];
        respond($rows);
    }

    if ($path === 'routes') {
        $destinationId = integerParam('destination_id');
        $modeId        = integerParam('mode_id');
        $lat           = coordinate('origin_lat');
        $lng           = coordinate('origin_lng');
        if (($lat === null) !== ($lng === null)) fail('origin_lat dan origin_lng harus disediakan bersama.', 400);
        $sql    = 'SELECT r.id, r.destination_id, d.name AS destination_name, r.mode_id, m.slug AS mode, m.name AS mode_name, r.description, r.fare, r.duration_minutes, d.latitude, d.longitude FROM routes r JOIN destinations d ON d.id=r.destination_id JOIN transport_modes m ON m.id=r.mode_id WHERE 1=1';
        $params = array();
        if ($destinationId !== null) { $sql .= ' AND r.destination_id = :destination_id'; $params['destination_id'] = $destinationId; }
        if ($modeId        !== null) { $sql .= ' AND r.mode_id = :mode_id';               $params['mode_id']        = $modeId; }
        if ($lat !== null) {
            $sql .= ' ORDER BY (6371 * ACOS(LEAST(1, GREATEST(-1, COS(RADIANS(:lat1))*COS(RADIANS(d.latitude))*COS(RADIANS(d.longitude)-RADIANS(:lng))*1+SIN(RADIANS(:lat2))*SIN(RADIANS(d.latitude)))))) ASC, r.duration_minutes ASC';
            $params['lat1'] = $lat;
            $params['lat2'] = $lat;
            $params['lng']  = $lng;
        } else {
            $sql .= ' ORDER BY r.destination_id, r.duration_minutes';
        }
        $stmt = db()->prepare($sql);
        $stmt->execute($params);
        $rows = $stmt->fetchAll();
        foreach ($rows as &$row) {
            $row['id']               = (int)   $row['id'];
            $row['destination_id']   = (int)   $row['destination_id'];
            $row['mode_id']          = (int)   $row['mode_id'];
            $row['duration_minutes'] = (int)   $row['duration_minutes'];
            $row['latitude']         = (float) $row['latitude'];
            $row['longitude']        = (float) $row['longitude'];
        }
        respond($rows);
    }

    fail('Endpoint not found.', 404);

} catch (PDOException $error) {
    error_log('RuteSolo API database error: ' . $error->getMessage());
    setupFail('database_unavailable', 'Database tidak tersedia.');
} catch (Exception $error) {
    error_log('RuteSolo API runtime error: ' . $error->getMessage());
    fail('Internal server error.', 500);
}
