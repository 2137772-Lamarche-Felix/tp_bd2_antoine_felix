/*
 * Code d'insertion des données de la bd pour les caracteristiques disponibles
 * pour les personnages.
 *
 * Fichier : 05_insert_caracteristiques.sql
 * Auteur : Antoine Ouellette, Félix Lamarche
 * Langage : SQL
 * Date : novembre 2022
 */

USE bddeux_livre_hero;

/********************************************************************************/

/* insert des armes */
INSERT INTO arme(nom) VALUES
('Poignard'),
('Lance'),
('Masse d''armes'),
('Sabre'),
('Marteau de guerre'),
('Épée'),
('Hache'),
('Épée longue'),
('Baton'),
('Glaive');

/* insert des objets */
INSERT INTO objet(nom) VALUES
('Tunique de Seigneur Kaï verte'),
('Cape de Seigneur Kaï verte'),
('Repas'),
('Carte Géographique'),
('Casque'),
('Cotte de mailles'),
('Potion de guérison'),
('Couronnes');

/* insert des disciplines */
INSERT INTO discipline(nom) VALUES
('Camouflage'),
('Chasse'),
('Camouflage'),
('Sixième sens'),
('Orientation'),
('Guérison'),
('Maîtrise des armes'),
('Bouclier psychique'),
('Puissance psychique'),
('Communication Animale'),
('Maîtrise psychique de la matière');