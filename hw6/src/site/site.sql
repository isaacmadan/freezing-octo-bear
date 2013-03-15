USE c_cs108_imadan;

DROP TABLE IF EXISTS users;
 -- remove table if it already exists and start from scratch

CREATE TABLE users (
	user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username CHAR(64),
    password TEXT,
    salt, TEXT,
    is_admin BOOLEAN,
    login_count INT,
    created_timestamp timestamp default '0000-00-00 00:00:00', 
  	last_login_timestamp timestamp default now() on update now(), 
	FULLTEXT(username)
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
    created_timestamp TIMESTAMP,
    FULLTEXT(description,title)
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

DROP TABLE IF EXISTS user_answers;

CREATE TABLE user_answers (
	result_id INT,
	quiz_id INT,
	question_id INT,
	string TEXT
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
    x_id INT,
    y_id INT,
    created_timestamp TIMESTAMP
);


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
    created_timestamp TIMESTAMP,
    question_string TEXT
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
    created_timestamp TIMESTAMP default now(),
);

DROP TABLE IF EXISTS announcements;

CREATE TABLE announcements (
	announce_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT,
	string TEXT,
	created_timestamp TIMESTAMP
);

DROP TABLE IF EXISTS categories;

CREATE TABLE categories (
	category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	quiz_id INT,	
	string TEXT,
	FULLTEXT(string)
);

DROP TABLE IF EXISTS tags;

CREATE TABLE tags (
	tag_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	quiz_id INT,
	string TEXT,
	FULLTEXT(string)
);

DROP TABLE IF EXISTS reviews;

CREATE TABLE reviews (
	review_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT,
	quiz_id INT,
	string TEXT,
	review_score INT,
	created_timestamp TIMESTAMP default now(),
);

DROP TABLE IF EXISTS reports;

CREATE TABLE reports (
	report_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT,
	quiz_id INT,
	string TEXT,
	created_timestamp TIMESTAMP default now()
);


-- Initialize database with these fields

INSERT INTO users(user_id, username, password, salt, is_admin, login_count) VALUES

	(NULL, "isaac", "85603b51e76bac1c5a9c316118ae1312254aaaa8", "be0c2801b4d37421556b250f", TRUE, 0),
	(NULL, "aojia", "3fae269b34f482dd8598d8810211fa4fec74020d","c4dc150822df05ae26f53652", FALSE, 1),
	(NULL, "charlie", "e05221fe9b8af2eb1b05129b32b4bf0c3e277968","dddc2916e4c9b51699d65444", FALSE, 300);
	
INSERT INTO categories VALUES
(NULL, -1, "Food"),
(NULL, -1, "Politics"),
(NULL, -1, "Techonology"),
(NULL, -1,  "Lifestyle"),
(NULL, -1,  "Art"),
(NULL, -1,  "Science"),
(NULL, -1,  "People"),
(NULL, -1,  "World"),
(NULL, -1,  "Film"),
(NULL, -1,  "Cars"),
(NULL, -1,  "Music"),
(NULL, -1,  "Style"),
(NULL, -1,  "Religion"),
(NULL, -1,  "Health"),
(NULL, -1,  "Opinion"),
(NULL, -1,  "Fashion"),
(NULL, -1,  "Design"),
(NULL, -1,  "Culture");


