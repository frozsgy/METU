CREATE TABLE business (
	business_id varchar(22) NOT NULL,
	business_name text NOT NULL,
	address text NULL,
	state varchar(3) NULL,
	is_open bool NULL,
	stars float4 NULL,
	PRIMARY KEY (business_id)
);


CREATE TABLE users (
	user_id varchar(22) NOT NULL,
	user_name text NOT NULL,
	review_count int8 NULL,
	yelping_since timestamp NULL,
	useful int8 NULL,
	funny int8 NULL,
	cool int8 NULL,
	fans int8 NULL,
	average_stars float4 NULL,
	PRIMARY KEY (user_id)
);


CREATE TABLE friend (
	user_id1 varchar(22) NOT NULL,
	user_id2 varchar(22) NOT NULL,
	PRIMARY KEY (user_id1, user_id2),
	FOREIGN KEY (user_id1) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (user_id2) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE review (
	review_id varchar(22) NOT NULL,
	user_id varchar(22) NOT NULL,
	business_id varchar(22) NOT NULL,
	stars float4 NULL,
	"date" timestamp NULL,
	useful int8 NULL,
	funny int8 NULL,
	cool int8 NULL,
	PRIMARY KEY (review_id),
	FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (business_id) REFERENCES business(business_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE tip (
	tip_id serial NOT NULL,
	business_id varchar(22) NOT NULL,
	user_id varchar(22) NOT NULL,
	"date" timestamp NULL,
	tip_text text NULL,
	compliment_count int8 NULL,
	PRIMARY KEY (tip_id),
	FOREIGN KEY (business_id) REFERENCES business(business_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);


/*
import csv files to postgres

\copy users(user_id, user_name, review_count, yelping_since, useful, funny, cool, fans, average_stars) FROM '/home/ozan/github/ceng352-project1/yelp_academic_dataset/yelp_academic_dataset_user.csv' with (format csv,header true, delimiter ',');
\copy friend(user_id1, user_id2) FROM '/home/ozan/github/ceng352-project1/yelp_academic_dataset/yelp_academic_dataset_friend.csv' with (format csv,header true, delimiter ',');
\copy business(business_id, business_name, address, state, is_open, stars) FROM '/home/ozan/github/ceng352-project1/yelp_academic_dataset/yelp_academic_dataset_business.csv' with (format csv,header true, delimiter ',');
\copy tip(tip_text, date, compliment_count, business_id, user_id) FROM '/home/ozan/github/ceng352-project1/yelp_academic_dataset/yelp_academic_dataset_tip.csv' with (format csv,header true, delimiter ',');
\copy review(review_id, user_id, business_id, stars, date, useful, funny, cool) FROM '/home/ozan/github/ceng352-project1/yelp_academic_dataset/yelp_academic_dataset_reviewNoText.csv' with (format csv,header true, delimiter ',');
*/