DROP TABLE Transactions;
DROP TABLE Merchants;
DROP TABLE Tags;
DROP TABLE Incomes;
DROP TABLE Targets;
DROP TABLE Posts;
DROP TABLE Questions;
DROP TABLE Users;

CREATE TABLE Merchants (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR( 255 )
);

CREATE TABLE Tags (
  id SERIAL8 PRIMARY KEY,
  monthly_budget FLOAT8,
  name VARCHAR( 255 )
);

CREATE TABLE Transactions (
  id SERIAL8 PRIMARY KEY,
  amount FLOAT8,
  transaction_date DATE,
  merchant_id INT8 REFERENCES Merchants( id ),
  tag_id INT8 REFERENCES Tags( id )
);

CREATE TABLE Incomes (
  id SERIAL8 PRIMARY KEY,
  amount FLOAT8,
  income_date DATE
);

CREATE TABLE Targets (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR( 255 ),
  amount FLOAT8,
  target_date DATE,
  image_url TEXT
);

CREATE TABLE Users (
  id SERIAL8 PRIMARY KEY,
  username VARCHAR( 255 ),
  reputation INT8,
  avatar TEXT
);

CREATE TABLE Questions (
  id SERIAL8 PRIMARY KEY,
  title VARCHAR( 255 ),
  question_date DATE,
  user_id INT8 REFERENCES Users( id )
);

CREATE TABLE Posts (
  id SERIAL8 PRIMARY KEY,
  response TEXT,
  post_date DATE,
  reputation INT8,
  user_id INT8 REFERENCES Users( id ),
  question_id INT8 REFERENCES Questions( id )
);

