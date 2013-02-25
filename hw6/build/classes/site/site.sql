USE c_cs108_imadan;

DROP TABLE IF EXISTS users;
 -- remove table if it already exists and start from scratch

CREATE TABLE users (
	user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username CHAR(64),
    password CHAR(64),
    is_admin BOOLEAN,
    login_count INT,
    created_timestamp timestamp default '0000-00-00 00:00:00', 
  	last_login_timestamp timestamp default now() on update now() 
);

DROP TABLE IF EXISTS quizzes;
 -- remove table if it already exists and start from scratch

CREATE TABLE quizzes (
	quiz_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT,
	practice_mode BOOLEAN,
	max_score INT,
	description TEXT,
	title TEXT,
	random_question BOOLEAN,
	one_page BOOLEAN,
	immediate_correction BOOLEAN,
    created_timestamp TIMESTAMP
);

DROP TABLE IF EXISTS questions;
 -- remove table if it already exists and start from scratch

CREATE TABLE questions (
	question_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    quiz_id INT,
    point_value INT,
    question_type INT,
    created_timestamp TIMESTAMP
);

DROP TABLE IF EXISTS answers;
 -- remove table if it already exists and start from scratch

CREATE TABLE answers (
	answer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	question_id INT,
	string TEXT,
    created_timestamp TIMESTAMP
);

DROP TABLE IF EXISTS messages;
 -- remove table if it already exists and start from scratch

CREATE TABLE messages (
	message_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	to_id INT,
	from_id INT,
	content TEXT,
	message_type INT,
	created_timestamp TIMESTAMP
);

DROP TABLE IF EXISTS friends;
 -- remove table if it already exists and start from scratch

CREATE TABLE friends (
	message_id INT,
    x_id INT,
    y_id INT,
    created_timestamp TIMESTAMP
);

DROP TABLE IF EXISTS results;
 -- remove table if it already exists and start from scratch

CREATE TABLE results (
	result_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT,
	quiz_id INT,
	score INT,
	duration INT,
    created_timestamp TIMESTAMP
);

DROP TABLE IF EXISTS question_responses;
 -- remove table if it already exists and start from scratch

CREATE TABLE question_responses (
	question_responses_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    question_id INT,
    string TEXT,
    created_timestamp TIMESTAMP
);

DROP TABLE IF EXISTS fill_in_the_blanks;
 -- remove table if it already exists and start from scratch

CREATE TABLE fill_in_the_blanks (
	fill_in_the_blanks_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	question_id INT,
	string_1 TEXT,
	string_2 TEXT,
    created_timestamp TIMESTAMP
);

DROP TABLE IF EXISTS multiple_choices;
 -- remove table if it already exists and start from scratch

CREATE TABLE multiple_choices (
	multiple_choice_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    question_id INT,
    string TEXT,
    created_timestamp TIMESTAMP
);

DROP TABLE IF EXISTS picture_responses;
 -- remove table if it already exists and start from scratch

CREATE TABLE picture_responses (
	picture_responses_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    question_id INT,
    string TEXT,
    created_timestamp TIMESTAMP
);

DROP TABLE IF EXISTS multiple_choices_choices;
 -- remove table if it already exists and start from scratch

CREATE TABLE multiple_choices_choices (
	multiple_choices_choices_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    multiple_choices_id INT,
    string TEXT,
    created_timestamp TIMESTAMP
);

DROP TABLE IF EXISTS achievements;
 -- remove table if it already exists and start from scratch

CREATE TABLE achievements (
	user_id INT,
	amateur_author BOOLEAN,
    prolific_author BOOLEAN,
    prodigious_author BOOLEAN,
    quiz_machine BOOLEAN,
    i_am_greatest BOOLEAN,
    practice_perfect BOOLEAN
);