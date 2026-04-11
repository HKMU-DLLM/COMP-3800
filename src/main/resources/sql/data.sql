INSERT INTO users (username, password, full_name, email, phone, role, enabled) VALUES
('teacher1', '1234', 'Teacher One', 'teacher1@edu.com', '12345678', 'TEACHER', TRUE),
('student1', 'aaaa', 'Student One', 'student1@edu.hk', '12345678', 'STUDENT', TRUE),
('student2', 'ssss', 'Student Two', 'student2@edu.hk', '12345678', 'STUDENT', TRUE);
('profkim', '1234', 'Kim Jong Un', 'kimjongun@edu.hk', '12345678', 'TEACHER', TRUE),
('profobama', '123456', 'Obama', 'obama@edu.hk', '87654321', 'TEACHER', TRUE),
('pdiddy', 'aaaa', 'Puff Daddy', 'pdiddy@edu.hk', '23456789', 'STUDENT', TRUE),
('jefferyepstein', 'ssss', 'Jeffery Epstein', 'epstein@edu.hk', '34567890', 'STUDENT', TRUE);

INSERT INTO lectures (title, summary) VALUES
('Overview of Web Applications', 'Overview of this lecture'),
('Servlet', 'What is a Servlet?'),
('JSP, JavaBean', 'Jakarta Server Pages (JSP)');

INSERT INTO course_materials (lecture_id, original_file_name, stored_file_path, content_type, file_size, uploaded_at) VALUES
(1, 'Lecture1-Notes.pdf', 'src/uploads/Lecture1-Notes.pdf', 'application/pdf', 1423, CURRENT_TIMESTAMP),
(1, 'Lecture1-Slides.pptx', 'src/uploads/Lecture1-Slides.pptx', 'application/vnd.openxmlformats-officedocument.presentationml.presentation', 2233, CURRENT_TIMESTAMP),
(2, 'Lecture2-Notes.pdf', 'src/uploads/Lecture2-Notes.pdf', 'application/pdf', 3445, CURRENT_TIMESTAMP);

INSERT INTO polls (question, course_order) VALUES
('Which topic should be introduced in the next class?', 1),
('How should we spend the next tutorial time?', 2);

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

INSERT INTO poll_votes (poll_id, voter_id, selected_option_id) VALUES
(1, 2, 2),
(1, 3, 1),
(2, 2, 3);

-- Comments
INSERT INTO comments (author_id, target_type, target_id, content) VALUES
(1, 'LECTURE', 1, 'Welcome! Please read the course overview before next week.'),
(2, 'LECTURE', 1, 'Thanks! Could we get examples of what to expect in assignments?'),
(3, 'LECTURE', 2, 'The summary helped—looking forward to the practical part.'),
(1, 'POLL', 1, 'Vote based on what will most help the project this term.'),
(2, 'POLL', 2, 'I think a mixed approach would work best.');