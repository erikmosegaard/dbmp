SET NOCOUNT ON;
----------------inf17_alpha2_00_create-db.sql
/* Datenbank master verwenden*/
USE [master]
GO
/* Datenbank erstellen [DAlpha]*/
CREATE DATABASE [DAlpha];
GO

/* Datenbank DAlpha verwenden*/
USE [DAlpha];
GO



------------------------inf17_alpha2_01_create-tables.sql
/* Datenbank master verwenden*/
--USE [master]
--GO
/* Datenbank DAlpha verwenden*/
USE [DAlpha];
GO

----Tabellen Fallen lasen(löschen)
----Wenn die tabellen vorhanden sind dann löschen sie zuerst die Tabellen
--DROP TABLE T_TitelPlaylist;
--DROP TABLE T_Bewertung;
--DROP TABLE T_Titel;
--DROP TABLE T_Playlist;
--DROP TABLE T_Benutzer;
--DROP TABLE T_Genre;
--DROP TABLE T_Album;
--DROP TABLE T_Interpret;
--DROP TABLE T_Land;


/* Tabelle T_Land erstellen*/
CREATE TABLE T_Land(
	LandID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL, --PRIMARY KEY
	Land nvarchar(80) NOT NULL
	);

/* Tabelle T_Interpret erstellen*/
CREATE TABLE T_Interpret(
	InterpretID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL, --PRIMARY KEY
	Interpret nvarchar(100) NOT NULL, 
	);

/* Tabelle T_Album erstellen*/
CREATE TABLE T_Album(
	AlbumID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL, --PRIMARY KEY
	Album nvarchar(400)NOT NULL,
	UNC nvarchar(MAX)NULL
	);
/* Tabelle T_Genre erstellen*/
CREATE TABLE T_Genre(
	GenreID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL, --PRIMARY KEY
	Stilrichtung nvarchar(150) NOT NULL
	);

/* Tabelle T_Benutzer erstellen*/
CREATE TABLE T_Benutzer (
	UserID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL, --PRIMARY KEY
	Name nvarchar(200),
	Nachname nvarchar(400),
	Benutzername nvarchar(200) NOT NULL,
	Passwort nvarchar(200) NOT NULL,
	Email nvarchar(MAX) NOT NULL
	);

/* Tabelle T_Playlist erstellen*/
CREATE TABLE T_Playlist(
	PlaylistID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL, --PRIMARY KEY
	PlaylistName nvarchar(200)NOT NULL,
	--Wenn der benutzer geändert wird wird auch seine Playlist geändert, wenn der benutzer gelöscht wird auch seine Playlist gelöscht(Ganze zeile unten)
	UserID_FK INTEGER /*FOREIGN KEY (UserID_FK) REFERENCES  T_Benutzer (UserID_PK) ON UPDATE CASCADE ON DELETE CASCADE*/ NOT NULL
	);

/* Tabelle T_Titel erstellen*/
CREATE TABLE T_Titel(
	TitelID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL, --PRIMARY KEY
	TitelName nvarchar(300) NOT NULL,
	Ausgabejahr decimal(4,0) NOT NULL,
	Kaufpreis decimal(6,2) NOT NULL,
	Kaufdatum date NOT NULL,
	Dauer time NOT NULL,
	--Wenn der Land PK Land aktualisiert wird, wird auch in der Tabelle Titel die LandID_FK aktualisiert.(Siehe Zeile Untzen dran)
	LandID_FK INTEGER /*FOREIGN KEY (LandID_FK) REFERENCES T_Land (LandID_PK) ON UPDATE CASCADE*/ NOT NULL,

	--Wenn der Benutzer aktualisiert wird, wird in der Tabelle Titel auch der FOREIGN UserID entsprechend aktualisiert.(Siehe 2 Zeilen Untzen dran)Nicht relevant!!!!!
	--Wenn der Benutzer gelöscht wird auch der Titel gelöscht wegen dem FOREIGN KEY mit ON DELETE CASCADE (Siehe Zeile Untzen dran)Nicht relevant!!!!!!!!
	UserID_FK INTEGER /*FOREIGN KEY (UserID_FK) REFERENCES T_Benutzer (UserID_PK) ON UPDATE CASCADE ON DELETE CASCADE*/ NOT NULL,

	--Wenn der InterpretID aktualisiert wird wird auch in der Tabelle Titel der IinterpretFK aktualisiert(Siehe Zeile Untzen dran)
	InterpretID_FK INTEGER /*FOREIGN KEY (InterpretID_FK) REFERENCES T_Interpret (InterpretID_PK) ON UPDATE CASCADE*/ NOT NULL,

	--Wenn das AlbumPK aktualisiert wird wird auch in der Tabelle Titel AlbumFK aktualisiert(Siehe Zeile Untzen dran)
	AlbumID_FK INTEGER /*FOREIGN KEY (AlbumID_FK) REFERENCES T_Album (AlbumID_PK) ON UPDATE CASCADE*/ NOT NULL,

	--Wenn der GenrePK aktualisiert wird wird auch in der Tabelle Titel GenreFK aktualisiert.(Siehe Zeile Untzen dran)
	GenreID_FK INTEGER /*FOREIGN KEY (GenreID_FK) REFERENCES T_Genre (GenreID_PK) ON UPDATE CASCADE*/ NOT NULL
	);

