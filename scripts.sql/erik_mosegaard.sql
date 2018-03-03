/****** Database [DAlpha]******/
USE [master]
GO

/****** Datenbank erstellen [DAlpha]******/
CREATE DATABASE [DAlpha];
GO

/****** Datenbank verwenden******/
USE [DAlpha];
GO
-------------------------------------------------------------------------------------------------------
/****** Database [DAlpha]******/
USE [master]
GO
/****** Datenbank verwenden******/
USE [DAlpha];
GO
/****** Tabelle T_Land erstellen******/
CREATE TABLE T_Land(
	LandID_PK INTEGER IDENTITY(1,1) NOT NULL,
	Land nvarchar(80) NOT NULL
	);

/****** Tabelle T_Interpret erstellen******/
CREATE TABLE T_Interpret(
	InterpretID_PK INTEGER IDENTITY(1,1) NOT NULL,
	Interpret nvarchar(100), NOT NULL
	);

/****** Tabelle T_Album erstellen******/
CREATE TABLE T_Album(
	AlbumID_PK INTEGER IDENTITY(1,1) NOT NULL,
	Album nvarchar(400)NOT NULL,
	UNC nvarchar(MAX)NULL
	);
/****** Tabelle T_Genre erstellen******/
CREATE TABLE(
	GenreID_PK INTEGER IDENTITY(1,1) NOT NULL,
	Stilrichtung nvarchar(150)
	);

/****** Tabelle T_Benutzer erstellen******/
CREATE TABLE T_Benutzer (
	UserID_PK INTEGER IDENTITY(1,1) NOT NULL,
	Name nvarchar(200),
	Nachname nvarchar(400),
	Benutzername nvarchar(200),
	Passwort nvarchar(200),
	Email nvarchar(MAX)
	);