create database imdb1
go
use imdb1

create table Director
(
	id int not null,
	name nvarchar(30) not null,
	gender char,
	age int,
	primary key(id)
)

GO
CREATE PROCEDURE UP_NAME
@id int, @name1 nvarchar(30),@uid int
AS
BEGIN
IF EXISTS(SELECT * FROM Admin_DB A WHERE A.id=@uid)
BEGIN
	UPDATE Director SET name=@name1 WHERE id=@id
END
ELSE
PRINT 'Administrator access required'
END

--SELECT Director.name FROM Director WHERE id=1
--EXECUTE UP_NAME @id=1,@name1='Patrick J Adams',@uid=4
--DROP PROCEDURE UP_NAME

GO
CREATE PROCEDURE UP_AGE
@id int, @age1 int,@uid int
AS
BEGIN
IF EXISTS(SELECT * FROM Admin_DB A WHERE A.id=@uid)
BEGIN
	UPDATE Director SET age=@age1 WHERE id=@id
END
ELSE
	PRINT 'Administrator access required'
END

--EXECUTE UP_AGE @id=1,@age1=70,@uid=6
--DROP PROCEDURE UP_AGE

alter table Director add constraint DIR_GEN check (gender in ('M','F'))

create table Actor --cast
(
	
	id int not null,
	name nvarchar(30) not null,
	gender char,
	age int,
	primary key(id)
)

GO
CREATE PROCEDURE UP_NAME_A
@id int, @name1 nvarchar(30),@uid int
AS
BEGIN
IF EXISTS(SELECT * FROM Admin_DB A WHERE A.id=@uid)
BEGIN
	UPDATE Actor SET name=@name1 WHERE id=@id
END
ELSE
	PRINT 'Administrator access required'
END

--EXECUTE UP_NAME_A @id=1,@name1='TEST',@uid=7
--DROP PROCEDURE UP_NAME_A

GO
CREATE PROCEDURE UP_AGE_A
@id int, @age1 int,@uid int
AS
BEGIN
IF EXISTS(SELECT * FROM Admin_DB A WHERE A.id=@uid)
BEGIN
	UPDATE Actor SET age=@age1 WHERE id=@id
END
ELSE
	PRINT 'Administrator access required'
END

--EXECUTE UP_AGE_A @id=1,@age1=70,@uid=4
--SELECT * FROM Actor
--DROP PROCEDURE UP_AGE_A

alter table Actor add constraint ACT_GEN check (gender in ('M','F'))

create table Users
(
	id nvarchar(30) not null,
	fname nvarchar(30) not null,
	lname nvarchar(30) not null,
	gender char,
	pin nvarchar(15) not null,
	country nvarchar(15),
	dob date,
	email nvarchar(25) not null,
	phoneno nvarchar(30),
	primary key (id)
)

GO
CREATE PROCEDURE UP_NAME_U
@id nvarchar(30), @name1 nvarchar(30),@name2 nvarchar(30),@uid int
AS
BEGIN
	UPDATE Users SET fname=@name1 WHERE id=@id
	UPDATE Users SET lname=@name2 WHERE id=@id
END

--EXECUTE UP_NAME_U @id='1',@name1='TEST',@name2='HERE',@uid=6	--Temp uid

GO
CREATE PROCEDURE UP_PIN
@id nvarchar(30), @pin1 nvarchar(15)
AS
BEGIN
UPDATE Users SET pin=@pin1 WHERE id=@id
END

--EXECUTE UP_PIN @id='1',@pin1='987654321'

GO
CREATE PROCEDURE UP_COUNTRY
@id nvarchar(30), @country1 nvarchar(15)
AS
BEGIN
UPDATE Users SET country=@country1 WHERE id=@id
END

--EXECUTE UP_COUNTRY @id='1',@country1='Malaysia'

alter table Users add constraint USR_GEN check (gender in ('M','F'))

create Table Admin_DB
(
	id nvarchar(30) not null,
	primary key(id),
	foreign key(id) references Users(id) on delete cascade on update cascade
)

GO
CREATE PROCEDURE ADMIN_ADD
@id nvarchar(30),@uid nvarchar(30)
AS
BEGIN
IF EXISTS(SELECT * FROM Admin_DB A WHERE A.id=@uid)
BEGIN
	INSERT INTO Admin_DB VALUES (@id)
END
ELSE
	PRINT 'Administrator access required'
END

--EXECUTE ADMIN_ADD @id='7',@uid='5'


GO
CREATE PROCEDURE ADMIN_DEL
@id nvarchar(30),@uid nvarchar(30)
AS
BEGIN
IF EXISTS(SELECT * FROM Admin_DB A WHERE A.id=@uid)
BEGIN
	DELETE FROM Admin_DB WHERE id=@id
END
ELSE
	PRINT 'Administrator access required'
END

--EXECUTE ADMIN_DEL @id='6',@uid='7'


create table Genre
(
	id int not null,
	category nvarchar(30) not null, --type
	primary key(id)
)


create table Movie
(
	id int not null,
	title nvarchar(30) not null,
	duration int not null,
	release_date date,
	genre int,
	summary nvarchar(300),
	rating decimal(2,1),
	--actor int,
	director int,
	path_img varchar(MAX),
	primary key(id),
	--foreign key(actor) references Actor(id),
	foreign key(director) references Director(id) on delete set null on update cascade,
	foreign key(genre) references Genre(id) on delete set null on update cascade
)

GO
CREATE PROCEDURE UP_RD
@id int, @date1 date,@uid int
AS
BEGIN
IF EXISTS(SELECT * FROM Admin_DB A WHERE A.id=@uid)
BEGIN
	UPDATE Movie SET release_date=@date1 WHERE id=@id
END
ELSE
	PRINT 'Administrator access required'
END

--EXECUTE UP_RD @id=1,@date1='2020-02-02',@uid=6
--DROP PROCEDURE UP_RD

GO
CREATE PROCEDURE UP_SUMM_M
@id int, @sum1 nvarchar(300),@uid int
AS
BEGIN
IF EXISTS(SELECT * FROM Admin_DB A WHERE A.id=@uid)
BEGIN
	UPDATE Movie SET summary=@sum1 WHERE id=@id
END
ELSE
	PRINT 'Administrator access required'
END

--EXECUTE UP_SUMM_M @id=1,@sum1='This is a test',@uid=6
--DROP PROCEDURE UP_SUMM_M


GO
CREATE PROCEDURE UP_RATING_M
@id int, @rat decimal(2,1),@uid int
AS
BEGIN
IF EXISTS(SELECT * FROM Admin_DB A WHERE A.id=@uid)
BEGIN
	UPDATE Movie SET rating=@rat WHERE id=@id
