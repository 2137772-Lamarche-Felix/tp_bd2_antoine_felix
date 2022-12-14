/*
 * Code d'insertion des données de la bd pour les livres.
 *
 * Fichier : 02_insert_livre.sql
 * Auteur : Antoine Ouellette, Félix Lamarche
 * Langage : SQL
 * Date : novembre 2022
 */

USE bddeux_livre_hero;

/********************************************************************************/

/* insert des auteurs */
INSERT INTO auteur(prenom, nom) VALUES
('Joe', 'Dever'),
('Gary', 'Chalk'),
('Antoine','Ouellette'),
('Félix', 'Lamarche');

/* insert des livres */
INSERT INTO livre(nom, titre_prologue, prologue) VALUES
('Loup Solitaire - Les Maîtres des Ténèbres/1', 'Avertir le roi', 'Au nord du royaume du Sommerlund, il est de tradition depuis des siècles d''envoyer les fils des Seigneurs de la Guerre au monastère Kaï. C''est là qu''on leur enseigne l''art et la science de leurs nobles ancêtres. Les Moines Kaï sont de grands maîtres dans l''art qu''ils enseignent. Pour transmettre leurs connaissances, ils doivent faire subir à leurs disciples de rudes épreuves au cours de leur apprentissage, mais ces derniers ne s''en plaignent jamais. Ils leur témoignent au contraire amour et respect, sachant très bien qu''ils quitteront un jour le monastère en possédant tous les secrets de la tradition Kaï: ils pourront alors rentrer chez eux, l''esprit et le corps formés aux techniques de la guerre. Profondément attachés à leur patrie, ils seront ainsi prêts à la défendre contre le danger constant qui la menace : la soif de conquête des Maîtres des Ténèbres venus de l''ouest. Au temps jadis, à l''époque de la Lune Noire, les Maîtres des Ténèbres menèrent une guerre sans merci contre le royaume du Sommerlund. Ce fut une longue et douloureuse épreuve de force à l''issue de laquelle les guerriers du Sommerlund remportèrent la victoire lors de la grande bataille de Maaken. Le roi Ulnar et ses alliés de Durenor anéantirent l''armée des Maîtres des Ténèbres dans le défilé de Moytura et précipitèrent l''ennemi au fond de la gorge de Maaken. Vashna, le plus puissant parmi les Maîtres des Ténèbres, périt d''un coup mortel que le roi Ulnar lui porta de sa puissante épée, l''Epée du Soleil, que l''on désigne généralement sous le nom de «Glaive de Sommer». Depuis ce temps, les Maîtres des Ténèbres ont juré de prendre leur revanche sur le royaume du Sommerlund et la Maison d''Ulnar. Lorsque l''aube se lève sur le premier jour de votre aventure, tous les Seigneurs Kaï sont présents au monastère : on doit, en effet, célébrer aujourd''hui même la grande fête de Fehmarn et l''on se prépare tôt le matin aux réjouissances. Mais soudain, un immense nuage noir s''élève au ciel d''occident: d''énormes   créatures aux ailes sombres emplissent les nues en si grand nombre que le soleil semble s''éteindre. Cette invasion porte la marque des Maîtres des Ténèbres. Les ennemis jurés du Royaume du Sommerlund passent une nouvelle fois à l''attaque : la guerre a recommencé. En ce matin fatal, Loup Silencieux (c''est le nom qui vous a été donné par les Moines Kaï) est allé chercher du bois dans la forêt : c''est la corvée qu''on vous a assignée pour vous punir de votre inattention en classe. Or, sur le chemin du retour, vous apercevez tout à coup ce gigantesque nuage de créatures noires qui fond sur le monastère et semble l''engloutir aussitôt. Vous laissez tomber votre bois à terre et vous vous précipitez sur le lieu de la bataille. Mais les monstres noirs ont obscurci le soleil et il fait à présent si sombre que vous trébuchez contre une racine en tombant tête la première. Dans votre chute, vous heurtez violemment du front une branche basse qui vous assomme. Une fraction de seconde avant de perdre connaissance, vous avez cependant le temps de saisir du regard un terrifiant spectacle: les murs du monastère Kaï sont en train de s''écrouler sur eux-mêmes dans un fracas de tonnerre. Vous ne reprenez conscience qu''au bout de plusieurs heures et, les larmes aux yeux, vous contemplez avec horreur le tas de ruines que l''ennemi a laissé derrière lui. Les Guerriers Kaï ont été ensevelis sous les décombres et il ne reste plus aucun survivant parmi vos compagnons. Avec une infinie douleur, vous levez alors votre visage vers le ciel, à nouveau clair, et vous faites le serment de venger la mort des Moines et des Seigneurs Kaï. Vous ferez payer leur crime aux Maîtres des Ténèbres ! Votre tâche d''ailleurs commence à l''instant même : il vous faut, en effet, gagner la capitale du royaume pour prévenir le Roi en personne de l''effroyable péril qui menace le pays ; car maintenant, l''ennemi est en marche, et si vous n''agissez pas à temps, votre patrie tombera sous son joug. Vous êtes le dernier des Seigneurs Kaï et le sort de votre peuple repose désormais entre vos seules mains: le Loup Silencieux est devenu Loup Solitaire et les envahisseurs feront tout pour vous empêcher d''atteindre le Palais du Roi...'),
('Thriller - La chute du jeux 2D', 'La libération', 'Nous avons été libéré de ce calvaire qu''était le cours de jeux 2D');
/* insert des associations auteur-livre */
INSERT INTO auteur_livre(auteur_id, livre_id) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2);