/* Tabelle T_Bewertung erstellen*/
CREATE TABLE T_Bewertung(
	BewertungID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL, --PRIMARY KEY
	Bewertung decimal(2,1) NOT NULL,
	--Wenn der TitelPK aktualisiert wird wird auch der TitelFK in der Tabelle T_Bewertung aktualisiert.(Siehe 2 zeilen unten dran)
	--Wenn der TitelPK gelöscht wird auch entsprechend die Bewertungen in der Tabelle Bewertung zum TitelPK gelöscht werden. (Siehe zeile unten dran)
	TitelID_FK INTEGER /*FOREIGN KEY (TitelID_FK) REFERENCES T_Titel (TitelID_PK) ON UPDATE CASCADE ON DELETE CASCADE*/ NOT NULL,

	--Wenn der UserID_PK aktualisiert wird auch in der Tabelle Bewertung der UserID_FK aktualisiert. (Siehe 2 zeilen unten dran)
	--Wenn der UserID_PK gelöscht wird, wird auch in der Tabelle Bewertung alle Bewertungen zum Benutzer gelöscht. (Siehe zeile unten dran)
	UserID_FK INTEGER /*FOREIGN KEY (UserID_FK) REFERENCES T_Benutzer (UserID_PK) ON UPDATE CASCADE ON DELETE CASCADE*/ NOT NULL
	);

/* Tabelle T_TitelPlaylist erstellen*/
CREATE TABLE T_TitelPlaylist(
	TitelPlaylistID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL, --PRIMARY KEY

	--Wenn der der TitelID_PK gelöscht wird, wird in der Tabelle TitelPlaylist der Titel gelöscht. (Siehe 2 zeilen unten dran)
	--Wenn der Titel_PK aktualisiert wird, wird in der Tabelle TitelPlaylist der Titel_FK aktualisiert. (Siehe zeile unten dran)
	TitelID_FK INTEGER /*FOREIGN KEY (TitelID_FK) REFERENCES T_Titel (TitelID_PK) ON UPDATE CASCADE ON DELETE CASCADE*/ NOT NULL,

	--Wenn der PlaylistID_PK aktulisiert wird, wird auch in der Tabelle TitelPlaylist der Playlist_FK aktualisiert. (Siehe 2 zeilen unten dran)
	--Wenn die PlaylistID_PK gelöscht wird, werden auch in der Tabelle TitelPLaylist alle einträge zum entsprechenden PlaylistID_PK gelöscht. (Siehe zeile unten dran)
	PlaylistID_FK INTEGER /*FOREIGN KEY (PlaylistID_FK) REFERENCES T_Playlist (PlaylistID_PK) ON UPDATE CASCADE ON DELETE CASCADE*/ NOT NULL,
	);

/*********Constrainst hinzufügen*********/
USE [DAlpha];
GO
--/****PRIMARY KEY Constraint*****/
----Land PK
--ALTER TABLE T_Land
--ADD CONSTRAINT PK_LandID_PK PRIMARY KEY CLUSTERED  (LandID_PK);
--GO

----Interpret PK hinzufügen
--ALTER TABLE T_Interpret
--ADD CONSTRAINT PK_InterpertID_PK PRIMARY KEY CLUSTERED  (InterpretID_PK);
--GO

----Album PK hinzufügen
--ALTER TABLE T_Album
--ADD CONSTRAINT PK_AlbumID_PK PRIMARY KEY CLUSTERED  (AlbumID_PK);
--GO

