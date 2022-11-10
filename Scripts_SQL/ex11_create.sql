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
	/* Contraintes */
	FOREIGN KEY (livre_id) REFERENCES livre(id),
	FOREIGN KEY (no_chapitre_rendu) REFERENCES chapitre(no_chapitre)
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

DROP TABLE IF EXISTS sauvegarde_arme;
CREATE TABLE sauvegarde_arme (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	sauvegarde_id INTEGER NOT NULL,
	arme_id INTEGER NOT NULL,
	/* Contraintes */
	FOREIGN KEY (sauvegarde_id) REFERENCES sauvegarde(id),
	FOREIGN KEY (arme_id) REFERENCES arme(id)
);

DROP TABLE IF EXISTS sauvegarde_objet;
CREATE TABLE sauvegarde_objet (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	sauvegarde_id INTEGER NOT NULL,
	objet_id INTEGER NOT NULL,
	/* Contraintes */
	FOREIGN KEY (sauvegarde_id) REFERENCES sauvegarde(id),
	FOREIGN KEY (objet_id) REFERENCES objet(id)
);

DROP TABLE IF EXISTS sauvegarde_discipline;
CREATE TABLE sauvegarde_discipline (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	sauvegarde_id INTEGER NOT NULL,
	discipline_id INTEGER NOT NULL,
	/* Contraintes */
	FOREIGN KEY (sauvegarde_id) REFERENCES sauvegarde(id),
	FOREIGN KEY (discipline_id) REFERENCES discipline(id)
);