USE MASTER
GO
DROP DATABASE IF EXISTS MGraph
GO
CREATE DATABASE MGraph
GO
USE MGraph
GO

-- ������� "������������"
CREATE TABLE Users (
    ID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Age INT,
    Gender NVARCHAR(10),
    Occupation NVARCHAR(100)
) AS NODE;

-- ������� "�����"
CREATE TABLE Movies (
    ID INT PRIMARY KEY,
    Name NVARCHAR(200),
    ReleaseYear INT,
    Director NVARCHAR(100),
    Rating FLOAT,
    NumVotes INT
)AS NODE;

-- ������� "����"
CREATE TABLE Genres (
    ID INT PRIMARY KEY,
    Name NVARCHAR(50)
) AS NODE;

CREATE TABLE Watching (Rating FLOAT) AS EDGE;

CREATE TABLE Recommending AS EDGE;

CREATE TABLE Describing AS EDGE;

-- ���������� ������� "������������"
INSERT INTO Users (ID, Name, Age, Gender, Occupation)
VALUES
    (1, N'����', 25, N'�', N'��������'),
    (2, N'����', 30, N'�', N'�����������'),
    (3, N'�����', 22, N'�', N'�������'),
    (4, N'����', 35, N'�', N'�������'),
    (5, N'�����', 28, N'�', N'��������'),
    (6, N'�������', 40, N'�', N'���������'),
    (7, N'��������', 29, N'�', N'��������'),
    (8, N'�������', 27, N'�', N'�������'),
    (9, N'�����', 33, N'�', N'����'),
    (10, N'�����', 31, N'�', N'�����');

-- ���������� ������� "�����"
INSERT INTO Movies (ID, Name, ReleaseYear, Director, Rating, NumVotes)
VALUES
    (1, N'������� ����', 1999, N'����� ��������', 8.6, 1094000),
    (2, N'����� �� ��������', 1994, N'����� ��������', 9.3, 2300000),
    (3, N'������� ����', 1994, N'������ �������', 8.8, 1870000),
    (4, N'������', 2010, N'��������� �����', 8.8, 2070000),
    (5, N'����', 1994, N'��� ������', 8.5, 1120000),
    (6, N'�������', 1999, N'���� ��������', 8.7, 1720000),
    (7, N'������������', 2014, N'��������� �����', 8.6, 1340000),
    (8, N'�������, ������, ����', 1966, N'������ �����', 8.8, 616000),
    (9, N'�������� �����: ������ 5 � ������� ������� �������� ����', 1980, N'����� �������', 8.7, 1220000),
    (10, N'���������� 2: ������ ����', 1991, N'������ �������', 8.5, 989000);

-- ���������� ������� "����"
INSERT INTO Genres (ID, Name)
VALUES
    (1, N'�����'),
    (2, N'��������'),
    (3, N'�����������'),
    (4, N'������� ����������'),
    (5, N'������'),
    (6, N'�������'),
    (7, N'�������'),
    (8, N'�������'),
    (9, N'������'),
    (10, N'����');


INSERT INTO Recommending ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Users WHERE id = 1),
 (SELECT $node_id FROM Users WHERE id = 2)),
 ((SELECT $node_id FROM Users WHERE id = 10),
 (SELECT $node_id FROM Users WHERE id = 5)),
 ((SELECT $node_id FROM Users WHERE id = 2),
 (SELECT $node_id FROM Users WHERE id = 9)),
 ((SELECT $node_id FROM Users WHERE id = 3),
 (SELECT $node_id FROM Users WHERE id = 1)),
 ((SELECT $node_id FROM Users WHERE id = 3),
 (SELECT $node_id FROM Users WHERE id = 6)),
 ((SELECT $node_id FROM Users WHERE id = 4),
 (SELECT $node_id FROM Users WHERE id = 2)),
 ((SELECT $node_id FROM Users WHERE id = 5),
 (SELECT $node_id FROM Users WHERE id = 4)),
 ((SELECT $node_id FROM Users WHERE id = 6),
 (SELECT $node_id FROM Users WHERE id = 7)),
 ((SELECT $node_id FROM Users WHERE id = 6),
 (SELECT $node_id FROM Users WHERE id = 8)),
 ((SELECT $node_id FROM Users WHERE id = 8),
 (SELECT $node_id FROM Users WHERE id = 3));
GO
SELECT *
FROM Recommending;

INSERT INTO Watching ($from_id, $to_id, rating)
VALUES ((SELECT $node_id FROM Users WHERE ID = 1),
 (SELECT $node_id FROM Movies WHERE ID = 1), 2.5),
 ((SELECT $node_id FROM Users WHERE ID = 5),
 (SELECT $node_id FROM Movies WHERE ID = 1), 4.5),
 ((SELECT $node_id FROM Users WHERE ID = 8),
 (SELECT $node_id FROM Movies WHERE ID = 1), 2.3),
 ((SELECT $node_id FROM Users WHERE ID = 2),
 (SELECT $node_id FROM Movies WHERE ID = 2), 5),
 ((SELECT $node_id FROM Users WHERE ID = 3),
 (SELECT $node_id FROM Movies WHERE ID = 3), 3.4),
 ((SELECT $node_id FROM Users WHERE ID = 4),
 (SELECT $node_id FROM Movies WHERE ID = 3), 3.2),
 ((SELECT $node_id FROM Users WHERE ID = 6),
 (SELECT $node_id FROM Movies WHERE ID = 4), 1.2),
 ((SELECT $node_id FROM Users WHERE ID = 7),
 (SELECT $node_id FROM Movies WHERE ID = 4), 3.4),
 ((SELECT $node_id FROM Users WHERE ID = 1),
 (SELECT $node_id FROM Movies WHERE ID = 9), 4.5),
 ((SELECT $node_id FROM Users WHERE ID = 9),
 (SELECT $node_id FROM Movies WHERE ID = 4), 4.8),
 ((SELECT $node_id FROM Users WHERE ID = 10),
 (SELECT $node_id FROM Movies WHERE ID = 9), 4.3);
 GO