END
ELSE
	PRINT 'Administrator access required'
END

--EXECUTE UP_RATING_M @id=1,@rat=1.0,@uid=7
--DROP PROCEDURE UP_RATING_M

create table TV_Shows
(
	id int not null,
	title nvarchar(30),
	no_of_season int not null,
	release_date date,
	genre int,
	summary nvarchar(100),
	rating decimal(2,1),
	--actor int,
	director int,
	primary key(id),
	--foreign key(actor) references Actor(id) ,
	foreign key(director) references Director(id) on delete set null on update cascade,
	foreign key(genre) references Genre(id) on delete set null on update cascade
)

GO
CREATE PROCEDURE UP_NUM_OF_T
@id int, @temp int,@uid int
AS
BEGIN
IF EXISTS(SELECT * FROM Admin_DB A WHERE A.id=@uid)
BEGIN
	UPDATE TV_Shows SET no_of_season=@temp WHERE id=@id
END
ELSE
	PRINT 'Administrator access required'
END

--EXECUTE UP_NUM_OF_T @id=1,@temp=20,@uid=6
--DROP PROCEDURE UP_NUM_OF_T 

GO
CREATE PROCEDURE UP_RD_T
@id int, @date1 date
AS
BEGIN
UPDATE TV_Shows SET release_date=@date1 WHERE id=@id
END

--EXECUTE UP_RD_T @id=1,@date1='2020-03-03'

GO
CREATE PROCEDURE UP_SUMM_T
@id int, @sum1 nvarchar(300),@uid int
AS
BEGIN
IF EXISTS(SELECT * FROM Admin_DB A WHERE A.id=@uid)
BEGIN
	UPDATE TV_Shows SET summary=@sum1 WHERE id=@id
END
ELSE
	PRINT 'Administrator access required'
END

--EXECUTE UP_SUMM_T @id=1,@sum1='This is a test',@uid=7
--DROP PROCEDURE UP_SUMM_T

GO
CREATE PROCEDURE UP_RATING_T
@id int, @rat decimal(2,1),@uid int
AS
BEGIN
IF EXISTS(SELECT * FROM Admin_DB A WHERE A.id=@uid)
BEGIN
	UPDATE TV_Shows SET rating=@rat WHERE id=@id
END
ELSE
	PRINT 'Administrator access required'
END

--EXECUTE UP_RATING_T @id=1,@rat=0.5,@uid=7
--DROP PROCEDURE UP_RATING_T

create table Reviews 
(
	id int not null,
	movie_id int,
	tvshow_id int,
	reviewedby nvarchar(30),
	summary nvarchar(200),
	upvotes int,
	primary key(id),
	foreign key(movie_id) references Movie(id) on delete cascade on update cascade,
	foreign key(tvshow_id) references TV_Shows(id),
	foreign key(reviewedby) references Users(id) on delete cascade on update cascade 
)

GO
CREATE PROCEDURE UP_SUMM_R
@id int, @sum1 nvarchar(200)
AS
BEGIN
UPDATE Reviews SET summary=@sum1 WHERE id=@id
END

--EXECUTE UP_SUMM_R @id=1,@sum1='This is a test'

GO
CREATE PROCEDURE UP_VOTES
@id int, @temp int
AS
BEGIN
UPDATE Reviews SET upvotes=@temp WHERE id=@id
END

--EXECUTE UP_VOTES @id=1,@temp=10

create table Watchlist
(
	id int not null,
	userid nvarchar(30) not null,
	tvshow_id int,
	movie_id int,
	primary key(id,userid),
	foreign key(movie_id) references Movie(id) on delete set null on update cascade,
	foreign key(tvshow_id) references TV_Shows(id),
	foreign key(userid) references Users(id) on delete cascade on update cascade
)


create table Episodes
(
	id int not null,
	tvshow_id int not null,
	title nvarchar(30) not null,
	duration int not null,
	season_no int not null,
	primary key(id,tvshow_id),
	foreign key(tvshow_id) references TV_Shows(id) on delete cascade on update cascade,
	
)

create table supp_movies(
id int not null,
actor int not null,
foreign key(id) references Movie(id) on delete cascade on update cascade,
foreign key(actor) references Actor(id) on delete cascade on update cascade
)

create table supp_tvshows(
id int not null,
actor int not null,
foreign key(id) references TV_Shows(id) on delete cascade on update cascade,
foreign key(actor) references Actor(id) on delete cascade on update cascade
)


