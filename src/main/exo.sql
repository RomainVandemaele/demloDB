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
SELECT last_name || '  ' || first_name AS name, student_id, birth_date
FROM student;

--2.1.4
SELECT last_name || '|' || first_name || '|' || birth_date || '|' || student.login || '|' || section_id || '|' || year_result || '|' || student.course_id AS "info etudiants"
FROM student;

--2.2.1
SELECT login, year_result
FROM student
WHERE year_result > 16;

--2.2.2
SELECT last_name, section_id
FROM student
WHERE first_name == 'Georges';

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
WHERE last_name LIKE '%r' ;

--2.2.6
SELECT last_name, year_result
FROM student
WHERE last_name LIKE '__n%' AND year_result > 10 ;

--2.2.7
SELECT last_name, year_result
FROM student
WHERE year_result <= 3
ORDER BY year_result DESC;

--2.2.8
SELECT last_name || ' ' || first_name as "Nom complet", year_result
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
WHERE section_id LIKE '13%' AND year_result <=12
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
WHERE CAST( STRFTIME('%Y',birth_date) AS INT ) > 1970; -- birth_date > '1970-01-01'

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
WHERE SUBSTRING(last_name,1,1) IN ('D','M','S')-- LIKE "D%" OR last_name LIKE "M%" OR last_name LIKE "S%"
ORDER BY birth_date;

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
WHERE CAST ( strftime('%Y',birth_date) AS INT ) < 1955;

--2.3.15
SELECT last_name, year_result,
       CASE
           WHEN year_result < 10 THEN 'inférieure'
           WHEN year_result < 10 THEN 'neutre'
           ELSE 'supérieure'
           END
FROM student
WHERE CAST ( strftime('%Y',birth_date) AS INT ) BETWEEN 1955 AND 1965;

--2.3.16
SELECT last_name, year_result, STRFTIME('%d',birth_date) || ' ' ||
                               CASE CAST( STRFTIME('%m',birth_date) AS INT)
                                   WHEN 1 THEN 'janvier'
                                   WHEN 2 THEN 'fevrier'
                                   WHEN 3 THEN 'mars'
                                   WHEN 4 THEN 'avril'
                                   WHEN 5 THEN 'mai'
                                   WHEN 6 THEN 'juin'
                                   WHEN 7 THEN 'juiller'
                                   WHEN 8 THEN 'aout'
                                   WHEN 9 THEN 'septembre'
                                   WHEN 10 THEN 'octobre'
                                   WHEN 11 THEN 'novembre'
                                   ELSE 'décembre'
                                   END || ' ' || STRFTIME('%Y',birth_date)
FROM student
WHERE CAST ( strftime('%Y',birth_date) AS INT ) BETWEEN 1975 AND 1985;

--2.3.17
SELECT  last_name, CAST ( STRFTIME('%m',birth_date) AS INT) AS 'Mois de naissance', year_result, NULLIF(year_result,4)
FROM student
WHERE year_result < 7 AND  CAST ( STRFTIME('%m',birth_date) AS INT) NOT IN (1,2,3);

--2.4.1

SELECT section_id, COUNT(last_name)
FROM student
GROUP BY last_name;
--GROUP BY section_id;

SELECT section_id, AVG(year_result)
FROM student
--WHERE AVG(year_result) > 50 --can't avg here and yeat_result/20
GROUP BY section_id
HAVING AVG(year_result) > 50;


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
WHERE section_id LIKE '10__'
GROUP BY section_id;

--2.4.4

SELECT DISTINCT CAST( STRFTIME('%m',birth_date) AS INT ) AS 'Mois de naissance" , AVG(year_result) AS "MOYENNE'
FROM student
WHERE CAST( STRFTIME('%Y',birth_date) AS INT) BETWEEN 1970 AND 1985
GROUP BY STRFTIME('%m',birth_date);

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