SELECT *
FROM Watching;

INSERT INTO Describing ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Movies WHERE ID = 1),
 (SELECT $node_id FROM Genres WHERE ID = 6)),
 ((SELECT $node_id FROM Movies WHERE ID = 5),
 (SELECT $node_id FROM Genres WHERE ID = 1)),
 ((SELECT $node_id FROM Movies WHERE ID = 8),
 (SELECT $node_id FROM Genres WHERE ID = 7)),
 ((SELECT $node_id FROM Movies WHERE ID = 2),
 (SELECT $node_id FROM Genres WHERE ID = 2)),
 ((SELECT $node_id FROM Movies WHERE ID = 3),
 (SELECT $node_id FROM Genres WHERE ID = 5)),
 ((SELECT $node_id FROM Movies WHERE ID = 4),
 (SELECT $node_id FROM Genres WHERE ID = 3)),
 ((SELECT $node_id FROM Movies WHERE ID = 6),
 (SELECT $node_id FROM Genres WHERE ID = 4)),
 ((SELECT $node_id FROM Movies WHERE ID = 7),
 (SELECT $node_id FROM Genres WHERE ID = 2)),
 ((SELECT $node_id FROM Movies WHERE ID = 1),
 (SELECT $node_id FROM Genres WHERE ID = 9)),
 ((SELECT $node_id FROM Movies WHERE ID = 9),
 (SELECT $node_id FROM Genres WHERE ID = 8)),
 ((SELECT $node_id FROM Movies WHERE ID = 10),
 (SELECT $node_id FROM Genres WHERE ID = 9));
 GO
SELECT *
FROM Describing;

SELECT User1.name, User2.name
FROM Users AS User1
	, Recommending
	, Users AS User2
WHERE MATCH(User1-(Recommending)->User2)
	AND User1.name = '�����';

SELECT u.name, m.name
FROM Users AS u
	, Watching AS w
	, Movies AS m
WHERE MATCH(u-(w)->m)
AND m.name = '������� ����';

SELECT m.name, g.name
FROM Movies AS m
	, Describing AS d
	, Genres as g
WHERE MATCH(m-(d)->g)
AND g.name = '������';

SELECT User1.name, User2.name
FROM Users AS User1
	, Recommending
	, Users AS User2
WHERE MATCH(User1-(Recommending)->User2)
	AND User1.name = '�������';

SELECT u.name, m.name, w.rating
FROM Users AS u
	, Watching AS w
	, Movies AS m
WHERE MATCH(u-(w)->m)
AND w.rating > 4;

SELECT User1.name
	, STRING_AGG(User2.name, '->') WITHIN GROUP (GRAPH PATH)
FROM Users AS User1
	, Recommending FOR PATH AS r
	, Users FOR PATH AS User2
WHERE MATCH(SHORTEST_PATH(User1(-(r)->User2)+))
	AND User1.name = '�������';

	SELECT User1.name
	, STRING_AGG(User2.name, '->') WITHIN GROUP (GRAPH PATH)
FROM Users AS User1
	, Recommending FOR PATH AS r
	, Users FOR PATH AS User2
WHERE MATCH(SHORTEST_PATH(User1(-(r)->User2){1,3}))
	AND User1.name = '�������';

	SELECT User1.ID AS IdFirst
	, User1.name AS First
	, CONCAT(N'user', User1.id) AS [First image name]
	, User2.ID AS IdSecond
	, User2.name AS Second
	, CONCAT(N'user', User2.id) AS [Second image name]
FROM Users AS User1
	, Recommending AS r
	, Users AS User2
WHERE MATCH(User1-(r)->User2);

	SELECT [User].ID AS IdFirst
	, [User].name AS First
	, CONCAT(N'user', [User].id) AS [First image name]
	, Movie.ID AS IdSecond
	, Movie.name AS Second
	, CONCAT(N'movie', Movie.id) AS [Second image name]
FROM Users AS [User]
	, Watching AS w
	, Movies AS Movie
WHERE MATCH([User]-(w)->Movie);

	SELECT Movie.ID AS IdFirst
	, Movie.name AS First
	, CONCAT(N'movie', Movie.id) AS [First image name]
	, Genre.ID AS IdSecond
	, Genre.name AS Second
	, CONCAT(N'genre', Genre.id) AS [Second image name]
FROM Movies AS Movie
	, Describing AS d
	, Genres AS Genre
WHERE MATCH(Movie-(d)->Genre);

select @@servername