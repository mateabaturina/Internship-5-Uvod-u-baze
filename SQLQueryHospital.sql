CREATE DATABASE Hospital;

USE Hospital;

CREATE TABLE OperatingRoom (
	Id int IDENTITY(1,1) PRIMARY KEY,
	OperatingRoomNumber int NOT NULL UNIQUE
);

CREATE TABLE Room (
	Id int IDENTITY(1,1) PRIMARY KEY,
	RoomNumber int NOT NULL UNIQUE
);

CREATE TABLE PlaceOfBirth (
	PostNumber int PRIMARY KEY, 
	PlaceName nvarchar(50) NOT NULL,
);

CREATE TABLE Nurse (
	OIB bigint PRIMARY KEY, 
	NurseName nvarchar(50) NOT NULL,
	NurseSurname nvarchar(50) NOT NULL,
	NurseAddress nvarchar(50) NOT NULL,
	PlaceOfBirthId int FOREIGN KEY REFERENCES PlaceOfBirth(PostNumber) NOT NULL,
	RoomId int FOREIGN KEY REFERENCES Room(Id),
	OperatingRoomId int FOREIGN KEY REFERENCES OperatingRoom(Id) 
);

CREATE TABLE Patient (
	OIB bigint PRIMARY KEY, 
	PatientName nvarchar(50) NOT NULL,
	PatientSurname nvarchar(50) NOT NULL,
	PatientAddress nvarchar(50) NOT NULL,
	PlaceOfBirthId int FOREIGN KEY REFERENCES PlaceOfBirth(PostNumber) NOT NULL,
	RoomId int FOREIGN KEY REFERENCES Room(Id) NOT NULL
);

CREATE TABLE Specialty (
	Id int IDENTITY(1,1) PRIMARY KEY,
	SpecialtyName nvarchar(50) NOT NULL UNIQUE
);

CREATE TABLE Surgeon (
	OIB bigint PRIMARY KEY, 
	SurgeonName nvarchar(50) NOT NULL,
	SurgeonSurname nvarchar(50) NOT NULL,
	SurgeonAddress nvarchar(50) NOT NULL,
	PlaceOfBirthId int FOREIGN KEY REFERENCES PlaceOfBirth(PostNumber) NOT NULL,
	Telephone bigint NOT NULL,
	SpecialtyId int FOREIGN KEY REFERENCES Specialty(Id) NOT NULL
);

CREATE TABLE SurgeryType (
	Id int IDENTITY(1,1) PRIMARY KEY,
	TypeName nvarchar(50) NOT NULL UNIQUE
);

CREATE TABLE Surgery (
	Id int IDENTITY(1,1) PRIMARY KEY,
	SurgeryTypeId int FOREIGN KEY REFERENCES SurgeryType(Id) NOT NULL,
	PatientOIB bigint FOREIGN KEY REFERENCES Patient(OIB) NOT NULL,
	SurgeonOIB bigint FOREIGN KEY REFERENCES Surgeon(OIB) NOT NULL,
	DateOfSurgery datetime NOT NULL,
	TimeOFSurgery time NOT NULL,
	OperatingRoomId int FOREIGN KEY REFERENCES OperatingRoom(Id) NOT NULL	
);

INSERT INTO OperatingRoom (OperatingRoomNumber) VALUES 
(1),
(2),
(3);

INSERT INTO Room (RoomNumber) VALUES 
(1),
(2),
(3),
(4),
(5),
(6),
(7);

INSERT INTO PlaceOfBirth (PostNumber, PlaceName) VALUES 
(21000, 'Split'),
(10000, 'Zagreb'),
(23000, 'Zadar');

INSERT INTO Nurse (OIB, NurseName, NurseSurname, NurseAddress, PlaceOfBirthId, RoomId, OperatingRoomId) VALUES
(1234567891, 'Mia', 'Avic', 'Poljiæka 25', 10000, 2, NULL),
(2345678912, 'Anela', 'Bozic', 'Velebitska 10', 21000, NULL, 3),
(3456789123, 'Leon', 'Hrstic', 'Vukovarska 30', 23000, 1, NULL),
(4567891234, 'Theon', 'Kunac', 'Brune Bušiæa 21', 21000, 3, NULL),
(5678912345, 'Lea', 'Leiæ', 'Vukovarska 50', 10000, 4, NULL),
(6789123456, 'Tea', 'Teiæ', 'Moseæka 23', 23000, NULL, 2),
(7891234567, 'Chiara', 'Chiariæ', 'Velebitska 14', 21000, 7, NULL),
(8912345678, 'Sara', 'Sariæ', 'Dubrovaèka 7', 21000, NULL, 1),
(9123456789, 'Ante', 'Antiæ', 'Dubrovaèka 21', 10000, 5, NULL);

