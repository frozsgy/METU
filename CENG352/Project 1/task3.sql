/* Trigger for updating review count of users after inserting new review */
CREATE OR REPLACE FUNCTION increment_user_review_count()
RETURNS TRIGGER AS
$func$
BEGIN
UPDATE users
SET review_count = review_count + 1
WHERE user_id = NEW.user_id;
RETURN NULL;
END
$func$ LANGUAGE plpgsql;

CREATE TRIGGER UpdateReviewCount
AFTER INSERT ON review
FOR EACH ROW
EXECUTE PROCEDURE increment_user_review_count();

/* Trigger for denying insertion of review with 0 star, and deleting reviews and tips of that user */ 
CREATE OR REPLACE FUNCTION reject_insertion()
RETURNS TRIGGER AS
$func$
BEGIN
DELETE FROM review WHERE user_id = NEW.user_id;
DELETE FROM tip WHERE user_id = NEW.user_id;
RETURN NULL;
END
$func$ LANGUAGE plpgsql;

CREATE TRIGGER ZeroTrigger
BEFORE INSERT ON review
FOR EACH ROW
WHEN (NEW.stars = 0)
EXECUTE PROCEDURE reject_insertion();

/* View for BusinessCount */
CREATE VIEW BusinessCount AS
SELECT b.business_id, b.business_name, r.count AS review_count
FROM business b
JOIN (
    SELECT r.business_id, COUNT(r.review_id)
    FROM review r
    GROUP BY r.business_id) r
ON b.business_id = r.business_id;


