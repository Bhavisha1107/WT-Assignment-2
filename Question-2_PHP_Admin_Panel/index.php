<?php
require "db.php";
// Retrieve all students from the database
$stmt = $pdo->query("SELECT * FROM students ORDER BY id DESC");
$students = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Admin Panel</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="admin-container">
        <div class="admin-header">
            <div>
                <h1>Student Admin Panel</h1>
                <p style="color: #64748b; font-size: 14px;">Manage student admission records and documents</p>
            </div>
            <!-- Navigate to the page for adding a student -->
            <a href="add.php" class="btn btn-primary">+ Add New Student</a>
        </div>

        <div class="table-wrapper">
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Roll Number</th>
                        <th>Email</th>
                        <th>Course</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (count($students) === 0): ?>
                        <tr>
                            <td colspan="5" style="text-align:center; padding: 20px; color:#64748b;">No student records found. Click "Add New Student" to begin.</td>
                        </tr>
                    <?php else: ?>
                        <?php foreach ($students as $student): ?>
                        <tr>
                            <td><strong><?= e($student["name"]) ?></strong></td>
                            <td><?= e($student["roll_number"]) ?></td>
                            <td><?= e($student["email"]) ?></td>
                            <td><?= e($student["course"]) ?></td>
                            <td class="action-links">
                                <!-- Open the selected student's details -->
                                <a href="view.php?id=<?= (int)$student["id"] ?>">View</a>
                                <!-- Open the edit form -->
                                <a href="edit.php?id=<?= (int)$student["id"] ?>">Edit</a>
                                <!-- Delete using POST rather than a GET link -->
                                <form action="delete.php" method="post"
                                      style="display:inline"
                                      onsubmit="return confirm('Delete this student?')">
                                    <input type="hidden" name="id"
                                           value="<?= (int)$student["id"] ?>">
                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                </form>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
