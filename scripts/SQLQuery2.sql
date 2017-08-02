CREATE DATABASE [iottestdb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'iottestdb', FILENAME = N'F:\Data\iottestdb.mdf' , SIZE = 4096KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'iottestdb_log', FILENAME = N'F:\Data\iottestdb_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)