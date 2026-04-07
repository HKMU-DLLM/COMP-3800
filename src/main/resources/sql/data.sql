INSERT INTO users (username, password, full_name, email, phone, role, enabled)
VALUES ('admin', '{noop}1234', 'Administrator', 'admin@example.com', '12345678', 'TEACHER', TRUE);

INSERT INTO lectures (title, summary, course_order)
VALUES ('Intro Lecture', 'This is the first lecture.', 1);