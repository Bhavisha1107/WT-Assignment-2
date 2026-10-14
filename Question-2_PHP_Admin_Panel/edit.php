<?php
require "db.php";

// Get the student ID from the URL
$id = filter_input(INPUT_GET, "id", FILTER_VALIDATE_INT);
if (!$id) {
    die("Invalid student ID.");
}

// Fetch the existing student record
$stmt = $pdo->prepare("SELECT * FROM students WHERE id = ?");
$stmt->execute([$id]);
$student = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$student) {
    die("Student not found.");
}

$error = "";

// Update the record after form submission
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $name = trim($_POST["name"] ?? "");
    $roll = trim($_POST["roll_number"] ?? "");
    $email = trim($_POST["email"] ?? "");
    $course = trim($_POST["course"] ?? "");

    // Validate the submitted details
    if ($name === "" || $roll === "" || $course === "") {
        $error = "Name, roll number and course are required.";
    } elseif ($email !== "" && !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error = "Enter a valid email address.";
    } else {
        try {
            // Update the existing student using a prepared statement
            $stmt = $pdo->prepare(
                "UPDATE students
                 SET name = ?, roll_number = ?, email = ?, course = ?
                 WHERE id = ?"
            );
            $stmt->execute([$name, $roll, $email, $course, $id]);

            // Return to the updated student's details
            header("Location: view.php?id=" . $id);
            exit;
        } catch (PDOException $e) {
            $error = $e->getCode() === "23000"
                ? "This roll number is already in use."
                : "Unable to update student.";
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Student - Admin Panel</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="admin-container form-card">
        <div class="admin-header">
            <h2>Edit Student Details</h2>
            <a href="index.php" class="btn btn-secondary btn-sm">&larr; Back to List</a>
        </div>

        <?php if ($error !== ""): ?>
            <div class="alert-error"><?= e($error) ?></div>
        <?php endif; ?>

        <!-- Pre-fill the form with the existing student information -->
        <form method="post">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name"
                       value="<?= e($student["name"]) ?>" required>
            </div>

            <div class="form-group">
                <label for="roll_number">Roll Number:</label>
                <input type="text" id="roll_number" name="roll_number"
                       value="<?= e($student["roll_number"]) ?>" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email"
                       value="<?= e($student["email"]) ?>">
            </div>

            <div class="form-group">
                <label for="course">Course:</label>
                <input type="text" id="course" name="course"
                       value="<?= e($student["course"]) ?>" required>
            </div>

            <button type="submit" class="btn btn-primary" style="width:100%; margin-top: 10px;">Update Student</button>
        </form>
    </div>
</body>
</html>