--2.5.1
SELECT C.course_name, S.section_name, P.professor_name
FROM  ( course C  JOIN professor P on C.professor_id = P.professor_id )  JOIN section S ON P.section_id = S.section_id;

--2.5.2
SELECT S.section_id, S.section_name, St.last_name
FROM section S  JOIN student St on S.delegate_id = St.student_id
ORDER BY S.section_id DESC ;

--2.5.3
SELECT  S.section_id, S.section_name, P.professor_name
FROM section S LEFT JOIN professor P ON S.section_id = P.section_id
ORDER BY S.section_id DESC ;

--2.5.4
SELECT  S.section_id, S.section_name, P.professor_name
FROM section S JOIN professor P ON S.section_id = P.section_id
ORDER BY S.section_id DESC ;

--2.5.5
SELECT S.last_name, S.year_result, G.grade
FROM student S JOIN grade G ON S.year_result BETWEEN G.lower_bound AND G.upper_bound
WHERE S.year_result >= 12;

--2.5.6
SELECT P.professor_name, S.section_name, C.course_name, C.course_ects
FROM (professor P LEFT JOIN course C on P.professor_id = C.professor_id ) LEFT JOIN section S ON S.section_id = P.section_id
--FROM (Section S JOIN professor P on S.section_id = P.section_id) LEFT JOIN Course C ON P.professor_id = C.professor_id
ORDER BY  C.course_ects DESC;

--2.5.7
SELECT P.professor_id, SUM(C.course_ects) AS "ECTS_TOT"
FROM (professor P LEFT JOIN course C on P.professor_id = C.professor_id )
GROUP BY P.professor_id
ORDER BY 'ECTS_TOT' DESC;

--2.5.8
SELECT first_name, last_name, 'S'
FROM student
WHERE LENGTH(last_name) > 8
UNION
SELECT professor_name, professor_surname, 'P'
FROM professor
WHERE LENGTH(professor_surname) > 8;

--2.5.9
SELECT section_id
FROM section
EXCEPT
SELECT S.section_id
FROM section S JOIN professor p on S.section_id = p.section_id;

--2.6.1
SELECT last_name, first_name, section_id
FROM student
WHERE last_name != 'Roberts' AND  section_id = (
    SELECT section_id
    FROM student
    WHERE last_name = 'Roberts'
);

--2.6.2
SELECT last_name, first_name, year_result
FROM student
WHERE year_result > (
    SELECT floor( AVG(year_result)) *2
    FROM student
);

SELECT floor( AVG(year_result) ) *2
FROM student;

--2.6.3
SELECT S.section_id, S.section_name
FROM section S
WHERE  NOT EXISTS(
        SELECT section_id
        FROM professor P
        WHERE P.section_id = S.section_id
    );

--2.6.4
SELECT last_name, first_name, STRFTIME('%d',birth_date) ||'/' || STRFTIME('%m',birth_date) ||'/' || STRFTIME('%Y',birth_date) AS "Date de Naissance", year_result
FROM student
WHERE STRFTIME('%m',birth_date) = (
    SELECT STRFTIME('%m', professor_hire_date)
    FROM professor
    WHERE professor_name = 'giot'
);


--2.6.5
SELECT S.last_name, S.first_name, S.year_result
FROM  student S
WHERE EXISTS(
              SELECT G.grade
              FROM grade G
              WHERE G.grade='TB' AND S.year_result >= G.lower_bound AND S.year_result <= G.upper_bound
          );

SELECT S.last_name, S.first_name, S.year_result
FROM  student S
WHERE year_result BETWEEN ( SELECT lower_bound FROM grade WHERE grade='TB') AND ( SELECT upper_bound FROM grade WHERE grade='TB');

--2.6.6
SELECT S1.last_name, S1.first_name, S1.section_id
FROM student S1
WHERE section_id = (
    SELECT S.section_id
    FROM section S JOIN student S2 ON S.delegate_id = S2.student_id
    WHERE S2.last_name = 'Marceau'
);

