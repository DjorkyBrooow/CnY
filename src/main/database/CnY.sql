DROP DATABASE IF EXISTS cny_ecommerce;
CREATE DATABASE cny_ecommerce;
USE cny_ecommerce;

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `r_id` int NOT NULL AUTO_INCREMENT,
  `r_nom` varchar(255) NOT NULL,
  PRIMARY KEY (`r_id`)
);

INSERT INTO `role`(`r_nom`) VALUES ('client'),('admin');

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE `utilisateur` (
  `u_id` int NOT NULL AUTO_INCREMENT,
  `u_prenom` varchar(255) NOT NULL,
  `u_email` varchar(255) NOT NULL,
  `u_mdp` varchar(255) NOT NULL,
  `fk_r_id` int NOT NULL,
  PRIMARY KEY (`u_id`),
  UNIQUE KEY `u_email_UNIQUE` (`u_email`),
  FOREIGN KEY (`fk_r_id`) REFERENCES role(`r_id`)
);

INSERT INTO `utilisateur`(`u_prenom`,`u_email`,`u_mdp`,`fk_r_id`) VALUES ('Lucas','luc@s','lucas',2);

DROP TABLE IF EXISTS `commande`;
CREATE TABLE `commande` (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `fk_u_id` int NOT NULL,
  `c_date` varchar(255) NOT NULL,
  `c_prix` double NOT NULL,
  PRIMARY KEY (`c_id`),
  FOREIGN KEY (`fk_u_id`) REFERENCES utilisateur(`u_id`)
);


DROP TABLE IF EXISTS `produit`;
CREATE TABLE `produit` (
  `p_id` int NOT NULL AUTO_INCREMENT,
  `p_nom` varchar(255) NOT NULL,
  `p_categorie` varchar(255) NOT NULL,
  `p_prix` double NOT NULL,
  `p_image` varchar(255) NOT NULL,
  PRIMARY KEY (`p_id`)
);

INSERT INTO `produit`(`p_nom`,`p_categorie`,`p_prix`,`p_image`) VALUES ('t-shirt blanc','t-shirt haut',15,'tshirt_blanc.png'),('polo bleue','polo haut',30,'polo_bleue.png'),('chemise noire','chemise haut',35,'chemise_noire.png'),('jean bleu','pantalon jean bas',35,'jean_bleu.png'),('jupe','jupe bas femme',30,'jupe.png'),('sweat en laine','sweat haut',40,'sweat_laine.png'),('robe','robe tenue',60,'robe.png'),('sweat','sweat pull haut',30,'sweat.png');
INSERT INTO `produit`(`p_nom`,`p_categorie`,`p_prix`,`p_image`) VALUES ('bermuda marron','bermuda bas',13,'bermuda_marron.png'),('doudoune noire','doudoune haut',50,'doudoune_noire.png'),('doudoune orange','doudoune haut',45,'doudoune_orange.png'),('jogging','jogging bas',25,'jogging.png'),('polo violet','polo haut',30,'polo_violet.png'),('t-shirt rose','t-shirt haut',15,'tshirt_rose.png'),('t-shirt sport','t-shirt haut',15,'tshirt_sport.png');
INSERT INTO `produit`(`p_nom`,`p_categorie`,`p_prix`,`p_image`) VALUES ('veste bleue','veste haut',45,'veste_bleue.png'),('veste grise','veste haut',40,'veste_grise.png'),('veste � capuche','veste haut',45,'veste_capuche.png'),('veste noire','veste haut',40,'veste_noire.png'),('veste de sport','veste haut',40,'veste_sport.png');

DROP TABLE IF EXISTS `article_panier`;
CREATE TABLE `article_panier` (
  `ap_id` int NOT NULL AUTO_INCREMENT,
  `fk_p_id` int NOT NULL,
  `fk_c_id` int NOT NULL,
  `ap_quantite` int NOT NULL,
  PRIMARY KEY (`ap_id`),
  FOREIGN KEY (`fk_p_id`) REFERENCES produit(`p_id`),
  FOREIGN KEY (`fk_c_id`) REFERENCES commande(`c_id`)
);
