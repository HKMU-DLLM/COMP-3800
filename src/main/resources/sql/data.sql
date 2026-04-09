
-- USERS (password_hash should be BCrypt hashes if you use BCryptPasswordEncoder)
-- Replace the password hashes if needed.

INSERT INTO users (id, username, password, full_name, email, phone, role, enabled)
VALUES
    (1, 'teacher1', '1234', 'Teacher One', 'teacher1@example.com', '111-111-1111', 'TEACHER', TRUE),
    (2, 'student1', 'aaaa', 'Student One', 'student1@example.com', '222-222-2222', 'STUDENT', TRUE),
    (3, 'student2', 'ssss', 'Student Two', 'student2@example.com', '333-333-3333', 'STUDENT', TRUE);

-- LECTURES
-- Remove the 'id' column from the INSERT and the VALUES
INSERT INTO lectures (title, summary)
VALUES
    ('Introduction to the Course', 'Summary here...'),
    ('Core Concepts', 'Summary here...'),
    ('Practice and Review', 'Summary here...');

-- MATERIALS (uploaded file metadata; stored_file_path is where your app will find the file)
INSERT INTO course_materials (lecture_id,original_file_name, stored_file_path, content_type, file_size, uploaded_at,content)
VALUES
    ( 1,'Lecture1-Notes.pdf', 'src/uploads/Lecture1-Notes.pdf', 'application/pdf', 1423, CURRENT_TIMESTAMP,1223),
    (  1,'Lecture1-Slides.pptx', 'src/uploads/Lecture1-Slides.pptx', 'application/vnd.openxmlformats-officedocument.presentationml.presentation', 2233, CURRENT_TIMESTAMP,2324),
    ( 2,'Lecture2-Notes.pdf', 'src/uploads/Lecture2-Notes.pdf', 'application/pdf', 3445, CURRENT_TIMESTAMP,1223);
-- POLLS
INSERT INTO polls (id, question, created_at, course_order)
VALUES
    (1, 'Which topic should be introduced in the next class?', CURRENT_TIMESTAMP, 1),
    (2, 'How should we spend the next tutorial time?', CURRENT_TIMESTAMP, 2);

-- POLL OPTIONS (exactly 5 per poll; option_index 1..5)
-- Poll 1
INSERT INTO poll_options (id, poll_id, option_text, option_index, created_at)
VALUES
    (1, 1, 'Databases & JPA basics', 1, CURRENT_TIMESTAMP),
    (2, 1, 'Spring Security deep dive', 2, CURRENT_TIMESTAMP),
    (3, 1, 'REST vs MVC architecture', 3, CURRENT_TIMESTAMP),
    (4, 1, 'Testing strategies', 4, CURRENT_TIMESTAMP),
    (5, 1, 'Deployment & configuration', 5, CURRENT_TIMESTAMP);

-- Poll 2
INSERT INTO poll_options (id, poll_id, option_text, option_index, created_at)
VALUES
    (6, 2, 'More coding exercises', 1, CURRENT_TIMESTAMP),
    (7, 2, 'More discussion/Q&A', 2, CURRENT_TIMESTAMP),
    (8, 2, 'Mixed exercise + discussion', 3, CURRENT_TIMESTAMP),
    (9, 2, 'Project work time', 4, CURRENT_TIMESTAMP),
    (10, 2, 'Case studies', 5, CURRENT_TIMESTAMP);

-- POLL VOTES (edit-able via unique(poll_id, voter_id))
INSERT INTO poll_votes (id, poll_id, voter_id, selected_option_id, created_at, updated_at)
VALUES
    (1, 1, 2, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),  -- student1 voted option 2 for poll 1
    (2, 1, 3, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),  -- student2 voted option 1 for poll 1
    (3, 2, 2, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);  -- student1 voted option 3 for poll 2

-- COMMENTS
-- Lecture comments: target_type='LECTURE', target_id=lecture_id
INSERT INTO comments (id, author_id, target_type, target_id, content, created_at)
VALUES
    (1, 1, 'LECTURE', 1, 'Welcome! Please read the course overview before next week.', CURRENT_TIMESTAMP),
    (2, 2, 'LECTURE', 1, 'Thanks! Could we get examples of what to expect in assignments?', CURRENT_TIMESTAMP),
    (3, 3, 'LECTURE', 2, 'The summary helped—looking forward to the practical part.', CURRENT_TIMESTAMP);

-- Poll comments: target_type='POLL', target_id=poll_id
INSERT INTO comments (id, author_id, target_type, target_id, content, created_at)
VALUES
    (4, 1, 'POLL', 1, 'Vote based on what will most help the project this term.', CURRENT_TIMESTAMP),
    (5, 2, 'POLL', 2, 'I think a mixed approach would work best.', CURRENT_TIMESTAMP);

