<?php
// ─────────────────────────────────────────────────────────
//  AI Agent PHP API  —  Place this in: C:/xampp/htdocs/agent.php
// ─────────────────────────────────────────────────────────

// Allow CORS (needed for local requests)
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

// ── Database Config ──────────────────────────────────────
$servername = "localhost";
$username   = "root";
$password   = "";          // XAMPP default has no password
$dbname     = "ai_agent";  // We use "ai_agent" as DB name
// ─────────────────────────────────────────────────────────

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(["error" => "DB connection failed: " . $conn->connect_error]);
    exit();
}

$action = isset($_GET['action']) ? $_GET['action'] : "";

switch ($action) {

    // ── ACTION 1: Get all students ────────────────────────
    case "get_students":
        $sql    = "SELECT * FROM students ORDER BY total_marks DESC";
        $result = $conn->query($sql);
        $data   = [];
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
        echo json_encode($data);
        break;

    // ── ACTION 2: Search by name ──────────────────────────
    case "search":
        $name   = isset($_GET['name']) ? $conn->real_escape_string($_GET['name']) : "";
        $sql    = "SELECT * FROM students WHERE name LIKE '%$name%'";
        $result = $conn->query($sql);
        $data   = [];
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
        if (empty($data)) {
            echo json_encode(["message" => "No student found with name: $name"]);
        } else {
            echo json_encode($data);
        }
        break;

    // ── ACTION 3: Top N students ──────────────────────────
    case "top":
        $limit  = isset($_GET['limit']) ? intval($_GET['limit']) : 5;
        $sql    = "SELECT * FROM students ORDER BY total_marks DESC LIMIT $limit";
        $result = $conn->query($sql);
        $data   = [];
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
        echo json_encode($data);
        break;

    // ── ACTION 4: Class summary / stats ───────────────────
    case "summary":
        $sql    = "SELECT 
                    COUNT(*) AS total_students,
                    ROUND(AVG(total_marks), 2) AS class_average,
                    MAX(total_marks) AS highest_marks,
                    MIN(total_marks) AS lowest_marks,
                    SUM(CASE WHEN total_marks >= 150 THEN 1 ELSE 0 END) AS passed,
                    SUM(CASE WHEN total_marks < 150 THEN 1 ELSE 0 END) AS failed
                   FROM students";
        $result = $conn->query($sql);
        $data   = $result->fetch_assoc();
        echo json_encode($data);
        break;

    // ── DEFAULT: Unknown action ───────────────────────────
    default:
        echo json_encode(["error" => "Invalid action. Use: get_students, search, top, summary"]);
}

$conn->close();
?>