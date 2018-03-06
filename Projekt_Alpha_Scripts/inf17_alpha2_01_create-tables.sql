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
	UserID_FK INTEGER FOREIGN KEY (UserID_FK) REFERENCES  T_Benutzer (UserID_PK) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL
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
	LandID_FK INTEGER FOREIGN KEY (LandID_FK) REFERENCES T_Land (LandID_PK) ON UPDATE CASCADE NOT NULL,

	--Wenn der Benutzer aktualisiert wird, wird in der Tabelle Titel auch der FOREIGN UserID entsprechend aktualisiert.(Siehe 2 Zeilen Untzen dran)Nicht relevant!!!!!
	--Wenn der Benutzer gelöscht wird auch der Titel gelöscht wegen dem FOREIGN KEY mit ON DELETE CASCADE (Siehe Zeile Untzen dran)Nicht relevant!!!!!!!!
	UserID_FK INTEGER FOREIGN KEY (UserID_FK) REFERENCES T_Benutzer (UserID_PK) /*ON UPDATE CASCADE ON DELETE CASCADE*/ NOT NULL,

	--Wenn der InterpretID aktualisiert wird wird auch in der Tabelle Titel der IinterpretFK aktualisiert(Siehe Zeile Untzen dran)
	InterpretID_FK INTEGER FOREIGN KEY (InterpretID_FK) REFERENCES T_Interpret (InterpretID_PK) ON UPDATE CASCADE NOT NULL,

	--Wenn das AlbumPK aktualisiert wird wird auch in der Tabelle Titel AlbumFK aktualisiert(Siehe Zeile Untzen dran)
	AlbumID_FK INTEGER FOREIGN KEY (AlbumID_FK) REFERENCES T_Album (AlbumID_PK) ON UPDATE CASCADE NOT NULL,

	--Wenn der GenrePK aktualisiert wird wird auch in der Tabelle Titel GenreFK aktualisiert.(Siehe Zeile Untzen dran)
	GenreID_FK INTEGER FOREIGN KEY (GenreID_FK) REFERENCES T_Genre (GenreID_PK) ON UPDATE CASCADE NOT NULL
	);

/* Tabelle T_Bewertung erstellen*/
CREATE TABLE T_Bewertung(
	BewertungID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL, --PRIMARY KEY
	Bewertung decimal(2,1) NOT NULL,
	--Wenn der TitelPK aktualisiert wird wird auch der TitelFK in der Tabelle T_Bewertung aktualisiert.(Siehe 2 zeilen unten dran)
	--Wenn der TitelPK gelöscht wird auch entsprechend die Bewertungen in der Tabelle Bewertung zum TitelPK gelöscht werden. (Siehe zeile unten dran)
	TitelID_FK INTEGER FOREIGN KEY (TitelID_FK) REFERENCES T_Titel (TitelID_PK) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,

	--Wenn der UserID_PK aktualisiert wird auch in der Tabelle Bewertung der UserID_FK aktualisiert. (Siehe 2 zeilen unten dran)
	--Wenn der UserID_PK gelöscht wird, wird auch in der Tabelle Bewertung alle Bewertungen zum Benutzer gelöscht. (Siehe zeile unten dran)
	UserID_FK INTEGER FOREIGN KEY (UserID_FK) REFERENCES T_Benutzer (UserID_PK) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL
	);

/* Tabelle T_TitelPlaylist erstellen*/
CREATE TABLE T_TitelPlaylist(
	TitelPlaylistID_PK INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL, --PRIMARY KEY

	--Wenn der der TitelID_PK gelöscht wird, wird in der Tabelle TitelPlaylist der Titel gelöscht. (Siehe 2 zeilen unten dran)
	--Wenn der Titel_PK aktualisiert wird, wird in der Tabelle TitelPlaylist der Titel_FK aktualisiert. (Siehe zeile unten dran)
	TitelID_FK INTEGER FOREIGN KEY (TitelID_FK) REFERENCES T_Titel (TitelID_PK) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,

	--Wenn der PlaylistID_PK aktulisiert wird, wird auch in der Tabelle TitelPlaylist der Playlist_FK aktualisiert. (Siehe 2 zeilen unten dran)
	--Wenn die PlaylistID_PK gelöscht wird, werden auch in der Tabelle TitelPLaylist alle einträge zum entsprechenden PlaylistID_PK gelöscht. (Siehe zeile unten dran)
	PlaylistID_FK INTEGER FOREIGN KEY (PlaylistID_FK) REFERENCES T_Playlist (PlaylistID_PK) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	);

/******Constrainst hinzufügen******/