DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;

CREATE TABLE users(
  id INTEGER PRIMARY KEY,
  fname VARCHAR(35) NOT NULL,
  lname VARCHAR(35) NOT NULL
);

CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  follower_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (follower_id) REFERENCES users(id)
);

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  parent_id INTEGER,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users(fname, lname)
VALUES
 ('Michael', 'Musgrave'),
 ('Sean', 'Snyder'),
 ('Donald J.', 'Trump'),
 ('Vladimir', 'Putin');

INSERT INTO
  questions(title, body, author_id)
VALUES
  ('How Dangerous is North Korea?', 'So we all know Kim Jong Un scored 18 on a 22 hole golf course.  Do you think he''s dangerous to my scratch golf game?', (SELECT id FROM users WHERE lname = 'Trump')),
  ('Thicker chest hair a myth?', 'Do u kno if hair shaved from da chest will gro back thicka?', (SELECT id FROM users WHERE lname = 'Putin')),
  ('Bathroom lock malfunction?', 'The bathroom lock was broken and SOMEONE was stuck in there for 3 days. How do you fix it? totally not me, asking for a friend.', (SELECT id FROM users WHERE lname = 'Musgrave')),
  ('When should I sleep?', 'So I have to much work in APP Academy, when should I sleep?', (SELECT id FROM users WHERE lname = 'Snyder'));

INSERT INTO
  question_follows(question_id, follower_id)
VALUES
  ((SELECT id FROM questions WHERE title LIKE 'Thicker%'),(SELECT id FROM users WHERE lname = 'Trump')),
  ((SELECT id FROM questions WHERE title LIKE 'How%'),(SELECT id FROM users WHERE lname = 'Musgrave')),
  ((SELECT id FROM questions WHERE title LIKE 'How%'),(SELECT id FROM users WHERE lname = 'Snyder'));

INSERT INTO
  replies(body, parent_id, question_id, user_id)
VALUES
  ('Tooooooooootally, it''ll make your chest sweater look bigly.', NULL, (SELECT id FROM questions WHERE title LIKE 'Thicker%'), (SELECT id FROM users WHERE lname = 'Trump'));

INSERT INTO
  question_likes(question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE title LIKE 'Thicker%'), (SELECT id FROM users WHERE lname = 'Trump')),
  ((SELECT id FROM questions WHERE title LIKE 'How%'), (SELECT id FROM users WHERE lname = 'Putin'));

  INSERT INTO
    replies(body, parent_id, question_id, user_id)
  VALUES
  ('Thanks brochacho, can''t wait to watch Care Bears together later on the phone.', (SELECT id FROM replies WHERE body LIKE 'Tooooooooootally%'), (SELECT id FROM questions WHERE title LIKE 'Thicker%'), (SELECT id FROM users WHERE lname = 'Putin'));
