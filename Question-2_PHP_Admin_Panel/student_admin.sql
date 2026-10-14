-- Database schema for Question 2: Student Admin Panel
CREATE DATABASE IF NOT EXISTS student_admin;
USE student_admin;

-- Stores the basic details of each student
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    roll_number VARCHAR(30) NOT NULL UNIQUE,
    email VARCHAR(100),
    course VARCHAR(100) NOT NULL
);

-- Stores file metadata and links each file to a student
CREATE TABLE IF NOT EXISTS student_files (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    file_type VARCHAR(100) NOT NULL,
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    original_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(id)
        ON DELETE CASCADE
);

-- Sample Data
INSERT INTO students (name, roll_number, email, course) VALUES
('Bhavisha S', '24CS031', 'bhavisha@gmail.com', 'Web Technologies'),
('Rahul Sharma', '24CS012', 'rahul@example.com', 'Computer Science Engineering'),
('Priya Patel', '24IT005', 'priya@example.com', 'Information Technology')
ON DUPLICATE KEY UPDATE name=VALUES(name);