INSERT INTO Actor VALUES (1,'Robert Downey Jr.','M',53)
INSERT INTO Actor VALUES (2,'Chris Hemsworth','M',35)
INSERT INTO Actor VALUES (3,'Chris Evans','M',37)
INSERT INTO Actor VALUES (4,'Benedict Cumberbatch','M',42)
INSERT INTO Actor VALUES (5,'Hugh Jackman','M',50)
INSERT INTO Actor VALUES (6,'Leonardo DiCaprio','M',44)
INSERT INTO Actor VALUES (7,'Tom Cruise','M',56)
INSERT INTO Actor VALUES (8,'Matt Damon','M',48)
INSERT INTO Actor VALUES (9,'Johnny Depp','M',55)
INSERT INTO Actor VALUES (10,'Denzel Washington','M',64)
INSERT INTO Actor VALUES (11,'Scarlett Johansson','F',34)
INSERT INTO Actor VALUES (12,'Jennifer Lawrence','F',28)
INSERT INTO Actor VALUES (13,'Megan Fox','F',32)
INSERT INTO Actor VALUES (14,'Emma Stone','F',30)
INSERT INTO Actor VALUES (15,'Anne Hathaway','F',36)
INSERT INTO Actor VALUES (16,'Gal Gadot','F',33)
INSERT INTO Actor VALUES (17,'Margot Robbie','F',28)
INSERT INTO Actor VALUES (18,'Cara Delivingne','F',26)
INSERT INTO Actor VALUES (19,'Natalie Portman','F',37)
INSERT INTO Actor VALUES (20,'Charlize Theron','F',43)
INSERT INTO Actor VALUES (21,'Tom Hardy','M',41)
INSERT INTO Actor VALUES (22,'Joseph Morgan','M',37)
INSERT INTO Actor VALUES (23,'Ian Somerhalder','M',40)
INSERT INTO Actor VALUES (24,'Gabriel Macht','M',47)
INSERT INTO Actor VALUES (25,'Daniel Gillies','M',43)
INSERT INTO Actor VALUES (26,'John Krasinski','M',39)
INSERT INTO Actor VALUES (27,'Mads Mikkelson','M',53)
INSERT INTO Actor VALUES (28,'Hugh Dancy','M',43)
INSERT INTO Actor VALUES (29,'J.K. Simmons`','M',64)
INSERT INTO Actor VALUES (30,'John Bernthal','M',42)
INSERT INTO Actor VALUES (31,'Amber Rose Revah','F',32)
INSERT INTO Actor VALUES (32,'Nazanin Boniadi','F',38)
INSERT INTO Actor VALUES (33,'Caroline Dhavernas','F',40)
INSERT INTO Actor VALUES (34,'Abbie Cornish','F',36)
INSERT INTO Actor VALUES (35,'Phoebe Tonkin','F',39)
INSERT INTO Actor VALUES (36,'Claire Holt','F',30)
INSERT INTO Actor VALUES (37,'Meghan Harry','F',37) --markle :P
INSERT INTO Actor VALUES (38,'Nina Dobrev','F',30)
INSERT INTO Actor VALUES (39,'Sophie Rundle','F',30)
INSERT INTO Actor VALUES (40,'Gina Torres','F',49)
INSERT INTO Actor VALUES (41,'Christian Bale','M',49)
INSERT INTO Actor VALUES (42,'Vin Diesel','M',51)
INSERT INTO Actor VALUES (43,'Paul Walker','M',41)
INSERT INTO Actor VALUES (44,'Brad Pitt','M',53)
INSERT INTO Actor VALUES (45,'Leonardo DiCaprio','M',49)
INSERT INTO Actor VALUES (46,'Morgan Freeman','M',67)
INSERT INTO Actor VALUES (47,'Margot Robbie','F',32)
INSERT INTO Actor VALUES (48,'Jennifer Aniston','F',50)
INSERT INTO Actor VALUES (49,'Mathew Perry','M',56)
INSERT INTO Actor VALUES (50,'Jon Travolta','M',65)
INSERT INTO Actor VALUES (51,'Patric Wilson','M',41)
INSERT INTO Actor VALUES (52,'Bradley Cooper','M',42)
INSERT INTO Actor VALUES (53,'Jason Bigs','M',37)
INSERT INTO Actor VALUES (54,'Sophia Lils','F',17)
INSERT INTO Actor VALUES (55,'Iain Armintage','M',14)
INSERT INTO Actor VALUES (56,'Jim Parsons','M',40)
INSERT INTO Actor VALUES (57,'Benatich Cumberbach','M',43)

INSERT INTO Director VALUES (1,'Patrick J. Adams','M',37)	--Suits
INSERT INTO Director VALUES (2,'John Dahl','M',62)			--TVD
INSERT INTO Director VALUES (3,'Mortan Tyldum','M',51)		--Counterpart
INSERT INTO Director VALUES (4,'Julie Plec','F',46)			--The Originals
INSERT INTO Director VALUES (5,'Adam Kane','M',51)			--Hannibal
INSERT INTO Director VALUES (6,'Joe Russo','M',47)			--Avengers
INSERT INTO Director VALUES (7,'Jon Faverau','M',52)		--Iron Man
INSERT INTO Director VALUES (8,'Petty Jenkins','F',47)		--WonderWoman
INSERT INTO Director VALUES (9,'Antoin Faqua','M',53)		--The Equalizer
INSERT INTO Director VALUES (10,'Christopher Nolan','M',48)	--Interstellar
INSERT INTO Director VALUES (11,'Quientin Tarantino','M',55)
INSERT INTO Director VALUES (12,'Justin Lin','M',40)
INSERT INTO Director VALUES (13,'James Wann','M',37) --patric wilson
INSERT INTO Director VALUES (14,'Todd Philips','M',58) --bradley coper
INSERT INTO Director VALUES (15,'Chris Weitz','M',55) --jason bigs, ap
INSERT INTO Director VALUES (16,'James Cameron','M',68)
INSERT INTO Director VALUES (17,'Andr�s Muschietti','M',31) --sophia lils, it
INSERT INTO Director VALUES (18,'Rob Letterman','M',38)
INSERT INTO Director VALUES (19,'Neil Marshal','M',44)
INSERT INTO Director VALUES (20,'David Sandberg','M',48)
INSERT INTO Director VALUES (21,'James Burrows','M',56) 
INSERT INTO Director VALUES (22,'Chuck Lorre','M',41)
INSERT INTO Director VALUES (23,'Toby Haynes','M',51)

INSERT INTO Genre VALUES (1,'Action')
INSERT INTO Genre VALUES (2,'Drama')
INSERT INTO Genre VALUES (3,'Sci-Fi')
INSERT INTO Genre VALUES (4,'Horror')
INSERT INTO Genre VALUES (5,'Comedy')


INSERT INTO Users VALUES ('1','Aaron','Malik','M','12345','Pakistan','2018-12-20','aaron@yahoo.com','042311223344')
INSERT INTO Users VALUES ('2','Megan','Malik','F','123456','India','2008-12-18','megan@yahoo.com','042311223344')
INSERT INTO Users VALUES ('3','Danish','Ali','M','1234545','Kenya','2009-6-20','danish@yahoo.com','042311223344')
INSERT INTO Users VALUES ('4','Malik','Malik','M','1256664','Australia','1998-12-20','malik@hotmail.com','042311223344')
INSERT INTO Users VALUES ('5','Usama','Malik','M','1756894','America','1999-6-2','usama@hotmail.com','042311223344')
INSERT INTO Users VALUES ('6','Shehzar','Malik','M','1865643','United Kingdom','1999-5-25','shehzar@hotmail.com','042311223344')
INSERT INTO Users VALUES ('7','Aiman','Malik','F','123958545','Pakistan','2000-8-19','aiman@gmail.com','042311223344')
INSERT INTO Users VALUES ('8','Ezzah','Malik','F','1203842345','Russia','1997-2-4','ezzah@gmail.com','042311223344')
INSERT INTO Users VALUES ('9','Zara','Malik','F','1234823015','India','2000-7-10','zara@gmail.com','042311223344')
INSERT INTO Users VALUES ('10','Faheem','Malik','M','1283721345','Pakistan','1998-2-15','faheem@gmail.com','042311223344')

INSERT INTO Admin_DB VALUES ('3')
INSERT INTO Admin_DB VALUES ('4')
INSERT INTO Admin_DB VALUES ('5')
INSERT INTO Admin_DB VALUES ('6')

