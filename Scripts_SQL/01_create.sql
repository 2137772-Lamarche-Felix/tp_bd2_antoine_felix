/*
 * Code de création des données de la bd.
 *
 * Fichier : 01_create.sql
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
	livre_id INTEGER NOT NULL,
	/* Contraintes */
	FOREIGN KEY (auteur_id) REFERENCES auteur(id),
	FOREIGN KEY (livre_id) REFERENCES livre(id)
);

DROP TABLE IF EXISTS chapitre;
CREATE TABLE chapitre (
	no_chapitre INTEGER PRIMARY KEY NOT NULL,
	livre_id INTEGER NOT NULL,
	texte TEXT NOT NULL,
	/* Contraintes */
	FOREIGN KEY (livre_id) REFERENCES livre(id)
);

DROP TABLE IF EXISTS lien_chapitre;
CREATE TABLE lien_chapitre (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	no_chapitre_source INTEGER NOT NULL,
	no_chapitre_destination INTEGER NOT NULL,
	/* Contraintes */
	FOREIGN KEY (no_chapitre_source) REFERENCES chapitre(no_chapitre),
	FOREIGN KEY (no_chapitre_destination) REFERENCES chapitre(no_chapitre)
);

DROP TABLE IF EXISTS sauvegarde;
CREATE TABLE sauvegarde (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	nom VARCHAR(30) NOT NULL,
	livre_id INTEGER NOT NULL,
	no_chapitre_rendu INTEGER NOT NULL,
	champ_armes TEXT,
	champ_inventaire TEXT,
	champ_disciplines TEXT,
	/* Contraintes */
	FOREIGN KEY (livre_id) REFERENCES livre(id),
	FOREIGN KEY (no_chapitre_rendu) REFERENCES chapitre(no_chapitre)
);