----Genre PK hinzufügen
--ALTER TABLE T_Genre
--ADD CONSTRAINT PK_GenreID_PK PRIMARY KEY CLUSTERED  (GenreID_PK);
--GO

----Benutzer PK hinzufügen
--ALTER TABLE T_Benutzer
--ADD CONSTRAINT PK_UserID_PK PRIMARY KEY CLUSTERED  (UserID_PK);
--GO

----Playlist PK hinzufügen
--ALTER TABLE T_Playlist
--ADD CONSTRAINT PK_PlaylistID_PK PRIMARY KEY CLUSTERED  (PlaylistID_PK);
--GO

----Titel PK hinzufügen
--ALTER TABLE T_Benutzer
--ADD CONSTRAINT PK_TitelID_PK PRIMARY KEY CLUSTERED  (TitelID_PK);
--GO

----Bewertung PK hinzufügen
--ALTER TABLE T_Benutzer
--ADD CONSTRAINT PK_BewertungID_PK PRIMARY KEY CLUSTERED  (BewertungID_PK);
--GO

----TitelPlaylist PK hinzufügen
--ALTER TABLE T_TitelPlaylist
--ADD CONSTRAINT PK_TitelPlaylistID_PK PRIMARY KEY CLUSTERED  (TitelPlaylistID_PK);
--GO

/****FOREIGN KEY Constraint*****/

--Playlist UserID_FK hinzufügen
ALTER TABLE T_Playlist
ADD CONSTRAINT FK_T_Playlist_UserID_FK___T_Benutzer_BenutzerID_PK FOREIGN KEY (UserID_FK)
	REFERENCES T_Benutzer (UserID_PK)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	;
GO

--------------T_Titel

--Titel LandID_FK hinzufügen
ALTER TABLE T_Titel
ADD CONSTRAINT FK_T_Titel_LandID_FK___T_Land_LandID_PK FOREIGN KEY (LandID_FK)
	REFERENCES T_Land (LandID_PK)
	--ON DELETE CASCADE
	ON UPDATE CASCADE
	;
GO

--Titel UserID_FK hinzufügen
ALTER TABLE T_Titel
ADD CONSTRAINT FK_T_Titel_UserID_FK___T_Benutzer_UserID_PK FOREIGN KEY (UserID_FK)
	REFERENCES T_Benutzer (UserID_PK)
	--ON DELETE CASCADE
	--ON UPDATE CASCADE
	;
GO

--Titel InterpretID_FK hinzufügen
ALTER TABLE T_Titel
ADD CONSTRAINT FK_T_Titel_InterpretID_FK___T_Interpret_InterpretID_PK FOREIGN KEY (InterpretID_FK)
	REFERENCES T_Interpret (InterpretID_PK)
	--ON DELETE CASCADE
	ON UPDATE CASCADE
	;
GO

--Titel AlbumID_FK hinzufügen
ALTER TABLE T_Titel
ADD CONSTRAINT FK_T_Titel_AlbumID_FK___T_Album_AlbumID_PK FOREIGN KEY (AlbumID_FK)
	REFERENCES T_Album (AlbumID_PK)
	--ON DELETE CASCADE
	ON UPDATE CASCADE
	;
GO

--Titel GenreID_FK hinzufügen
ALTER TABLE T_Titel
ADD CONSTRAINT FK_T_Titel_GenreID_FK___T_Genre_GenreID_PK FOREIGN KEY (GenreID_FK)
	REFERENCES T_Genre (GenreID_PK)
	--ON DELETE CASCADE
	ON UPDATE CASCADE
	;
GO

--------------T_Bewertung

--Bewertung TitelID_FK hinzufügen
ALTER TABLE T_Bewertung
ADD CONSTRAINT FK_T_Bewertung_TitelID_FK___T_Titel_TitelID_PK FOREIGN KEY (TitelID_FK)
	REFERENCES T_Titel (TitelID_PK)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	;
GO

--Bewertung UserID_FK hinzufügen
ALTER TABLE T_Bewertung
ADD CONSTRAINT FK_T_Bewertung_UserID_FK___T_Benutzer_UserID_PK FOREIGN KEY (UserID_FK)
	REFERENCES T_Benutzer (UserID_PK)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	;
GO


--------------T_TitelPlaylist