--2.6.7
SELECT S.section_id, S.section_name
FROM section S
WHERE (SELECT COUNT(St.first_name)
       FROM student St
       WHERE St.section_id = S.section_id
      ) >4;

--2.6.8
SELECT S1.last_name, S1.first_name, S1.section_id
FROM student S1
WHERE S1.year_result = (
    SELECT MAX(S2.year_result)
    FROM student S2
    WHERE S1.section_id = s2.section_id
) AND (
          SELECT AVG(S3.year_result)
          FROM student S3
          WHERE S1.section_id = s3.section_id
      ) >=10;


--2.6.9
SELECT avgSec.SID, MAX("AVG res")
FROM (SELECT S.section_id AS "SID", AVG(S.year_result) AS "AVG res"
      FROM student S
      GROUP BY S.section_id) AS avgSec;
--3.1
INSERT INTO student VALUES ( 26, 'Romain','Vandemaele','1994-10-09','rvdemael',1010,18,'EG2210');

DELETE FROM student WHERE first_name = 'Romain' OR first_name = 'Tan' OR first_name = 'Aiélée';

--3.2
INSERT INTO student(student_id,first_name,birth_date,section_id,course_id)
VALUES (27,'Tan','1990-01-01',1010,'EG2210');

--3.3
CREATE TABLE section_archives (
                                  section_id int NOT NULL,
                                  section_name varchar(50),
                                  delegate_id int,
                                  CONSTRAINT PK_section PRIMARY KEY (section_id)
);

INSERT INTO section_archives
SELECT *
FROM section;

--3.4
INSERT INTO student(student_id, first_name, section_id, course_id)
VALUES (28,'Aiélée',
        (SELECT section_id FROM student WHERE last_name = 'Reeves' AND first_name = 'Keanu' ),
        (SELECT course_id
         FROM course LEFT JOIN professor p on p.professor_id = course.professor_id
         WHERE p.professor_name = 'zidda'));

--3.5
INSERT INTO section_archives
VALUES (1530,'Administration des SI', (SELECT delegate_id FROM section_archives WHERE section_id = '1010'));

--3.6
UPDATE student
SET course_id = 'EG2210'
WHERE student_id = 26;

--3.7
UPDATE student
SET last_name = 'Phan'
WHERE student_id = 27;

UPDATE student
SET year_result = 18, login = lower(substr(first_name,1,1) || student.last_name)
WHERE student_id = 27;

--3.8
UPDATE student
SET year_result = 15
WHERE section_id = 1010;

--3.9
UPDATE section_archives
SET delegate_id = (
    SELECT student_id
    FROM student
    WHERE first_name = 'Keanu' AND last_name = 'Reeves'
)
WHERE section_id = 1530;

--3.10
UPDATE section_archives
SET section_name = (
    SELECT section_name
    FROM section_archives
    WHERE section_id = 1320
) ,
    delegate_id = (
        SELECT delegate_id
        FROM section_archives
        WHERE section_id = 1320
    )
WHERE section_id = 1530;

UPDATE section_archives
SET (section_name, delegate_id)  = (
    SELECT section_name, delegate_id
    FROM section_archives
    WHERE section_id = 1320
)
WHERE section_id = 1530;

--3.11
UPDATE section_archives
SET delegate_id = (
    SELECT student_id
    FROM student
    WHERE first_name = 'Alyssa' AND last_name = 'Milano'
)
WHERE section_id = (
    SELECT section_id
    FROM student
    WHERE first_name = 'Alyssa' AND last_name = 'Milano'
);

--3.12
DELETE FROM student
WHERE first_name='Tan' AND last_name ='Phan';
--WHERE student_id = 27;

--3.13
DELETE FROM student
WHERE ( first_name='Romain' AND last_name ='Vandemaele') OR ( first_name='Kim' AND last_name ='Basinger') ;

--3.14
DELETE FROM student
WHERE  year_result < 8;

--3.15
DELETE FROM course
WHERE professor_id IS NULL;
