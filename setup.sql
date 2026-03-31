-- ═══════════════════════════════════════════════════════
--  AI AGENT WORKSHOP  —  Database Setup SQL
--  Run this in phpMyAdmin > SQL tab
-- ═══════════════════════════════════════════════════════

-- Step 1: Create the database
CREATE DATABASE IF NOT EXISTS ai_agent;
USE ai_agent;

-- Step 2: Create the students table
CREATE TABLE IF NOT EXISTS students (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(100)  NOT NULL,
    roll_number  VARCHAR(20)   NOT NULL UNIQUE,
    class        VARCHAR(20)   DEFAULT 'SE-AI',
    maths        INT           DEFAULT 0,
    science      INT           DEFAULT 0,
    english      INT           DEFAULT 0,
    programming  INT           DEFAULT 0,
    dbms         INT           DEFAULT 0,
    total_marks  INT           GENERATED ALWAYS AS (maths + science + english + programming + dbms) STORED,
    grade        VARCHAR(5)    DEFAULT 'F',
    created_at   TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
);

-- Step 3: Insert dummy student data (20 students)
INSERT INTO students (name, roll_number, class, maths, science, english, programming, dbms, grade) VALUES
('Rahul Sharma',    'SE001', 'SE-AI', 88, 91, 74, 95, 82, 'A'),
('Priya Patil',     'SE002', 'SE-AI', 92, 87, 80, 98, 90, 'A+'),
('Amit Desai',      'SE003', 'SE-AI', 75, 68, 72, 80, 70, 'B'),
('Sneha Kulkarni',  'SE004', 'SE-AI', 95, 93, 88, 97, 94, 'A+'),
('Rohan Joshi',     'SE005', 'SE-AI', 60, 72, 65, 78, 68, 'B'),
('Anjali Singh',    'SE006', 'SE-AI', 83, 79, 76, 88, 81, 'A'),
('Vikas Yadav',     'SE007', 'SE-AI', 55, 60, 58, 65, 50, 'C'),
('Pooja Mehta',     'SE008', 'SE-AI', 70, 75, 68, 82, 77, 'B+'),
('Suresh Nair',     'SE009', 'SE-AI', 88, 82, 79, 91, 85, 'A'),
('Meena Iyer',      'SE010', 'SE-AI', 45, 50, 55, 60, 48, 'D'),
('Karan Kapoor',    'SE011', 'SE-AI', 79, 83, 71, 86, 80, 'B+'),
('Deepika Rao',     'SE012', 'SE-AI', 91, 89, 84, 93, 88, 'A+'),
('Nikhil Tiwari',   'SE013', 'SE-AI', 66, 70, 62, 74, 69, 'B'),
('Shruti Bhatt',    'SE014', 'SE-AI', 82, 86, 78, 89, 84, 'A'),
('Aditya Menon',    'SE015', 'SE-AI', 73, 68, 70, 77, 72, 'B'),
('Ritu Gupta',      'SE016', 'SE-AI', 58, 63, 60, 70, 55, 'C'),
('Siddharth More',  'SE017', 'SE-AI', 94, 90, 86, 96, 92, 'A+'),
('Kavya Pillai',    'SE018', 'SE-AI', 77, 80, 74, 85, 78, 'B+'),
('Mohit Chavan',    'SE019', 'SE-AI', 62, 67, 64, 72, 65, 'C+'),
('Isha Deshpande',  'SE020', 'SE-AI', 87, 84, 81, 90, 86, 'A');

-- ── Verify the data ──────────────────────────────────────
SELECT name, roll_number, total_marks, grade 
FROM students 
ORDER BY total_marks DESC;
