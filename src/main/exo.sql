--5 SELECT
--1 FROM
-- 2 WHERE
-- 3 GROUP BY
-- 4 HAVING
-- 6 ORDER BY --only place to use aliase

--SELECT 4,5,"ok";
--SELECT date() AS DATE

--2.1.1
SELECT last_name, first_name AS "F name"
FROM student;

SELECT last_name || first_name AS name , year_result*10 resultat --*
FROM student;

--2.1.2
SELECT last_name, first_name, birth_date, login, year_result
FROM student;

--2.1.3
SELECT last_name || "  " || first_name AS name, student_id, birth_date
FROM student;

--2.1.4
SELECT last_name || "|" || first_name || "|" || birth_date || "|" || student.login || "|" || section_id || "|" || year_result || "|" || student.course_id AS "info etudiants"
FROM student;

--2.2.1
SELECT login, year_result
FROM student
WHERE year_result > 16;

--2.2.2
SELECT last_name, section_id
FROM student
WHERE first_name == "Georges";

--ALTER TABLE child ADD CONSTRAINT FOREIGN KEY parent_id references parent(id) -- not in sqlite

--2.2.3
SELECT last_name, year_result
FROM student
WHERE year_result BETWEEN 12 AND 16;

--2.2.4
SELECT last_name, section_id, year_result
FROM student
WHERE section_id NOT IN (1010,1020,1110);

--2.2.5
SELECT last_name, section_id
FROM student
WHERE last_name LIKE "%r" ;

--2.2.6
SELECT last_name, year_result
FROM student
WHERE last_name LIKE "__n%" AND year_result > 10 ;

--2.2.7
SELECT last_name, year_result
FROM student
WHERE year_result <= 3
ORDER BY year_result DESC;

--2.2.8
SELECT last_name || " " || first_name as "Nom complet", year_result
FROM student
WHERE section_id==1010
ORDER BY "Nom complet" ASC;

--2.2.9
SELECT last_name,section_id, year_result
FROM student
WHERE (section_id==1010 OR section_id==1020) AND year_result NOT BETWEEN 12 AND 18
ORDER BY section_id;

--2.2.10
SELECT last_name, section_id, year_result*5 AS "Résultat sur 100"
FROM student
WHERE section_id LIKE "13%" AND year_result <=12
ORDER BY "Résultat sur 100" DESC;

--2.3.1
SELECT AVG(year_result)
FROM  student;

--2.3.2
SELECT MAX(year_result)
FROM  student;

--2.3.3
SELECT SUM(year_result)
FROM  student;

--2.3.4
SELECT MIN(year_result)
FROM  student;

--2.3.5
SELECT COUNT(first_name)
FROM  student;

--2.3.6
SELECT login, STRFTIME('%Y',birth_date) AS "Année de naissance"
FROM student
WHERE CAST( STRFTIME('%Y',birth_date) AS INT ) > 1970;

--2.3.7
SELECT login, last_name
FROM student
WHERE LENGTH(last_name) >= 8;

--2.3.8
SELECT UPPER(last_name) as "Nom de famille", first_name, year_result
FROM student
WHERE year_result >= 16
ORDER BY year_result DESC ;

--2.3.9
SELECT first_name, last_name, login, LOWER( SUBSTR(first_name,1,2) || SUBSTR(last_name,1,4) ) AS 'new login'
FROM student
WHERE year_result BETWEEN  6 AND 10;

--2.3.10
SELECT first_name, last_name, login, LOWER( SUBSTR(first_name,LENGTH(first_name)-2,3) ) || ( CAST( STRFTIME('%Y','now') AS INT) - CAST( STRFTIME('%Y',birth_date) AS INT) ) AS 'new login'
FROM student
WHERE year_result IN (10,12,14);