INSERT INTO Movie VALUES (1,'Avengers:Age of Ultron',135,'2015-4-13',1,NULL,7.4,6,'~/Content/Logo1.png')
INSERT INTO Movie VALUES (2,'Wonder Woman',150,'2017-5-15',1,NULL,7.8,8,NULL)
INSERT INTO Movie VALUES (3,'Avengers:Assemble',130,'2012-4-23',1,NULL,8.4,6,NULL)
INSERT INTO Movie VALUES (4,'Avengers:Infinity War',145,'2018-4-3',1,NULL,8.2,6,NULL)
INSERT INTO Movie VALUES (5,'Avengers:Endgame',180,'2019-4-26',1,NULL,9.9,6,NULL)
INSERT INTO Movie VALUES (6,'Fast and Furious',105,'2001-2-23',1,NULL,8.2,12,NULL)
INSERT INTO Movie VALUES (7,'2 Fast 2 Furious',115,'2002-4-03',1,NULL,7.3,12,NULL)
INSERT INTO Movie VALUES (8,'Fast and Furious: Tokyo Drift',105,'2004-1-05',1,NULL,7.5,12,NULL)
INSERT INTO Movie VALUES (9,'Fast and Furious 4',105,'2007-2-23',1,NULL,7.7,12,NULL)
INSERT INTO Movie VALUES (10,'Fast 5',105,'2011-2-3',1,NULL,7.9,12,NULL)
INSERT INTO Movie VALUES (11,'Furious 6',105,'2013-1-1',1,NULL,8.4,12,NULL)
INSERT INTO Movie VALUES (12,'Fate of the Furious',105,'2017-2-1',1,NULL,7.4,12,NULL)
INSERT INTO Movie VALUES (13,'American Pie',121,'1999-4-3',5,NULL,6.4,15,NULL)
INSERT INTO Movie VALUES (14,'American Pie 2',132,'2000-5-3',5,NULL,5.4,15,NULL)
INSERT INTO Movie VALUES (15,'American Wedding',133,'2001-6-13',5,NULL,8.4,15,NULL)
INSERT INTO Movie VALUES (16,'American Pie: Band Camp',134,'2004-7-1',5,NULL,7.4,15,NULL)
INSERT INTO Movie VALUES (17,'American Pie: Naked Mile',135,'2005-8-23',5,NULL,7.1,15,NULL)
INSERT INTO Movie VALUES (18,'American Pie: Beta House',136,'2006-9-1',5,NULL,7.3,15,NULL)
INSERT INTO Movie VALUES (19,'American Pie: The Book of Love',137,'2007-10-12',5,NULL,7.2,15,NULL)
INSERT INTO Movie VALUES (20,'Hangover',105,'2009-8-4',5,NULL,7.9,14,NULL)
INSERT INTO Movie VALUES (21,'Hangover Part 1',115,'2011-7-24',5,NULL,7.7,14,NULL)
INSERT INTO Movie VALUES (22,'Hangover Part 2',145,'2013-6-14',5,NULL,7.5,14,NULL)
INSERT INTO Movie VALUES (23,'Once Upon a Time In Hollywood',119,'2019-7-17',2,NULL,8.4,11,NULL)
INSERT INTO Movie VALUES (24,'Pulp Fiction',129,'1994-9-28',2,NULL,8.1,11,NULL)
INSERT INTO Movie VALUES (25,'Django Unchained',139,'2013-2-2',2,NULL,8.3,11,NULL)
INSERT INTO Movie VALUES (26,'Reservior Dogs',149,'1999-1-23',2,NULL,7.3,11,NULL)
INSERT INTO Movie VALUES (27,'Inglourious Basterds',159,'2013-3-13',2,NULL,7.4,11,NULL)
INSERT INTO Movie VALUES (28,'Batman Begins',122,'2005-7-20',1,NULL,7.6,10,NULL)
INSERT INTO Movie VALUES (29,'The Dark Knight',133,'2008-3-1',1,NULL,7.5,10,NULL)
INSERT INTO Movie VALUES (30,'The Dark Knight Rises',147,'2012-1-3',1,NULL,7.1,10,NULL)
INSERT INTO Movie VALUES (31,'Inception',147,'2010-4-5',1,NULL,7.8,10,NULL)
INSERT INTO Movie VALUES (32,'Interstellar',167,'2014-1-9',3,NULL,7.3,10,NULL)
INSERT INTO Movie VALUES (33,'Dunkirk',127,'2017-2-13',1,NULL,7.1,10,NULL)
INSERT INTO Movie VALUES (34,'IT',135,'2018-3-8',4,NULL,7.4,17,NULL)
INSERT INTO Movie VALUES (35,'Insidious Chapter 1',116,'2009-8-16',4,NULL,6.4,13,NULL)
INSERT INTO Movie VALUES (36,'Insidious: Chapter 2',167,'2010-6-18',4,NULL,6.3,13,NULL)
INSERT INTO Movie VALUES (37,'Insidious: Chapter 3',198,'2012-1-3',4,NULL,6.1,13,NULL)
INSERT INTO Movie VALUES (38,'Avatar',167,'2009-1-9',3,NULL,8.5,16,NULL)
INSERT INTO Movie VALUES (39,'Shazam',167,'2019-9-19',3,NULL,6.5,20,NULL)
INSERT INTO Movie VALUES (40,'Pokemon: Detective Pikachu',167,'2019-8-9',3,NULL,5.5,18,NULL)
INSERT INTO Movie VALUES (41,'Hell Boy',167,'2019-10-9',3,NULL,6.5,19,NULL)

INSERT INTO TV_Shows VALUES (1,'Friends',10,'1994-1-1',5,'Couple of friends Joke around for six years and then all get married.',9.4,21)
INSERT INTO TV_Shows VALUES (2,'Suits',8,'2011-11-11',2,'Cooperate Lawyer and a Fake Lawyler kick ass',8.4,1)
INSERT INTO TV_Shows VALUES (3,'Young Sheldon',2,'2017-2-2',5,'Child is sarcastic and genius',7.3,22)
INSERT INTO TV_Shows VALUES (4,'Big Bang Theory',12,'2007-3-7',5,'A couple of nerds and penny eat while joking around',8.7,22)
INSERT INTO TV_Shows VALUES (5,'Sherlock',4,'2011-7-11',5,'Dude got an xray vision and solving mystery kind of mind',9.4,23)