--TitelPlaylist TitelID_FK hinzufügen
ALTER TABLE T_TitelPlaylist
ADD CONSTRAINT FK_T_TitelPlaylist_TitelID_FK___T_Titel_TitelID_PK FOREIGN KEY (TitelID_FK)
	REFERENCES T_Titel (TitelID_PK)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	;
GO

--TitelPlaylist PlaylistID_FK hinzufügen
ALTER TABLE T_TitelPlaylist
ADD CONSTRAINT FK_T_TitelPlaylist_PlaylistID_FK___T_Playlist_PlaylistID_PK FOREIGN KEY (PlaylistID_FK)
	REFERENCES T_Playlist (PlaylistID_PK)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	;
GO


------------------------inf17_alpha2_02_insert.sql
/* Datenbank master verwenden*/
--USE [master];
--GO
/* Datenbank DAlpha verwenden*/
USE [DAlpha];
GO

/*********Benutzer hinzufügen*********/
DELETE FROM T_Benutzer
DBCC CHECKIDENT ('T_Benutzer', RESEED, 0);

insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Gayel', 'Dormon', 'gdormon0', '7iTMLsW', 'gdormon0@github.com');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Jacobo', 'Dumbare', 'jdumbare1', 'At2Rdxx0e', 'jdumbare1@salon.com');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Leland', 'Fysh', 'lfysh2', 'p5D01yajjo', 'lfysh2@accuweather.com');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Viva', 'Crick', 'vcrick3', '4N5b10Vb', 'vcrick3@amazon.com');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Brooks', 'Olding', 'bolding4', '74uEopTrJm', 'bolding4@ycombinator.com');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Fern', 'Syde', 'fsyde5', 'xdtJ4LAOu7o6', 'fsyde5@moonfruit.com');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Nicolais', 'MacPeake', 'nmacpeake6', 'gvbUE6ui4p', 'nmacpeake6@example.com');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Parnell', 'Stiggers', 'pstiggers7', 'GVjHGfIi', 'pstiggers7@livejournal.com');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Man', 'Braidley', 'mbraidley8', '3DrMzVHUE', 'mbraidley8@smh.com.au');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Halimeda', 'Cuming', 'hcuming9', 'e1KYtMBs', 'hcuming9@wikimedia.org');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Killian', 'Element', 'kelementa', '9VhLwhN3my', 'kelementa@google.co.uk');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Nerte', 'Donaher', 'ndonaherb', 'p37BZovume', 'ndonaherb@clickbank.net');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Urbano', 'Wrathall', 'uwrathallc', 'YDnuYjj4R', 'uwrathallc@oakley.com');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Wynny', 'Winterbotham', 'wwinterbothamd', '1qxNX5', 'wwinterbothamd@moonfruit.com');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Fernandina', 'Banyard', 'fbanyarde', 'V88M2r7gSi', 'fbanyarde@gnu.org');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Britt', 'Darley', 'bdarleyf', 'Q2nSYV17h', 'bdarleyf@telegraph.co.uk');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Perice', 'Finders', 'pfindersg', '6Cc3wNU3U6c2', 'pfindersg@statcounter.com');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Karlene', 'Raisher', 'kraisherh', 'uo4uLyWBN', 'kraisherh@goodreads.com');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Clemence', 'Scala', 'cscalai', 'o2u9AVdVWk', 'cscalai@nba.com');
insert into T_Benutzer (Name, Nachname, Benutzername, Passwort, Email) values ('Etti', 'Pringell', 'epringellj', 'n0kBbz6VDFHj', 'epringellj@nbcnews.com');
GO

------------------------inf17_alpha2_03_select.sql
/* Datenbank master verwenden*/
--USE [master]
--GO

/*********Länder hinzufügen*********/
DELETE FROM T_Land
DBCC CHECKIDENT ('T_Land', RESEED, 1);

INSERT INTO T_Land (Land) VALUES ('Dänemark');
INSERT INTO T_Land (Land) VALUES ('Luxemburg');
INSERT INTO T_Land (Land) VALUES ('England');
INSERT INTO T_Land (Land) VALUES ('Schweiz');
INSERT INTO T_Land (Land) VALUES ('Italien');
INSERT INTO T_Land (Land) VALUES ('Spanien');
INSERT INTO T_Land (Land) VALUES ('Australien');
INSERT INTO T_Land (Land) VALUES ('Brasilien');
INSERT INTO T_Land (Land) VALUES ('Kuba');
INSERT INTO T_Land (Land) VALUES ('Frankreich');
INSERT INTO T_Land (Land) VALUES ('USA');
INSERT INTO T_Land (Land) VALUES ('Deutschland');
GO

