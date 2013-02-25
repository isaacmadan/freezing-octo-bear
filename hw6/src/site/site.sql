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

INSERT INTO users(user_id, username, password, is_admin, login_count) VALUES
	(NULL, "isaac", "fb464ec99929d760e016f677dd8537570621835b", FALSE, 0),
	(NULL, "aojia", "3da541559918a808c2402bba5012f6c60b27661c", FALSE, 1),
	(NULL, "charlie", "167b6c4a4e415fdfc65024a01a1d46b38344ab1b", FALSE, 300);

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

INSERT INTO quizzes VALUES(

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

INSERT INTO messages VALUES
	(NULL, 1, 2, "Stop crying", 3, NOW()),
	(NULL, 2, 1, "Now I love crying", 3, NOW()),
	(NULL, 3, 1, "Love me baby I am lonely", 3, NOW()),
	(NULL, 1, 2, " isaac wants to be friends. <form action='add_friend.jsp' method='POST'><input type='hidden'
 name='x_id' value='1' /><input type='hidden' name='y_id' value='1' /><input type='submit' value='Add as friend' /></form> ", 1, NOW());

DROP TABLE IF EXISTS friends;
 -- remove table if it already exists and start from scratch

CREATE TABLE friends (
	message_id INT,
    x_id INT,
    y_id INT,
    created_timestamp TIMESTAMP
);

INSERT INTO friends VALUES
	(4, 2, 1, NOW());

DROP TABLE IF EXISTS results;
 -- remove table if it already exists and start from scratch

CREATE TABLE results (
	user_id INT,
	result_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	quiz_id INT,
	user_score INT,
	max_score INT,
	duration INT,
    created_timestamp TIMESTAMP
);

INSERT INTO results VALUES
	(1, NULL, 2, 3, 3, 20000, NOW()),
	(1, NULL, 2, 1, 3, 20000, NOW()),
	(3, NULL, 2, 0, 3, 20000, NOW()),
	(3, NULL, 3, 3, 300, 20000, NOW()),
	(2, NULL, 3, 300, 300, 20000, NOW());



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