DROP TABLE Transactions;
DROP TABLE Merchants;
DROP TABLE Tags;
DROP TABLE Incomes;
DROP TABLE Targets;

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
  question VARCHAR( 255 ),
  post_date DATE,
  user_id REFERENCES Users
);

CREATE TABLE Posts (
  id SERIAL8 PRIMARY KEY,
  response TEXT,
  post_date DATE,
  user_id REFERENCES Users,
  question_id REFERENCES Questions
);