INSERT INTO Episodes VALUES (1,1,'One with Rachel',22,1)
INSERT INTO Episodes VALUES (2,1,'One with Monica',22,1)
INSERT INTO Episodes VALUES (3,1,'One with Joey',22,1)
INSERT INTO Episodes VALUES (4,1,'One with Chandler',22,1)
INSERT INTO Episodes VALUES (5,1,'One with Pheobe',22,1)
INSERT INTO Episodes VALUES (6,1,'One with Ross',22,1)
INSERT INTO Episodes VALUES (7,1,'One with Gunter',22,1)
INSERT INTO Episodes VALUES (8,1,'One with Emily',22,1)
INSERT INTO Episodes VALUES (9,1,'One with Richard',22,1)
INSERT INTO Episodes VALUES (10,1,'One with Vegas',22,1)
INSERT INTO Episodes VALUES (11,4,'Sheldon is a genius',22,1)
INSERT INTO Episodes VALUES (12,4,'Leonard like penny',22,1)
INSERT INTO Episodes VALUES (13,4,'Danish made me do this',22,1)
INSERT INTO Episodes VALUES (14,4,'He sucks',22,1)
INSERT INTO Episodes VALUES (15,4,'I hate typing',22,1)
INSERT INTO Episodes VALUES (16,4,'No more Database',22,1)
INSERT INTO Episodes VALUES (17,4,'Not Watching tbbt',22,1)
INSERT INTO Episodes VALUES (18,4,'Raj is an indian',22,1)
INSERT INTO Episodes VALUES (19,4,'Bernadatte is cute',22,1)
INSERT INTO Episodes VALUES (20,4,'Penny is hot',22,1)
INSERT INTO Episodes VALUES (21,4,'I dont like Amy',22,1)
INSERT INTO Episodes VALUES (22,4,'End',22,1)
INSERT INTO Episodes VALUES (23,2,'Mike becames lawyer',22,1)
INSERT INTO Episodes VALUES (24,2,'Harvey is big deal',22,1)
INSERT INTO Episodes VALUES (25,2,'Louis is a heel',22,1)
INSERT INTO Episodes VALUES (26,2,'Jessica is bad ass',22,1)
INSERT INTO Episodes VALUES (27,2,'Mike connects',22,1)
INSERT INTO Episodes VALUES (28,2,'Mike in jail',22,1)
INSERT INTO Episodes VALUES (29,2,'Mike back',22,1)
INSERT INTO Episodes VALUES (30,2,'Mike gone',22,1)
INSERT INTO Episodes VALUES (31,2,'Bore',22,1)
INSERT INTO Episodes VALUES (32,3,'Sarcastic child',22,1)
INSERT INTO Episodes VALUES (33,3,'Fun jokes',22,1)
INSERT INTO Episodes VALUES (34,5,'Pilot',22,1)
INSERT INTO Episodes VALUES (35,5,'Scandal in Belgarvia',22,1)
INSERT INTO Episodes VALUES (36,5,'Taxi Driver',22,1)
INSERT INTO Episodes VALUES (37,5,'Bad ass sibling',22,1)



INSERT INTO Reviews VALUES (1,1,NULL,'6','Best Marvel Movie ever',4)
INSERT INTO Reviews VALUES (2,2,NULL,'1','You dont see women in lead role everyday',4)
INSERT INTO Reviews VALUES (3,3,NULL,'6','Fantasy World at its best',4)
INSERT INTO Reviews VALUES (4,4,NULL,'1','This couldnt be more interesting',4)
INSERT INTO Reviews VALUES (5,5,NULL,'6','Best one in the series',4)

INSERT INTO Reviews VALUES (6,NULL,1,'1','Chandlers sarcasm is the best',4)
INSERT INTO Reviews VALUES (7,NULL,2,'2','Harvey Spectre just got lit up',4)
INSERT INTO Reviews VALUES (8,NULL,3,'3','Kids an einstein',4)
INSERT INTO Reviews VALUES (9,NULL,4,'4','Loved Howards Flirting with Penny',4)
INSERT INTO Reviews VALUES (10,NULL,5,'6','No one like Sherlock',4)


INSERT INTO Watchlist VALUES (1,'1',1,1)
INSERT INTO Watchlist VALUES (2,'1',2,2)
INSERT INTO Watchlist VALUES (3,'1',4,3)
INSERT INTO Watchlist VALUES (4,'2',5,4)
INSERT INTO Watchlist VALUES (5,'2',3,5)
INSERT INTO Watchlist VALUES (6,'2',1,5)
INSERT INTO Watchlist VALUES (7,'3',3,17)
INSERT INTO Watchlist VALUES (8,'3',2,8)
INSERT INTO Watchlist VALUES (9,'3',1,9)
INSERT INTO Watchlist VALUES (10,'4',1,10)
INSERT INTO Watchlist VALUES (11,'4',3,11)
INSERT INTO Watchlist VALUES (12,'4',5,12)
INSERT INTO Watchlist VALUES (13,'5',5,13)
INSERT INTO Watchlist VALUES (14,'5',2,14)
INSERT INTO Watchlist VALUES (15,'5',1,15)
INSERT INTO Watchlist VALUES (16,'6',5,16)
INSERT INTO Watchlist VALUES (17,'6',4,17)
INSERT INTO Watchlist VALUES (18,'6',1,18)
INSERT INTO Watchlist VALUES (19,'7',NULL,19)
INSERT INTO Watchlist VALUES (20,'7',NULL,11)
INSERT INTO Watchlist VALUES (21,'7',NULL,12)
INSERT INTO Watchlist VALUES (22,'8',NULL,13)
INSERT INTO Watchlist VALUES (23,'8',NULL,14)
INSERT INTO Watchlist VALUES (24,'8',NULL,15)
INSERT INTO Watchlist VALUES (25,'9',NULL,16)
INSERT INTO Watchlist VALUES (26,'9',NULL,17)
INSERT INTO Watchlist VALUES (27,'9',NULL,18)
INSERT INTO Watchlist VALUES (28,'10',NULL,31)
INSERT INTO Watchlist VALUES (29,'10',NULL,12)
INSERT INTO Watchlist VALUES (30,'10',NULL,11)


--INSERT INTO supp_movies VALUES (1,1)
--INSERT INTO supp_movies VALUES (1,2)
INSERT INTO supp_movies VALUES (1,1)	--Avengers
INSERT INTO supp_movies VALUES (1,2)
INSERT INTO supp_movies VALUES (1,3)
INSERT INTO supp_movies VALUES (1,11)

INSERT INTO supp_movies VALUES (2,16)	--WonderWoman
INSERT INTO supp_movies VALUES (2,19)

INSERT INTO supp_movies VALUES (3,1)	--Avengers:Assemble
INSERT INTO supp_movies VALUES (2,2)
INSERT INTO supp_movies VALUES (3,3)
INSERT INTO supp_movies VALUES (3,11)
INSERT INTO supp_movies VALUES (3,4)

