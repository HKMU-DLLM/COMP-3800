-- Users
INSERT INTO users (username, password, full_name, email, phone, role, enabled) VALUES
('teacher1', '1234', 'Teacher One', 'teacher1@example.com', '111-111-1111', 'TEACHER', TRUE),
('student1', 'aaaa', 'Student One', 'student1@example.com', '222-222-2222', 'STUDENT', TRUE),
('student2', 'ssss', 'Student Two', 'student2@example.com', '333-333-3333', 'STUDENT', TRUE);

-- Lectures
INSERT INTO lectures (title, summary) VALUES
('Introduction to the Course', 'Summary here...'),
('Core Concepts', 'Summary here...'),
('Practice and Review', 'Summary here...');

-- Course Materials
INSERT INTO course_materials (lecture_id, original_file_name, stored_file_path, content_type, file_size, uploaded_at) VALUES
(1, 'Lecture1-Notes.pdf', 'src/uploads/Lecture1-Notes.pdf', 'application/pdf', 1423, CURRENT_TIMESTAMP),
(1, 'Lecture1-Slides.pptx', 'src/uploads/Lecture1-Slides.pptx', 'application/vnd.openxmlformats-officedocument.presentationml.presentation', 2233, CURRENT_TIMESTAMP),
(2, 'Lecture2-Notes.pdf', 'src/uploads/Lecture2-Notes.pdf', 'application/pdf', 3445, CURRENT_TIMESTAMP);

-- Polls
INSERT INTO polls (question, course_order) VALUES
('Which topic should be introduced in the next class?', 1),
('How should we spend the next tutorial time?', 2);

-- Poll Options
INSERT INTO poll_options (poll_id, option_text, option_index) VALUES
(1, 'Databases & JPA basics', 1),
(1, 'Spring Security deep dive', 2),
(1, 'REST vs MVC architecture', 3),
(1, 'Testing strategies', 4),
(1, 'Deployment & configuration', 5),
(2, 'More coding exercises', 1),
(2, 'More discussion/Q&A', 2),
(2, 'Mixed exercise + discussion', 3),
(2, 'Project work time', 4),
(2, 'Case studies', 5);

-- Poll Votes (初始資料)
INSERT INTO poll_votes (poll_id, voter_id, selected_option_id) VALUES
(1, 2, 2),  -- student1 voted option 2 for poll 1
(1, 3, 1),  -- student2 voted option 1 for poll 1
(2, 2, 3);  -- student1 voted option 3 for poll 2

-- Comments
INSERT INTO comments (author_id, target_type, target_id, content) VALUES
(1, 'LECTURE', 1, 'Welcome! Please read the course overview before next week.'),
(2, 'LECTURE', 1, 'Thanks! Could we get examples of what to expect in assignments?'),
(3, 'LECTURE', 2, 'The summary helped—looking forward to the practical part.'),
(1, 'POLL', 1, 'Vote based on what will most help the project this term.'),
(2, 'POLL', 2, 'I think a mixed approach would work best.');