CREATE DATABASE Study
ON
(
	NAME=Study_Data,
	FILENAME='C:\DataBase\StudyData.mdf',
	SIZE=10,
	MAXSIZE=500,
	FILEGROWTH=10
)
LOG ON
(	
	NAME=Study_Log,
	FILENAME='C:\DataBase\StudyData.ldf',
	SIZE=5,
	MAXSIZE=500,
	FILEGROWTH=5
)