<?php
require "db.php";

// Read and validate the student ID
$id = filter_input(INPUT_GET, "id", FILTER_VALIDATE_INT);
if (!$id) {
    die("Invalid student ID.");
}

// Retrieve the student's details
$stmt = $pdo->prepare("SELECT * FROM students WHERE id = ?");
$stmt->execute([$id]);
$student = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$student) {
    die("Student not found.");
}

// Retrieve all uploaded files linked to this student
$stmt = $pdo->prepare(
    "SELECT * FROM student_files WHERE student_id = ? ORDER BY upload_date DESC"
);
$stmt->execute([$id]);
$files = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Details - <?= e($student["name"]) ?></title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="admin-container">
        <div class="admin-header">
            <h2>Student Details</h2>
            <div>
                <a href="edit.php?id=<?= (int)$id ?>" class="btn btn-primary btn-sm">Edit Student</a>
                <a href="upload.php?id=<?= (int)$id ?>" class="btn btn-secondary btn-sm">+ Upload Document</a>
                <a href="index.php" class="btn btn-secondary btn-sm">&larr; Back to List</a>
            </div>
        </div>

        <div style="background: #f8fafc; border: 1px solid var(--border); border-radius: 8px; padding: 18px; margin-bottom: 24px;">
            <p style="margin-bottom: 8px;"><strong>Name:</strong> <?= e($student["name"]) ?></p>
            <p style="margin-bottom: 8px;"><strong>Roll Number:</strong> <?= e($student["roll_number"]) ?></p>
            <p style="margin-bottom: 8px;"><strong>Email:</strong> <?= e($student["email"]) ?></p>
            <p><strong>Course:</strong> <?= e($student["course"]) ?></p>
        </div>

        <h3>Uploaded Files & Documents</h3>
        <?php if (count($files) > 0): ?>
            <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 16px;">
                <?php foreach ($files as $file): ?>
                    <div class="file-card">
                        <!-- Display an image preview for image files -->
                        <?php if (strpos($file["file_type"], "image/") === 0): ?>
                            <div class="file-preview" style="text-align: center; margin-bottom: 10px;">
                                <img src="<?= e($file["file_path"]) ?>"
                                     alt="Student document"
                                     style="max-width: 100%; max-height: 140px; object-fit: cover;">
                            </div>
                        <?php endif; ?>

                        <!-- Show the original filename and file metadata -->
                        <p style="font-size: 13.5px; margin-bottom: 4px;"><strong>File:</strong> <?= e($file["original_name"]) ?></p>
                        <p style="font-size: 12.5px; color: #64748b; margin-bottom: 4px;"><strong>Type:</strong> <?= e($file["file_type"]) ?></p>
                        <p style="font-size: 12.5px; color: #64748b; margin-bottom: 10px;"><strong>Uploaded:</strong> <?= e($file["upload_date"]) ?></p>

                        <!-- Open or download the uploaded file -->
                        <a href="<?= e($file["file_path"]) ?>" target="_blank"
                           rel="noopener" class="btn btn-secondary btn-sm" style="display:block; text-align:center;">View / Download File</a>
                    </div>
                <?php endforeach; ?>
            </div>
        <?php else: ?>
            <p style="color: #64748b; font-style: italic;">No files uploaded for this student.</p>
        <?php endif; ?>
    </div>
</body>
</html>
