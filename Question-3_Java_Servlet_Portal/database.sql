-- Database schema and mock data for Question 3: Student Profile Portal
CREATE DATABASE IF NOT EXISTS student_portal;
USE student_portal;

CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    roll_number VARCHAR(30) NOT NULL,
    course VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS student_files (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    file_type VARCHAR(100) NOT NULL,
    original_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (student_id)
        REFERENCES students(id)
        ON DELETE CASCADE
);

-- Insert sample records
INSERT INTO students (id, name, roll_number, course)
VALUES
    (1, 'Bhavisha S', '24CS031', 'Computer Science Engineering'),
    (2, 'Rahul Sharma', 'ST001', 'Computer Science'),
    (3, 'Priya Patel', 'ST002', 'Information Technology')
ON DUPLICATE KEY UPDATE name=VALUES(name);

INSERT INTO student_files
    (id, student_id, file_path, file_type, original_name)
VALUES
    (1, 1, 'bhavisha.jpg', 'image/jpeg', 'bhavisha_photo.jpg'),
    (2, 1, 'bhavisha_certificate.pdf', 'application/pdf', 'Marksheet_Semester_1.pdf'),
    (3, 2, 'rahul.jpg', 'image/jpeg', 'rahul.jpg'),
    (4, 3, 'priya.png', 'image/png', 'priya.png')
ON DUPLICATE KEY UPDATE file_path=VALUES(file_path);