--2.3.11
SELECT last_name, login, year_result
FROM student
WHERE SUBSTRING(last_name,1,1) IN ("D","M","S")-- LIKE "D%" OR last_name LIKE "M%" OR last_name LIKE "S%"
ORDER BY birth_date

--2.3.12
SELECT last_name, login, year_result
FROM student
WHERE year_result%2==1 AND year_result > 10
ORDER BY year_result DESC ;

--2.3.13
SELECT COUNT(*)
FROM student
WHERE  LENGTH(last_name) >= 7;

--2.3.14
SELECT last_name, year_result,
       CASE
           WHEN year_result >= 12 THEN 'OK'
           ELSE 'KO'
           END AS "Status"
FROM student
WHERE CAST ( strftime("%Y",birth_date) AS INT ) < 1955;

--2.3.15
SELECT last_name, year_result,
       CASE
           WHEN year_result < 10 THEN "inférieure"
           WHEN year_result < 10 THEN "neutre"
           ELSE "supérieure"
           END
FROM student
WHERE CAST ( strftime("%Y",birth_date) AS INT ) BETWEEN 1955 AND 1965;

--2.3.16
SELECT last_name, year_result, STRFTIME("%d",birth_date) || " " ||
                               CASE CAST( STRFTIME("%m",birth_date) AS INT)
                                   WHEN 1 THEN "janvier"
                                   WHEN 2 THEN "fevrier"
                                   WHEN 3 THEN "mars"
                                   WHEN 4 THEN "avril"
                                   WHEN 5 THEN "mai"
                                   WHEN 6 THEN "juin"
                                   WHEN 7 THEN "juiller"
                                   WHEN 8 THEN "aout"
                                   WHEN 9 THEN "septembre"
                                   WHEN 10 THEN "octobre"
                                   WHEN 11 THEN "novembre"
                                   ELSE "décembre"
                                   END || " " || STRFTIME("%Y",birth_date)
FROM student
WHERE CAST ( strftime("%Y",birth_date) AS INT ) BETWEEN 1975 AND 1985;

--2.3.17
SELECT  last_name, CAST ( STRFTIME("%m",birth_date) AS INT) AS "Mois de naissance", year_result, NULLIF(year_result,4)
FROM student
WHERE year_result < 7 AND  CAST ( STRFTIME("%m",birth_date) AS INT) NOT IN (1,2,3);

--2.4.1

SELECT section_id, COUNT(last_name)
FROM student
GROUP BY section_id;

SELECT section_id, AVG(year_result)
FROM student
WHERE AVG(year_result) > 50 --can't avg here and yeat_result/20
GROUP BY section_id;


SELECT section_id, AVG(year_result)
FROM student
WHERE year_result > 10
GROUP BY section_id;

--2.4.2

SELECT section_id, MAX(year_result) AS "Résultat maximum"
FROM student
GROUP BY section_id;

--2.4.3

SELECT section_id, AVG(CAST(year_result AS DOUBLE )) AS "MOYENNE"
FROM student
WHERE section_id LIKE "10__"
GROUP BY section_id;

--2.4.4

SELECT DISTINCT CAST( STRFTIME("%m",birth_date) AS INT ) AS "Mois de naissance" , AVG(year_result) AS "MOYENNE"
FROM student
WHERE CAST( STRFTIME("%Y",birth_date) AS INT) BETWEEN 1970 AND 1985
GROUP BY STRFTIME("%m",birth_date);

--2.4.5
SELECT section_id, AVG(year_result ) AS "MOYENNE"
FROM student
GROUP BY section_id
HAVING COUNT(first_name) > 3;

--2.4.6
SELECT section_id, AVG(year_result ) AS "MOYENNE", MAX(year_result) AS "Résultat maximum"
FROM student
GROUP BY section_id
HAVING AVG(year_result) > 8;

--CROSS JOIN tout les possiblibilité, JOIN intersection ,
-- LEFT JOIN left table + intersection + null,
-- RIGHT JOIN right table + intersection + null,