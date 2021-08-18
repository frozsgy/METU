-- SQL queries to achieve the desired DB from the Project 1 database

ALTER TABLE users ADD session_count int NULL DEFAULT 0;


CREATE TABLE membership (
	membership_id serial NOT NULL,
	membership_name text,
	max_parallel_sessions int,
	monthly_fee int,
	PRIMARY KEY(membership_id)
);

CREATE TABLE subscription (
	user_id varchar(22) NOT NULL REFERENCES users(user_id),
	membership_id int NOT NULL REFERENCES membership(membership_id),
	time_spent real,
	PRIMARY KEY(user_id, membership_id)
);

INSERT INTO membership (membership_name, max_parallel_sessions, monthly_fee) VALUES ('Free', 1, 0);
INSERT INTO membership (membership_name, max_parallel_sessions, monthly_fee) VALUES ('Premium Tier 1', 4, 10);
INSERT INTO membership (membership_name, max_parallel_sessions, monthly_fee) VALUES ('Premium Tier 2', 10, 20);
INSERT INTO membership (membership_name, max_parallel_sessions, monthly_fee) VALUES ('Premium Tier 3', 50, 50);

INSERT INTO subscription SELECT user_id, 1 as membership_id, 0 as time_spent from users;
