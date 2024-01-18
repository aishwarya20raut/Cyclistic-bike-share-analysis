use bike_analysis


CREATE TABLE persone(
	id int NOT NULL,
	name varchar (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	age int NOT NULL
);

INSERT INTO persone(id, name, last_name, age)
VALUES('1','SHUBHAM','RAUT','22'),
		('2','neha','patil','23'),
		('3','rahul','patil','21')

CREATE TABLE student(
	id int NOT NULL,
	name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	age int NOT NULL
)

INSERT INTO student(id, name,last_name,age)
VALUES('1','john','mary','32'),
	('2','linda','rose','30'),
	('3','peter','megan','28')

SELECT * FROM persone
SELECT * FROM student

SELECT id,name,last_name,age from dbo.persone
UNION ALL
SELECT id,name,last_name,age from dbo.student

SELECT * FROM dbo.persone
UNION ALL
SELECT * FROM dbo.student

SELECT* INTO ALL_DATA FROM 
(SELECT * FROM dbo.persone UNION 
SELECT * FROM dbo.student ) a

select * from dbo.ALL_DATA

INSERT INTO ALL_DATA (id,name,last_name,age)
VALUES('1','SHUBHAM','RAUT','22'),
		('2','neha','patil','23'),
		('3','rahul','patil','21'),
		('4','john','mary','32'),
		('5','linda','rose','30'),
		('6','peter','megan','28')

SELECT 
* FROM ALL_DATA
WHERE name =' '

DELETE FROM ALL_DATA
WHERE NAME=' '

INSERT INTO ALL_DATA (id,name,last_name,age)
VALUES('7','neha','patil','23'),
('8','SHUBHAM','RAUT','22')

SELECT * FROM ALL_DATA


SELECT name,last_name,age, COUNT(*) AS total
FROM ALL_DATA
GROUP BY name,last_name,age
HAVING COUNT(*) > 1

DELETE FROM ALL_DATA
WHERE id NOT IN (
SELECT min (id) AS MIN_ID
FROM ALL_DATA
GROUP BY name, last_name,age
);

SELECT * FROM ALL_DATA

--add new col into database
ALTER TABLE ALL_DATA
ADD salary int;

---delte single col 
ALTER TABLE ALL_DATA
DROP COLUMN salary
SELECT * FROM ALL_DATA

SELECT * INTO ALL_DATA_NEW FROM
(
SELECT * FROM ALL_DATA
) a

SELECT * FROM ALL_DATA_NEW
--delete previous table
DROP TABLE ALL_DATA

SELECT  MAX(age) AS max_age
FROM ALL_DATA_NEW

SELECT ROUND(123,3)
SELECT ROUND(123,2)
SELECT ROUND(123,1)
SELECT ROUND(123,-2)