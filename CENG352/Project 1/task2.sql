/* Question 1 */
SELECT u.user_id, u.user_name, (u.review_count-u.fans)  
FROM users u
WHERE u.review_count > u.fans
AND u.user_id IN (
    SELECT r.user_id
    FROM review r
    WHERE r.business_id IN (
        SELECT b.business_id
        FROM business b 
        WHERE b.stars > 3.5
        )
    )
ORDER BY (u.review_count-u.fans) DESC, u.user_id DESC;
/* Question 2 */
SELECT u.user_name, bq.business_name, t.date, t.compliment_count
FROM tip t
JOIN business bq
ON t.business_id = bq.business_id
JOIN users u
ON t.user_id = u.user_id
WHERE t.compliment_count > 2
AND t.business_id IN (
    SELECT b.business_id
    FROM business b
    WHERE b.is_open = 'true'
    AND b.state = 'TX'
) 
ORDER by t.compliment_count DESC, t.date DESC;
/* Question 3 */
SELECT u.user_name, f.friend_count
FROM (
    SELECT DISTINCT user_id1 AS user_id, COUNT(user_id2) AS friend_count
    FROM friend
    GROUP BY user_id1
    ORDER BY friend_count DESC LIMIT 20
    ) f
JOIN users u
ON f.user_id = u.user_id
ORDER BY friend_count DESC, user_name DESC;
/* Question 4 */
SELECT u.user_name, u.average_stars, u.yelping_since
FROM (
    SELECT DISTINCT r.user_id
    FROM review r
    JOIN business b
    ON r.business_id = b.business_id
    WHERE r.stars < b.stars
    ) d
JOIN users u
ON d.user_id = u.user_id 
ORDER BY u.average_stars DESC, u.yelping_since DESC;
/* Question 5 */
SELECT b.business_name, b.state, b.stars
FROM (
    SELECT t.business_id 
    FROM tip t
    WHERE 
    t.date >= '2020-01-01 00:00:00' AND 
    t.date < '2021-01-01 00:00:00' AND 
    t.tip_text LIKE '%good%'
    GROUP BY t.business_id
    HAVING COUNT(*) = (
        SELECT COUNT(*)
        FROM tip t
        WHERE 
        t.date >= '2020-01-01 00:00:00' AND 
        t.date < '2021-01-01 00:00:00' AND 
        t.tip_text LIKE '%good%'
        GROUP BY t.business_id ORDER by count(*) DESC LIMIT 1)
) j
JOIN business b 
ON b.business_id = j.business_id
WHERE b.is_open = 'true'
ORDER BY b.stars DESC, b.business_name DESC;
/* Question 6 */
SELECT u.user_name, u.yelping_since, u.average_stars
FROM (
    SELECT DISTINCT f.user_id1 AS user_id, MIN(uu.average_stars) AS min_stars
    FROM friend f
    JOIN users uu 
    ON f.user_id2 = uu.user_id
    GROUP BY f.user_id1
    ) d
JOIN users u
ON d.user_id = u.user_id
WHERE u.average_stars < d.min_stars
ORDER BY u.average_stars DESC, u.yelping_since DESC;
/* Question 7 */
SELECT b.state, AVG(b.stars)
FROM business b
GROUP BY b.state
ORDER BY AVG(b.stars) DESC
LIMIT 10;
/* Question 8 */
SELECT t.year, y.average_compliment_count
FROM (
    SELECT good.year AS year
    FROM (
        SELECT EXTRACT(YEAR FROM t.date) AS year, COUNT(*)
        FROM tip t
        WHERE t.compliment_count > 0
        GROUP BY year) good
    JOIN (
        SELECT EXTRACT(YEAR FROM t.date) AS year, COUNT(*)
        FROM tip t
        WHERE t.compliment_count = 0
        GROUP BY year) bad
    ON good.year = bad.year
    WHERE (good.count * 100.0 / (good.count + bad.count)) > 1
) t
INNER JOIN (
    SELECT EXTRACT(YEAR FROM t.date) AS year, AVG(t.compliment_count) AS average_compliment_count
    FROM tip t
    GROUP BY year) y
ON t.year = y.year
ORDER BY t.year ASC;
/* Question 9 */
SELECT u.user_name 
FROM users u
WHERE u.user_id IN (
    SELECT DISTINCT r.user_id
    FROM review r
    JOIN business b
    ON r.business_id = b.business_id
    GROUP BY r.user_id
    HAVING MIN(b.stars) > 3.5
)
ORDER BY u.user_name ASC;
/* Question 10 */
SELECT b.business_name, p.average_star, p.year
FROM (
    SELECT EXTRACT(YEAR FROM r.date) AS year, AVG(r.stars) AS average_star, r.business_id
    FROM review r
    WHERE r.business_id IN (
        SELECT r.business_id
        FROM review r
        GROUP BY r.business_id
        HAVING COUNT(r.review_id) > 1000)
    GROUP BY year, r.business_id
) p
JOIN business b
ON p.business_id = b.business_id
WHERE p.average_star > 3
ORDER BY p.year ASC, b.business_name ASC;
/* Question 11 */
SELECT u.user_name, j.useful, j.cool, (j.useful - j.cool) AS difference
FROM (
    SELECT SUM(r.useful) AS useful, SUM(r.cool) AS cool, r.user_id
    FROM review r 
    GROUP BY r.user_id) j
JOIN users u
ON j.user_id = u.user_id
WHERE j.useful > j.cool
ORDER BY difference DESC, u.user_name DESC;
/* Question 12 */
SELECT DISTINCT j.user_id1, j.user_id2, j.business_id, j.stars
FROM (
    SELECT f.user_id1, f.user_id2, r.stars, r.business_id 
    FROM (
        SELECT f3.user_id1, f3.user_id2
        FROM friend f3
        EXCEPT
        SELECT f2.user_id1, f2.user_id2
        FROM friend f1 
        INNER JOIN friend f2 
        ON f1.user_id1 = f2.user_id2 
        AND f1.user_id2 = f2.user_id1 
        AND f1.user_id1 > f1.user_id2) f
    JOIN review r
    ON r.user_id = f.user_id1) j
JOIN review r
ON r.user_id = j.user_id2 
WHERE j.stars = r.stars 
AND j.business_id = r.business_id
ORDER BY j.business_id DESC, j.stars DESC;
/* Question 13 */
SELECT b.state, b.stars, COUNT(b.business_id)
FROM business b
WHERE b.is_open = 't'
GROUP BY CUBE(b.stars, b.state)
ORDER BY b.state;
/* Question 14 */
SELECT * 
FROM (
    SELECT user_id,
    review_count,
    fans,
    rank() OVER (PARTITION BY fans ORDER BY review_count DESC)
    FROM users
    WHERE fans >= 50 AND fans <= 60
    ORDER BY rank) rr
WHERE rr.rank < 4;