INSERT INTO supp_movies VALUES (4,1)	--Avengers:Infinity War
INSERT INTO supp_movies VALUES (4,2)
INSERT INTO supp_movies VALUES (4,3)
INSERT INTO supp_movies VALUES (4,11)
INSERT INTO supp_movies VALUES (4,4)

INSERT INTO supp_movies VALUES (5,1)	--Avengers:Endgame
INSERT INTO supp_movies VALUES (5,2)
INSERT INTO supp_movies VALUES (5,3)
INSERT INTO supp_movies VALUES (5,11)
INSERT INTO supp_movies VALUES (5,4)

INSERT INTO supp_movies VALUES (6,42)	--F&F
INSERT INTO supp_movies VALUES (6,43)

INSERT INTO supp_movies VALUES (7,42)	--F&F
INSERT INTO supp_movies VALUES (7,43)

INSERT INTO supp_movies VALUES (8,42)	--F&F
INSERT INTO supp_movies VALUES (8,43)

INSERT INTO supp_movies VALUES (9,42)	--F&F
INSERT INTO supp_movies VALUES (9,43)

INSERT INTO supp_movies VALUES (10,42)	--F&F
INSERT INTO supp_movies VALUES (10,43)

INSERT INTO supp_movies VALUES (11,42)	--F&F
INSERT INTO supp_movies VALUES (11,43)

INSERT INTO supp_movies VALUES (12,42)	--F&F
INSERT INTO supp_movies VALUES (12,43)

INSERT INTO supp_movies VALUES (13,53)	--American Pie

INSERT INTO supp_movies VALUES (14,53)

INSERT INTO supp_movies VALUES (15,53)

INSERT INTO supp_movies VALUES (16,53)

INSERT INTO supp_movies VALUES (17,53)

INSERT INTO supp_movies VALUES (18,53)

INSERT INTO supp_movies VALUES (19,53)

INSERT INTO supp_movies VALUES (20,52)	--Hangover

INSERT INTO supp_movies VALUES (21,52)

INSERT INTO supp_movies VALUES (22,52)

INSERT INTO supp_movies VALUES (23,6)	--OUaTiH
INSERT INTO supp_movies VALUES (23,44)
INSERT INTO supp_movies VALUES (23,17)

INSERT INTO supp_movies VALUES (24,50)	--Pulp Fiction

INSERT INTO supp_movies VALUES (25,46)	--Django Unchained

INSERT INTO supp_movies VALUES (26,50)	--Reservoir Dogs

INSERT INTO supp_movies VALUES (27,46)	--Inglorius Bastards

INSERT INTO supp_movies VALUES (28,41)	--Batman
INSERT INTO supp_movies VALUES (28,46)

INSERT INTO supp_movies VALUES (29,41)
INSERT INTO supp_movies VALUES (29,46)

INSERT INTO supp_movies VALUES (30,41)
INSERT INTO supp_movies VALUES (30,46)

INSERT INTO supp_movies VALUES (31,6)	--Inception

INSERT INTO supp_movies VALUES (32,15)	--Interstellar

INSERT INTO supp_movies VALUES (33,44)	--Dunkirk

INSERT INTO supp_movies VALUES (34,54)	--IT

INSERT INTO supp_movies VALUES (35,51)	--Insidious

INSERT INTO supp_movies VALUES (36,51)

INSERT INTO supp_movies VALUES (37,51)

INSERT INTO supp_movies VALUES (38,22)	--Avatar

INSERT INTO supp_movies VALUES (39,36)	--Shazam

INSERT INTO supp_movies VALUES (40,39)	--Pokemon

INSERT INTO supp_movies VALUES (31,51)	--Hell Boy

SELECT * FROM supp_movies

INSERT INTO supp_tvshows VALUES (1,48)	--Friends
INSERT INTO supp_tvshows VALUES (1,49)

INSERT INTO supp_tvshows VALUES (2,24)	--Suits
INSERT INTO supp_tvshows VALUES (2,37)
INSERT INTO supp_tvshows VALUES (2,40)

INSERT INTO supp_tvshows VALUES (3,55)	--Young Sheldon

INSERT INTO supp_tvshows VALUES (4,56)	--TBBT

INSERT INTO supp_tvshows VALUES (5,4)	--Sherlock

select* from Movie
select* from Actor
select* from Director
select* from TV_Shows
select* from Episodes
select* from Reviews
select* from Users
select* from Watchlist
select* from Admin_DB


SELECT M.title, A.name					--Movies
FROM Movie M
JOIN supp_movies S
ON M.id=S.id
JOIN supp_movies SM
ON S.actor=SM.actor
JOIN Actor A
ON SM.actor=A.id
GROUP BY M.title, A.name

SELECT T.title, A.name					--TV_Shows
FROM TV_Shows T
JOIN supp_tvshows S
ON T.id=S.id
JOIN supp_tvshows ST
ON S.actor=ST.actor
JOIN Actor A
ON ST.actor=A.id
GROUP BY T.title, A.name

--MOVIES DISPLAY
GO
CREATE PROCEDURE Movie_Display
@id int, @name nvarchar(30), @output varchar(200)
AS
BEGIN
SELECT @output=M.path_img FROM Movie M WHERE M.id=@id AND M.title=@name
END

--Insert Into Movies

GO
CREATE PROCEDURE MOVIE_INSERT
@id int,@name nvarchar(30), @duration int, @release date, @genre int, @summary nvarchar(300), @rating decimal(2,1), @director int
as
begin
INSERT INTO Movie VALUES(@id,@name,@duration,@release,@genre,@summary,@rating,@director)
end

--DROP PROCEDURE MOVIE_INSERT

--EXECUTE MOVIE_INSERT @id=42,@name='test',@duration=180,@release=NULL,@genre=1,@summary=NULL,@rating=2,@director=1
--SELECT * FROM Movie

--DELETE FROM MOVIES

GO 
CREATE PROCEDURE MOVIE_DELETE
@id int, @name nvarchar(30)
as
begin
DELETE FROM Movie WHERE Movie.id=@id AND Movie.title=@name
end

--EXECUTE MOVIE_DELETE @id=42,@name='test'


--INSERT INTO TV_SHOWS
GO
CREATE PROCEDURE TV_INSERT
@id int,@name nvarchar(30), @num_seasons int, @release date, @genre int, @summary nvarchar(300), @rating decimal(2,1), @director int
AS
BEGIN
INSERT INTO TV_Shows VALUES(@id,@name, @num_seasons, @release, @genre, @summary, @rating, @director)
END

