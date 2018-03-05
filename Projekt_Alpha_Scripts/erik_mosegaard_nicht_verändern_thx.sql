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
USE [master]
GO
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
	LandID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Land nvarchar(80) NOT NULL
	);

/* Tabelle T_Interpret erstellen*/
CREATE TABLE T_Interpret(
	InterpretID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Interpret nvarchar(100) NOT NULL, 
	);

/* Tabelle T_Album erstellen*/
CREATE TABLE T_Album(
	AlbumID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Album nvarchar(400)NOT NULL,
	UNC nvarchar(MAX)NULL
	);
/* Tabelle T_Genre erstellen*/
CREATE TABLE T_Genre(
	GenreID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Stilrichtung nvarchar(150) NOT NULL
	);

/* Tabelle T_Benutzer erstellen*/
CREATE TABLE T_Benutzer (
	UserID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Name nvarchar(200),
	Nachname nvarchar(400),
	Benutzername nvarchar(200) NOT NULL,
	Passwort nvarchar(200) NOT NULL,
	Email nvarchar(MAX) NOT NULL
	);

/* Tabelle T_Playlist erstellen*/
CREATE TABLE T_Playlist(
	PlaylistID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL,
	PlaylistName nvarchar(200)NOT NULL,
	UserID_FK INTEGER FOREIGN KEY (UserID_FK) REFERENCES  T_Benutzer (UserID_PK) NOT NULL
	);

/* Tabelle T_Titel erstellen*/
CREATE TABLE T_Titel(
	TitelID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL,
	TitelName nvarchar(300) NOT NULL,
	Ausgabejahr decimal(4,0) NULL,
	Kaufpreis decimal(17,2) NULL,
	Kaufdatum date NOT NULL,
	Dauer time NOT NULL,
	LandID_FK INTEGER FOREIGN KEY (LandID_FK) REFERENCES T_Land (LandID_PK) NULL,
	UserID_FK INTEGER FOREIGN KEY (UserID_FK) REFERENCES T_Benutzer (UserID_PK) NULL,
	InterpretID_FK INTEGER FOREIGN KEY (InterpretID_FK) REFERENCES T_Interpret (InterpretID_PK) NULL,
	AlbumID_FK INTEGER FOREIGN KEY (AlbumID_FK) REFERENCES T_Album (AlbumID_PK) NULL,
	GenreID_FK INTEGER FOREIGN KEY (GenreID_FK) REFERENCES T_Genre (GenreID_PK) NULL,
	);

/* Tabelle T_Bewertung erstellen*/
CREATE TABLE T_Bewertung(
	BewertungID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Bewertung decimal(2,1) NOT NULL,
	TitelID_FK INTEGER FOREIGN KEY (TitelID_FK) REFERENCES T_Titel (TitelID_PK) NOT NULL,
	UserID_FK INTEGER FOREIGN KEY (UserID_FK) REFERENCES T_Benutzer (UserID_PK) NOT NULL
	);

/* Tabelle T_TitelPlaylist erstellen*/
CREATE TABLE T_TitelPlaylist(
	TitelPlaylistID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL,
	TitelID_FK INTEGER FOREIGN KEY (TitelID_FK) REFERENCES T_Titel (TitelID_PK) NOT NULL,
	PlaylistID_FK INTEGER FOREIGN KEY (PlaylistID_FK) REFERENCES T_Playlist (PlaylistID_PK) NOT NULL,
	);

------------------------inf17_alpha2_02_insert.sql
/* Datenbank master verwenden*/
USE [master]
GO
/* Datenbank DAlpha verwenden*/
USE [DAlpha];
GO


------------------------inf17_alpha2_03_select.sql
/* Datenbank master verwenden*/
USE [master]
GO
/* Datenbank DAlpha verwenden*/
USE [DAlpha];
GO