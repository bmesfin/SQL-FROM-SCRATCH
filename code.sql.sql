--Q1
SELECT *
FROM survey
LIMIT 10;

--Q2
SELECT question,
   COUNT(DISTINCT user_id)
FROM survey
GROUP BY question;

--Q4.1
SELECT *
FROM quiz
LIMIT 5;

--Q4.2
SELECT * 
FROM home_try_on
LIMIT 5;

--Q4.3
SELECT * 
FROM purchase
LIMIT 5;


--Q5
SELECT DISTINCT q.user_id,
       h.user_id IS NOT NULL 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h'
  ON q.user_id = h.user_id
LEFT JOIN purchase AS 'p'
  ON p.user_id = q.user_id
LIMIT 10;

--Q6.1
WITH funnels AS (SELECT DISTINCT q.user_id,
       h.user_id IS NOT NULL 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h'
  ON q.user_id = h.user_id
LEFT JOIN purchase AS 'p'
  ON p.user_id = q.user_id)
SELECT COUNT(*) AS 'num_quiz',
 SUM(is_home_try_on) AS 'num_home_try_on',
 SUM(is_purchase) AS 'num_purchase',
 1.0 * SUM(is_purchase) / COUNT(user_id) AS 'overall_conv_rate',
 1.0 * SUM(is_home_try_on) / COUNT(user_id) AS 'quiz_to_home_try_on',
 1.0 * SUM(is_purchase) / SUM(is_home_try_on) AS 'home_try_on_to_purchase'
FROM funnels;

--Q6.2
WITH funnels AS (SELECT DISTINCT q.user_id,
       h.user_id IS NOT NULL 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h'
  ON q.user_id = h.user_id
LEFT JOIN purchase AS 'p'
  ON p.user_id = q.user_id)
SELECT COUNT(*) AS 'num_quiz',
 SUM(is_home_try_on) AS 'num_home_try_on',
 SUM(is_purchase) AS 'num_purchase',
 1.0 * SUM(is_purchase) / COUNT(user_id) AS 'overall_conv_rate',
 1.0 * SUM(is_home_try_on) / COUNT(user_id) AS 'quiz_to_home_try_on',
 1.0 * SUM(is_purchase) / SUM(is_home_try_on) AS 'home_try_on_to_purchase'
FROM funnels;

--Q6.3
WITH funnels AS (SELECT DISTINCT q.user_id,
       h.user_id IS NOT NULL 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h'
  ON q.user_id = h.user_id
LEFT JOIN purchase AS 'p'
  ON p.user_id = q.user_id)
SELECT number_of_pairs,
 COUNT(*) AS 'num_quiz',
 SUM(is_home_try_on) AS 'num_home_try_on',
 SUM(is_purchase) AS 'num_purchase',
 1.0 * SUM(is_home_try_on) / COUNT(user_id) AS 'quiz_to_home_try_on',
 1.0 * SUM(is_purchase) / SUM(is_home_try_on) AS 'home_try_on_to_purchase'
FROM funnels
GROUP BY number_of_pairs;

--Q6.4
SELECT response,
   question,
   COUNT(DISTINCT user_id)
FROM survey
GROUP BY 1
ORDER BY 3 DESC;

--Q6.5
SELECT product_id,
model_name,
color,
price,
COUNT(DISTINCT user_id)
AS 'total_number_of_purchases'
FROM purchase
GROUP BY 1
ORDER BY 5 DESC;