--EXECUTE TV_INSERT @id=6,@name='test',@num_seasons=3,@release=NULL,@genre=2,@summary=NULL,@rating=4,@director=3
--SELECT * FROM TV_Shows

--DELETE FROM TV_SHOWS
GO
CREATE PROCEDURE TV_DEL
@id int, @name nvarchar(30)
AS
BEGIN
DELETE FROM TV_Shows WHERE TV_Shows.id=@id AND TV_Shows.title=@name
END

--EXECUTE TV_DEL @id=6,@name='test'

--INSERT INTO GENRE
GO
CREATE PROCEDURE GENRE_ADD
@id int, @cat nvarchar(30)
AS
BEGIN
INSERT INTO Genre VALUES(@id,@cat)
END

--EXECUTE GENRE_ADD @id=6,@cat='Funny'
--SELECT * FROM Genre

--DELETE FROM GENRE
GO
CREATE PROCEDURE GENRE_DELETE
@id int
AS
BEGIN
DELETE FROM Genre WHERE Genre.id=@id
END

--EXECUTE GENRE_DELETE @id=6


--INSERT INTO sup tv
GO
CREATE PROCEDURE supTV_ADD
@id int, @actor int
AS
BEGIN
INSERT INTO supp_tvshows VALUES(@id,@actor)
END

--EXECUTE supTV_ADD @id=1,@actor=4

--DELETE FROM sup tv by actor id
GO
create procedure supTv_del 
@id int, @tid int
AS
BEGIN
DELETE FROM supp_tvshows WHERE supp_tvshows.actor=@id AND supp_tvshows.id=@tid
END

--DROP PROCEDURE supTv_del

--EXECUTE supTv_del @id=4,@tid=1

--INSERT INTO sup movie
GO
CREATE PROCEDURE supmovie_ADD
@id int, @actor int
AS
BEGIN
INSERT INTO supp_movies VALUES(@id,@actor)
END

--EXECUTE supmovie_ADD @id=1,@actor=6

--DELETE FROM sup movie by actor id
GO
create procedure supmovie_del 
@id int, @mid int
AS
BEGIN
DELETE FROM supp_movies WHERE supp_movies.actor=@id AND supp_movies.id=@mid
END

--DROP PROCEDURE supmovie_del
--EXECUTE supmovie_del @id=6,@mid=1


--INSERT INTO episode
GO
CREATE PROCEDURE epi_ADD
@id int,@tid int,@t nvarchar(30),@duration int, @s int
AS
BEGIN
INSERT INTO Episodes VALUES(@id,@tid,@t,@duration,@s)
END

--EXECUTE epi_ADD @id=11,@tid=2,@t='Test',@duration=25,@s=1

--DELETE FROM episodes
GO
create procedure epi_del 
@id int,@sno int
AS
BEGIN
DELETE FROM Episodes WHERE Episodes.id=@id and Episodes.season_no=@sno
END

--EXECUTE epi_del @id=11,@sno=1

--INSERT INTO Users
GO
CREATE PROCEDURE Users_ADD
@id nvarchar(30), @fn nvarchar(30), @ln nvarchar(30),@gen char,@pin nvarchar(15),@country nvarchar(15),@dob date,@email nvarchar(25),@phoneno nvarchar(30),
@output int OUTPUT
AS
BEGIN
if not exists(select * from Users where id=@id and pin=@pin)
Begin
INSERT INTO Users VALUES(@id,@fn,@ln,@gen,@pin,@country,@dob,@email,@phoneno)
SET @output=1
end
else
begin
SET @output=0
end
END


--DROP PROCEDURE Users_ADD
--declare @myout int
--EXECUTE Users_ADD @id='11',@fn='Test',@ln='Here',@gen='M',@pin='12345',@country='Hello',@dob='2020-05-05',@email='hello@gmail.com',@phoneno='04234567890', 
--@output=@myout OUTPUT
--SELECT @myout STATUSS

--DELETE FROM Users
GO
create procedure User_del 
--@n nvarchar(30),@n1 nvarchar(30),@p nvarchar(15)
@username nvarchar(30),@output int
AS
BEGIN
IF EXISTS(SELECT * FROM Users WHERE Users.id=@username)
BEGIN
DELETE FROM Users WHERE Users.id=@username
SET @output=1
RETURN
END
SET @output=0
END

--EXECUTE User_del @n='Test',@n1='Here',@p='12345'

--Login
go
create procedure Loginn @id nvarchar(30),@pin nvarchar(15),@output int OUTPUT
as begin
	if not exists( select * from Users where id=@id and pin=@pin)
	begin
	set @output=0
	--print 'Incorrect Credentials'
	return
	end
	set @output=1
end



--INSERT INTO Review
GO
CREATE PROCEDURE Review_ADD
@id int, @mid int ,@tid int,@uid int, @s nvarchar(200),@up int
AS
BEGIN
INSERT INTO Reviews VALUES(@id,@mid,@tid,@uid,@s,@up)
END

--EXECUTE Review_ADD @id=40,@mid=1,@tid=NULL,@uid=5,@s='This is a test',@up=20

--DELETE FROM Review
GO
create procedure Review_del 
@id int
AS
BEGIN
DELETE FROM Reviews WHERE Reviews.id=@id
END

--EXECUTE Review_del @id=40

--INSERT INTO watchlist
GO
CREATE PROCEDURE Watchlist_ADD
@id int, @uid int, @tid int , @mid int
AS
BEGIN
INSERT INTO Watchlist VALUES(@id,@uid,@tid,@mid)
END

--EXECUTE Watchlist_ADD @id=100,@uid=5,@tid=3,@mid=NULL

--DELETE ALL ENTRIES OF A USER FROM Watchlist
GO
create procedure Watchlist_del 
@id int
AS
BEGIN
DELETE FROM Watchlist WHERE Watchlist.userid=@id
END

--DROP PROCEDURE Watchlist_del
--EXECUTE Watchlist_del @id=5
--SELECT * FROM Watchlist

--INSERT INTO Director
GO
CREATE PROCEDURE Director_ADD
@id int,@n nvarchar(30),@g char,@age int
AS
BEGIN
INSERT INTO Actor VALUES(@id,@n,@g,@age)
END

--EXECUTE Director_ADD @id=100,@n='Test',@g='M',@age=70

--DELETE FROM Director
GO
create procedure Director_del 
@id int,@n nvarchar(30)
AS
BEGIN
DELETE FROM Director WHERE Director.id=@id and Director.name=@n
END

