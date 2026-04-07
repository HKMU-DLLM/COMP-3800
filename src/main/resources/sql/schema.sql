-- USERS
CREATE TABLE users (
                       id BIGINT AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(50) NOT NULL UNIQUE,
                       password_hash VARCHAR(255) NOT NULL,
                       full_name VARCHAR(100) NOT NULL,
                       email VARCHAR(120) NOT NULL UNIQUE,
                       phone VARCHAR(30) NOT NULL,
                       role VARCHAR(20) NOT NULL,
                       enabled BOOLEAN NOT NULL
);

-- LECTURES
CREATE TABLE lectures (
                          id BIGINT AUTO_INCREMENT PRIMARY KEY,
                          title VARCHAR(200) NOT NULL,
                          summary CLOB NOT NULL,
                          course_order INT
);

-- COURSE MATERIALS (uploaded file metadata in H2)
CREATE TABLE course_materials (
                                  id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                  lecture_id BIGINT NOT NULL,
                                  original_file_name VARCHAR(255) NOT NULL,
                                  stored_file_path VARCHAR(500) NOT NULL,
                                  content_type VARCHAR(100),
                                  file_size BIGINT,
                                  uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                  CONSTRAINT fk_materials_lecture
                                      FOREIGN KEY (lecture_id) REFERENCES lectures(id)
);

CREATE INDEX idx_materials_lecture_id ON course_materials(lecture_id);

-- POLLS
CREATE TABLE polls (
                       id BIGINT AUTO_INCREMENT PRIMARY KEY,
                       question VARCHAR(500) NOT NULL,
                       created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                       course_order INT
);

-- POLL OPTIONS (exactly 5 options per poll enforced by app logic)
CREATE TABLE poll_options (
                              id BIGINT AUTO_INCREMENT PRIMARY KEY,
                              poll_id BIGINT NOT NULL,
                              option_text VARCHAR(300) NOT NULL,
                              option_index INT NOT NULL,
                              created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                              CONSTRAINT fk_options_poll
                                  FOREIGN KEY (poll_id) REFERENCES polls(id),
                              CONSTRAINT uk_poll_option_index UNIQUE (poll_id, option_index)
);

CREATE INDEX idx_options_poll_id ON poll_options(poll_id);

-- POLL VOTES (one vote per user per poll; edit = update row)
CREATE TABLE poll_votes (
                            id BIGINT AUTO_INCREMENT PRIMARY KEY,
                            poll_id BIGINT NOT NULL,
                            voter_id BIGINT NOT NULL,
                            selected_option_id BIGINT NOT NULL,
                            created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                            updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                            CONSTRAINT fk_votes_poll
                                FOREIGN KEY (poll_id) REFERENCES polls(id),
                            CONSTRAINT fk_votes_user
                                FOREIGN KEY (voter_id) REFERENCES users(id),
                            CONSTRAINT fk_votes_option
                                FOREIGN KEY (selected_option_id) REFERENCES poll_options(id),
                            CONSTRAINT uk_poll_voter UNIQUE (poll_id, voter_id)
);

CREATE INDEX idx_votes_poll_id ON poll_votes(poll_id);
CREATE INDEX idx_votes_voter_id ON poll_votes(voter_id);

-- COMMENTS (supports both lectures and polls via target_type + target_id)
CREATE TABLE comments (
                          id BIGINT AUTO_INCREMENT PRIMARY KEY,
                          author_id BIGINT NOT NULL,
                          target_type VARCHAR(20) NOT NULL,
                          target_id BIGINT NOT NULL,
                          content CLOB NOT NULL,
                          created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                          CONSTRAINT fk_comments_author
                              FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE INDEX idx_comments_target ON comments(target_type, target_id);
CREATE INDEX idx_comments_author ON comments(author_id);