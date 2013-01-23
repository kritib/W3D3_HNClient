CREATE TABLE posts (
  id INTEGER PRIMARY KEY,
  link VARCHAR(255),
  screen_name VARCHAR(50),
  points INTEGER,
  FOREIGN KEY(screen_name) REFERENCES users(screen_name)
);

CREATE TABLE users (
  id INTEGER PRIMARY KEY
  screen_name VARCHAR(50),
  karma INTEGER,
  avg_karma INTEGER
);

CREATE TABLE comments (
  id INTEGER PRIMARY KEY,
  screen_name VARCHAR(50),
  text TEXT,
  FOREIGN KEY(screen_name) REFERENCES users(screen_name)
);