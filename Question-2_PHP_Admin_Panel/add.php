<?php
require "db.php";
$error = "";

// Process the form when the user submits it
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $name = trim($_POST["name"] ?? "");
    $roll = trim($_POST["roll_number"] ?? "");
    $email = trim($_POST["email"] ?? "");
    $course = trim($_POST["course"] ?? "");

    // Validate required fields and email format
    if ($name === "" || $roll === "" || $course === "") {
        $error = "Name, roll number and course are required.";
    } elseif ($email !== "" && !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error = "Enter a valid email address.";
    } else {
        try {
            // Prepared statements prevent SQL injection
            $stmt = $pdo->prepare(
                "INSERT INTO students (name, roll_number, email, course)
                 VALUES (?, ?, ?, ?)"
            );
            $stmt->execute([$name, $roll, $email, $course]);

            // Redirect to the upload page for the new student
            header("Location: upload.php?id=" . $pdo->lastInsertId());
            exit;
        } catch (PDOException $e) {
            // Handle duplicate roll numbers and other database errors
            $error = $e->getCode() === "23000"
                ? "This roll number already exists."
                : "Unable to add student.";
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student - Admin Panel</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="admin-container form-card">
        <div class="admin-header">
            <h2>Add New Student</h2>
            <a href="index.php" class="btn btn-secondary btn-sm">&larr; Back to List</a>
        </div>

        <!-- Display validation or database errors -->
        <?php if ($error !== ""): ?>
            <div class="alert-error"><?= e($error) ?></div>
        <?php endif; ?>

        <form method="post">
            <div class="form-group">
                <label for="name">Full Name *</label>
                <input type="text" id="name" name="name" required placeholder="e.g. Bhavisha S">
            </div>

            <div class="form-group">
                <label for="roll_number">Roll Number *</label>
                <input type="text" id="roll_number" name="roll_number" required placeholder="e.g. 24CS031">
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="e.g. bhavisha@gmail.com">
            </div>

            <div class="form-group">
                <label for="course">Course *</label>
                <input type="text" id="course" name="course" required placeholder="e.g. Web Technologies">
            </div>

            <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 10px;">Add Student & Proceed to Upload</button>
        </form>
    </div>
</body>
</html>
