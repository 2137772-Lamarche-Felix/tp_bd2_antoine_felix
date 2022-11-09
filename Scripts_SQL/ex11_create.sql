/*
 * Code de création des données de la bd pour les livres.
 *
 * Fichier : CreationDonnees.sql
 * Auteur : Antoine Ouellette, Félix Lamarche
 * Langage : SQL
 * Date : novembre 2022
 */

DROP DATABASE IF EXISTS bddeux_livre_hero;
CREATE DATABASE bddeux_livre_hero;
USE bddeux_livre_hero;

/********************************************************************************/


DROP TABLE IF EXISTS auteur;
CREATE TABLE auteur (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	prenom VARCHAR(30) NOT NULL,
	nom VARCHAR(30) NOT NULL
);

DROP TABLE IF EXISTS livre;
CREATE TABLE livre (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	nom VARCHAR(50) NOT NULL,
	titre_prologue VARCHAR(50),
	prologue TEXT
);

DROP TABLE IF EXISTS auteur_livre;
CREATE TABLE auteur_livre (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	auteur_id INTEGER NOT NULL,
	livre_id INTEGER NOT NULL
);

DROP TABLE IF EXISTS chapitre;
CREATE TABLE chapitre (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	no_chapitre INTEGER NOT NULL,
	livre_id INTEGER NOT NULL,
	texte TEXT NOT NULL
);

DROP TABLE IF EXISTS lien_chapitre;
CREATE TABLE lien_chapitre (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	no_chapitre_source INTEGER NOT NULL,
	no_chapitre_destination INTEGER NOT NULL
);

DROP TABLE IF EXISTS sauvegarde;
CREATE TABLE sauvegarde (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	nom VARCHAR(30) NOT NULL,
	livre_id INTEGER NOT NULL,
	no_chapitre_rendu INTEGER NOT NULL,
);

DROP TABLE IF EXISTS arme;
CREATE TABLE arme (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	nom VARCHAR(30) NOT NULL
);

DROP TABLE IF EXISTS objet;
CREATE TABLE objet (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	nom VARCHAR(30) NOT NULL
);

DROP TABLE IF EXISTS discipline;
CREATE TABLE discipline (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	nom VARCHAR(30) NOT NULL
);

DROP TABLE IF EXISTS sauvegarde_association;
CREATE TABLE sauvegarde_association (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	sauvegarde_id INTEGER NOT NULL,
	arme_id INTEGER NOT NULL,
	objet_id INTEGER NOT NULL,
	discipline_id INTEGER NOT NULL
);




























