/*********Genre hinzufügen*********/
DELETE FROM T_Genre
DBCC CHECKIDENT ('T_Genre', RESEED, 1);

INSERT INTO T_Genre (Stilrichtung) VALUES ('Jazz');
INSERT INTO T_Genre (Stilrichtung) VALUES ('Pop');
INSERT INTO T_Genre (Stilrichtung) VALUES ('Rock&Roll');
INSERT INTO T_Genre (Stilrichtung) VALUES ('Elektro');
INSERT INTO T_Genre (Stilrichtung) VALUES ('Schlager');
INSERT INTO T_Genre (Stilrichtung) VALUES ('Rap');
INSERT INTO T_Genre (Stilrichtung) VALUES ('Klassik');
INSERT INTO T_Genre (Stilrichtung) VALUES ('House');
INSERT INTO T_Genre (Stilrichtung) VALUES ('Reggea');
INSERT INTO T_Genre (Stilrichtung) VALUES ('Volksmusik');
GO

/*********Album hinzufügen*********/
DELETE FROM T_Album
DBCC CHECKIDENT ('T_Album', RESEED, 1);

INSERT INTO T_Album (Album, UNC) VALUES ('Album 1','\\Servername\Freigabename\Pfad\Album1.jpeg');
INSERT INTO T_Album (Album, UNC) VALUES ('Album 2','\\Servername\Freigabename\Pfad\Album2.jpeg');
INSERT INTO T_Album (Album, UNC) VALUES ('Album 3','\\Servername\Freigabename\Pfad\Album3.jpeg');
INSERT INTO T_Album (Album, UNC) VALUES ('Album 4','\\Servername\Freigabename\Pfad\Album4.jpeg');
INSERT INTO T_Album (Album, UNC) VALUES ('Album 5','\\Servername\Freigabename\Pfad\Album5.jpeg');
INSERT INTO T_Album (Album, UNC) VALUES ('Album 6','\\Servername\Freigabename\Pfad\Album6.jpeg');
INSERT INTO T_Album (Album, UNC) VALUES ('Album 7','\\Servername\Freigabename\Pfad\Album7.jpeg');
INSERT INTO T_Album (Album, UNC) VALUES ('Album 8','\\Servername\Freigabename\Pfad\Album8.jpeg');
INSERT INTO T_Album (Album, UNC) VALUES ('Album 9','\\Servername\Freigabename\Pfad\Album9.jpeg');
INSERT INTO T_Album (Album, UNC) VALUES ('Album 10','\\Servername\Freigabename\Pfad\Album10.jpeg');
GO

/*********Interpret hinzufügen*********/
DELETE FROM T_Interpret
DBCC CHECKIDENT ('T_Interpret', RESEED, 1);

INSERT INTO T_Interpret (Interpret) VALUES ('Interpret 1');
INSERT INTO T_Interpret (Interpret) VALUES ('Interpret 2');
INSERT INTO T_Interpret (Interpret) VALUES ('Interpret 3');
INSERT INTO T_Interpret (Interpret) VALUES ('Interpret 4');
INSERT INTO T_Interpret (Interpret) VALUES ('Interpret 5');
INSERT INTO T_Interpret (Interpret) VALUES ('Interpret 6');
INSERT INTO T_Interpret (Interpret) VALUES ('Interpret 7');
INSERT INTO T_Interpret (Interpret) VALUES ('Interpret 8');
INSERT INTO T_Interpret (Interpret) VALUES ('Interpret 9');
INSERT INTO T_Interpret (Interpret) VALUES ('Interpret 10');
GO

/*********Titel hinzufügen*********/
DELETE FROM T_Titel
DBCC CHECKIDENT ('T_Titel', RESEED, 1);

INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_1',1987,1.67,'2.11.2017','0:2:55',10,13,10,10,2)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_2',2000,3.33,'27.10.2017','0:2:36',3,1,7,8,4)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_3',1988,2.89,'24.2.2018','0:3:2',5,16,10,8,3)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_4',2001,2.78,'7.11.2017','0:1:56',10,12,2,1,6)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_5',2003,2.33,'19.11.2017','0:1:41',1,8,7,5,10)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_6',2003,3.89,'24.1.2018','0:2:14',4,17,5,5,1)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_7',1964,2.33,'14.2.2018','0:2:47',10,4,4,5,7)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_8',1964,4.11,'6.2.2018','0:3:6',9,5,2,7,8)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_9',2011,1.78,'22.1.2018','0:1:28',8,8,4,2,9)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_10',1967,1.89,'26.10.2017','0:3:12',4,4,7,7,7)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_11',1990,2.44,'17.2.2018','0:2:21',6,7,3,5,7)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_12',1963,3.44,'27.10.2017','0:1:29',6,9,4,2,1)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_13',1991,2.56,'30.10.2017','0:1:51',1,8,4,7,3)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_14',1984,1.56,'8.3.2018','0:3:18',8,8,9,4,2)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_15',1988,1.33,'23.12.2017','0:1:31',8,20,3,6,7)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_16',1982,2.44,'18.12.2017','0:2:28',2,5,10,7,7)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_17',1998,1.22,'16.10.2017','0:1:30',1,4,8,1,1)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_18',1974,2.67,'4.3.2018','0:3:30',7,16,2,8,6)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_19',1964,3.78,'11.11.2017','0:3:28',9,7,2,8,5)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_20',1998,2.89,'6.3.2018','0:2:30',7,6,10,9,6)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_21',1997,4.22,'15.12.2017','0:1:40',3,1,7,3,6)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_22',1976,2.33,'30.11.2017','0:2:8',4,15,8,2,7)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_23',1999,1.22,'26.2.2018','0:3:23',10,9,3,4,10)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_24',1999,2.89,'7.12.2017','0:2:5',8,14,6,5,8)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_25',1983,2.67,'29.11.2017','0:3:23',7,9,1,1,9)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_26',1989,2.78,'12.2.2018','0:2:48',1,19,3,4,8)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_27',1993,4.11,'4.1.2018','0:2:22',7,7,8,1,3)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_28',1980,1.22,'19.11.2017','0:3:30',7,15,3,1,6)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_29',1961,2.78,'1.12.2017','0:2:16',7,6,2,10,9)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_30',1991,3.67,'30.12.2017','0:3:15',5,10,8,8,4)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_31',1992,2.44,'1.2.2018','0:3:0',3,15,3,4,2)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_32',1962,2.56,'13.2.2018','0:2:51',4,12,6,2,1)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_33',2003,1.56,'7.2.2018','0:2:58',4,11,3,7,8)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_34',1965,4.11,'8.10.2017','0:1:59',5,8,6,1,7)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_35',2017,2,'3.10.2017','0:2:2',1,14,1,4,6)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_36',1986,1.78,'28.10.2017','0:3:20',6,7,8,1,10)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_37',1999,1.89,'1.1.2018','0:1:27',2,13,8,3,2)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_38',2001,4,'4.1.2018','0:2:17',10,1,9,8,3)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_39',1962,4.11,'10.11.2017','0:2:0',9,1,10,9,8)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_40',1966,2.11,'5.2.2018','0:2:33',1,12,4,1,2)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_41',1961,3.78,'24.11.2017','0:3:4',6,2,5,6,3)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_42',1975,2,'13.11.2017','0:2:32',5,17,1,1,10)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_43',2012,3,'25.12.2017','0:2:59',5,12,10,3,9)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_44',1965,3.78,'19.2.2018','0:1:54',7,12,10,4,1)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_45',2002,2.67,'23.2.2018','0:2:54',6,18,7,7,6)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_46',2018,1.67,'28.11.2017','0:2:44',10,18,5,1,7)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_47',1988,2.44,'15.1.2018','0:2:15',7,3,9,1,8)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_48',2011,1.11,'1.3.2018','0:1:50',5,6,10,8,9)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_49',1963,3.11,'25.10.2017','0:3:7',2,8,5,9,10)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_50',1997,1.89,'11.2.2018','0:2:19',10,14,10,9,7)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_51',1971,1.11,'5.3.2018','0:2:46',8,1,1,5,10)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_52',1971,3.89,'2.12.2017','0:2:49',6,7,5,1,7)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_53',1963,3.22,'3.11.2017','0:1:55',8,11,8,3,2)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_54',1970,4,'8.12.2017','0:2:55',10,18,10,1,6)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_55',1963,2,'28.2.2018','0:3:14',9,3,2,8,4)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_56',1981,1.89,'28.12.2017','0:2:4',5,5,6,2,1)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_57',1968,2.56,'2.2.2018','0:2:52',8,1,7,8,2)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_58',1997,2.33,'25.9.2017','0:2:8',6,4,1,2,6)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_59',1976,1.11,'25.1.2018','0:1:52',7,6,2,4,6)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_60',1973,1.67,'10.1.2018','0:1:32',10,12,3,4,5)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_61',2010,3.67,'30.11.2017','0:1:52',7,4,3,1,10)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_62',2003,4,'28.10.2017','0:1:53',8,14,5,3,7)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_63',1989,2.33,'1.3.2018','0:2:22',8,18,10,6,7)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_64',1993,2.67,'8.11.2017','0:3:22',8,5,10,4,4)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_65',2006,2.11,'31.1.2018','0:1:43',2,4,4,1,1)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_66',1996,2.78,'2.1.2018','0:2:49',9,4,8,2,5)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_67',2001,1.44,'13.10.2017','0:1:43',9,19,4,3,8)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_68',1962,2.44,'7.11.2017','0:1:54',6,1,10,4,4)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_69',1980,3.22,'16.10.2017','0:2:36',3,5,3,4,8)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_70',1990,3.44,'31.10.2017','0:1:48',5,3,5,5,5)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_71',1993,4.33,'28.1.2018','0:2:4',5,3,10,1,3)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_72',1975,1.11,'25.11.2017','0:2:19',10,1,1,5,3)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_73',1986,2.78,'10.11.2017','0:2:3',3,7,8,9,10)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_74',1994,1.67,'4.3.2018','0:1:32',3,11,1,2,6)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_75',2016,2.22,'1.11.2017','0:2:9',4,19,1,3,7)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_76',1998,3.78,'6.3.2018','0:1:52',10,5,5,9,5)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_77',1988,1.44,'4.10.2017','0:2:11',4,11,2,7,7)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_78',1963,2.67,'27.1.2018','0:2:59',2,20,10,4,10)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_79',1990,3.78,'9.1.2018','0:2:51',9,3,6,7,9)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_80',2014,2.89,'31.10.2017','0:3:1',8,20,4,2,8)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_81',1997,3.44,'15.10.2017','0:3:17',10,11,1,10,7)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_82',1979,1.67,'21.11.2017','0:2:19',2,9,8,4,10)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_83',1977,3,'5.2.2018','0:2:33',2,9,9,4,7)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_84',1986,1.56,'30.12.2017','0:1:58',9,19,7,3,5)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_85',1969,1.44,'27.1.2018','0:2:3',5,19,3,7,2)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_86',2007,2.67,'21.12.2017','0:1:44',10,1,4,6,10)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_87',1995,1.56,'7.11.2017','0:3:11',3,13,10,8,6)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_88',1986,2,'8.10.2017','0:3:17',2,17,5,8,8)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_89',1993,2.56,'23.9.2017','0:2:16',4,1,4,8,6)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_90',2000,2,'30.10.2017','0:3:31',3,15,6,1,3)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_91',1971,3.33,'30.9.2017','0:2:50',7,20,6,7,9)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_92',2008,1.67,'7.10.2017','0:1:55',5,13,3,8,10)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_93',2007,2.56,'6.2.2018','0:2:2',9,6,3,8,2)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_94',2014,2.78,'11.12.2017','0:2:57',1,15,4,3,8)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_95',1996,3.56,'10.11.2017','0:2:21',2,16,2,4,6)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_96',1983,1.67,'18.1.2018','0:3:13',10,5,8,4,1)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_97',1976,3.78,'21.12.2017','0:2:27',7,5,8,9,6)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_98',2007,1.22,'20.12.2017','0:1:38',5,11,9,8,1)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_99',1961,2.44,'25.9.2017','0:2:36',10,1,8,6,1)
INSERT INTO T_Titel (TitelName, Ausgabejahr, Kaufpreis, Kaufdatum, Dauer, LandID_FK, UserID_FK, InterpretID_FK, AlbumID_FK, GenreID_FK) VALUES ('Titel_100',2018,3.22,'4.3.2018','0:2:18',9,13,6,2,2)
GO
--(Select (Land) FROM T_Land WHERE Land='Luxemburg')




SELECT * FROM T_Benutzer
SELECT * FROM T_Album
SELECT * FROM T_Bewertung
SELECT * FROM T_Genre
SELECT * FROM T_Interpret
SELECT * FROM T_Land
SELECT * FROM T_Playlist
SELECT * FROM T_Titel
SELECT * FROM T_TitelPlaylist