--EXECUTE Director_del @id=100,@n='Test'

--INSERT INTO actor
GO
CREATE PROCEDURE actor_ADD
@id int,@n nvarchar(30),@g char,@age int
AS
BEGIN
INSERT INTO Actor VALUES(@id,@n,@g,@age)
END

--EXECUTE actor_ADD @id=500,@n='Test',@g='M',@age=70

--SELECT * FROM Actor

--DELETE FROM actor
GO
create procedure actor_del 
@id int,@n nvarchar(30)
AS
BEGIN
DELETE FROM Actor WHERE Actor.id=@id and Actor.name=@n
END
--EXECUTE actor_del @id=500,@n='Test'



--INFO OF MOVIE BY NAME
go
create procedure search_movie @parameter nvarchar(30) as
begin
	if exists(select * from Movie where title=@parameter)
	begin
		declare @result nvarchar(500)
		set @result=''
		select @result=@result+ Actor.name+', ' from supp_movies join Movie on supp_movies.id=Movie.id join Actor on supp_movies.actor=Actor.id where Movie.title=@parameter
		select  title,duration,category,rating,@result as actors,Director.name as director from Movie  join Genre on Genre.id=Movie.genre join Director on Director.id=Movie.director where @parameter=title
		return
	end
	
end
--execute search_movie @parameter='Fast and Furious'
--drop procedure search_movie


--INFO OF TV SHOW BY NAME
go
create procedure search_show @parameter nvarchar(30) as
begin
	if exists(select * from TV_Shows where title=@parameter)
	begin
		declare @result nvarchar(500)
		set @result=''
		select @result=@result+ Actor.name+', ' from supp_tvshows join TV_Shows on supp_tvshows.id=TV_Shows.id join Actor on supp_tvshows.actor=Actor.id where TV_Shows.title=@parameter
		select  title,category,no_of_season,rating,@result as actors,Director.name as director from TV_Shows join Genre on Genre.id=TV_Shows.genre join Director on Director.id=TV_Shows.director where @parameter=title
		return
	end
	
end
--drop procedure search_show
--execute search_show @parameter='Friends'


--SEARCH IN ACTOR OR DIRECTOR BY NAME IN ACTOR AND DIRECTOR TABLE
go
create procedure search @para nvarchar(30) as
begin
	select name,age from Actor  where name=@para
	select name,age from Director  where name=@para
end
--drop procedure search
--execute search @para='Morgan Freeman'



--LIST ALL EPISODES OF A PARTICULAR SEASON OF TV SHOW
go
create procedure epi @parameter nvarchar(30),@Sno int as
begin
	 select episodes.title,duration from episodes join TV_Shows on episodes.tvshow_id=TV_Shows.id where TV_Shows.title=@parameter and season_no=@Sno
end
--execute  epi @parameter='Friends', @Sno=1 
--drop procedure epi


--REVIEWS BY MOVIE NAME
go 
create procedure movie_review @parameter nvarchar(30) as
begin
	select Reviews.summary,reviewedby,upvotes from Reviews join Movie on Reviews.movie_id=Movie.id where Movie.title=@parameter order by upvotes desc
end
--drop procedure movie_review
--execute movie_review @parameter='Avengers:Age of Ultron'


--REVIEWS BY TV SHOW NAME
go 
create procedure Show_review @parameter nvarchar(30) as
begin
	select Reviews.summary,reviewedby,upvotes from Reviews join TV_Shows on Reviews.tvshow_id=TV_Shows.id where TV_Shows.title=@parameter order by upvotes desc
end

--DROP PROCEDURE Show_review
--EXECUTE Show_review @parameter='Suits'


--RECOMMENDED MOVIES BY RATING
go 
create procedure Recomended_Movies  as
begin
	select Movie.title,Movie.duration,Movie.release_date,Movie.release_date,Movie.rating from Movie join Genre on Genre.id=Movie.genre where rating > 8
end
--drop procedure Recomended_Movies
--execute Recomended_Movies


--RECOMMENDED TV SHOWS BY RATING
go 
create procedure Recomended_Shows  as
begin
	select T.title,T.no_of_season,G.category,T.release_date from TV_Shows T join Genre G on G.id=T.genre  where rating > 8
end
--drop procedure Recomended_Shows
--execute Recomended_Shows



--SEARCH A GENRE IN MOVIE
go 
create procedure Genre_wise_movie_search @parameter nvarchar(30) as
begin
	select M.title,M.duration,M.release_date,M.rating from Movie M join Genre G on G.id=M.genre where category=@parameter
end
--execute Genre_wise_movie_search @parameter='Drama'
--DROP PROCEDURE Genre_wise_movie_search


--SEARCH A GENRE IN TV SHOW
go 
create procedure Genre_wise_show_search @parameter nvarchar(30) as
begin
	select T.title, T.no_of_season,T.rating,T.release_date from TV_Shows T join Genre G on G.id=T.genre where category=@parameter
end
--execute Genre_wise_show_search @parameter='Comedy'
--DROP PROCEDURE Genre_wise_show_search


--TV SHOWS OF RECENT YEAR
go 
create procedure Recent_Shows as
begin
	select T.id,T.title,T.release_date,G.category from TV_Shows T join Genre G on G.id=T.genre where year(release_date)>=(YEAR(GETDATE())-1) AND YEAR(release_date)<YEAR(GETDATE())
end

--DROP PROCEDURE Recent_Shows
--EXECUTE Recent_shows


--MOVIES OF RECENT YEAR
go 
create procedure Recent_Movies as
begin
	select M.id,M.title,M.release_date,G.category from Movie M join Genre G on G.id=M.genre where year(release_date)>=(YEAR(GETDATE())-1) AND YEAR(release_date)<YEAR(GETDATE())
end

--EXECUTE Recent_Movies
--DROP PROCEDURE Recent_Movies

--WATCHLIST OF A USER
go
create procedure watch_list @id nvarchar(30) as
begin	
		declare @i nvarchar(30)
		select @i=Users.fname from Watchlist join Users on Watchlist.userid=Users.id where Watchlist.userid=@id
		select @i as Watchlist
		select distinct(Movie.title) as movies from Watchlist join Movie on Watchlist.movie_id=Movie.id join Users on Watchlist.userid=Users.id where Watchlist.userid=@id
		select distinct(TV_Shows.title) as TV_Shows from Watchlist join TV_Shows on Watchlist.tvshow_id=TV_Shows.id join Users on Watchlist.userid=Users.id where Watchlist.userid=@id
end
--drop procedure watch_list
--execute  watch_list @id='4'