SELECT * FROM Nurse;

INSERT INTO Patient (OIB, PatientName, PatientSurname, PatientAddress, PlaceOfBirthId, RoomId) VALUES
(2234567891, 'Marta', 'Martiæ', 'Poljiæka 2', 10000, 2),
(3345678912, 'Ana', 'Bariæ', 'Velebitska 11', 21000, 2),
(4456789123, 'Darko', 'Darkiæ', 'Vukovarska 3', 23000, 1),
(5567891234, 'Toni', 'Toniæ', 'Brune Bušiæa 1', 21000, 3),
(6678912345, 'Lana', 'Laniæ', 'Vukovarska 51', 10000, 4),
(7789123456, 'Luka', 'Lukiæ', 'Moseæka 2', 23000, 2),
(8891234567, 'Mate', 'Matiæ', 'Velebitska 4', 21000, 7),
(9912345678, 'Ivo', 'Iviæ', 'Dubrovaèka 47', 21000, 1),
(1123456789, 'Andrea', 'Andriæ', 'Dubrovaèka 2', 10000, 5);

SELECT * FROM Patient; 

INSERT INTO Specialty (SpecialtyName) VALUES 
('Neurokirurgija'),
('Kardiologija'),
('Opæa kirurgija'),
('Pedijatrijska kirurgija'),
('Ortopedija');

INSERT INTO Surgeon(OIB, SurgeonName, SurgeonSurname, SurgeonAddress, PlaceOfBirthId, Telephone,SpecialtyId) VALUES
(3234567891, 'Derek', 'Shepard', 'Poljiæka 20', 10000, 021231123, 1),
(3345678912, 'Meredith', 'Grey', 'Poljiæka 20', 21000, 021231123,3),
(5456789123, 'Christina', 'Yang', 'Vukovarska 3', 23000, 021345345, 2),
(3567891234, 'Alex', 'Karev', 'Brune Bušiæa 1', 21000, 021333666, 4),
(3678912345, 'Callie', 'Torres', 'Vukovarska 51', 10000, 021455544, 5);

INSERT INTO SurgeryType (TypeName) Values
('Mikrokirurški popravak aneurizme'),
('Odstranjivanje tumora mozga'),
('Premosnica koronarne arterije'),
('Popravak ili zamjena srèanog zaliska'),
('Transplantacija srca'),
('Apendektomija'),
('Spajanje kostiju'),
('Operacija za popravak pupèane kile'),
('Zamjena koljena');

INSERT INTO Surgery (SurgeryTypeId, PatientOIB, SurgeonOIB, DateOfSurgery, TimeOfSurgery, OperatingRoomId) VALUES
(1, 2234567891, 3234567891, '2021-12-08', '15:30', 1),
(2, 3345678912, 3234567891, '2021-12-09', '17:00', 1),
(3, 4456789123, 5456789123, '2021-12-09', '08:00', 2),
(4, 5567891234, 5456789123, '2021-12-10', '10:00', 2),
(5, 6678912345, 5456789123, '2022-01-05', '16:00', 3),
(6, 7789123456, 3345678912, '2021-12-09', '11:00', 3),
(7, 8891234567, 3678912345, '2021-12-11', '12:00', 1),
(8, 9912345678, 3567891234, '2021-12-14', '09:00', 3),
(9, 1123456789, 3678912345, '2021-12-16', '13:30', 2);

SELECT * FROM Surgery WHERE DateOfSurgery = '2021-12-09'
ORDER BY TimeOfSurgery;

SELECT SurgeonName, SurgeonSurname FROM Surgeon WHERE PlaceOfBirthId != 21000;

UPDATE Nurse
SET RoomId = 2
WHERE RoomId = 4;

SELECT * FROM Nurse;

SELECT * FROM Patient;

UPDATE Patient
SET RoomId = 7
WHERE RoomId IN (4, 5);

SELECT OIB, PatientName, PatientSurname FROM Patient WHERE RoomId = 7
ORDER BY PatientSurname DESC;

SELECT * FROM Surgery WHERE DateOfSurgery = CAST( GETDATE() AS Date );