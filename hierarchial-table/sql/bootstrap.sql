/*
  Bootstrap
*/

DROP DATABASE IF EXISTS `ClosureTable`;

CREATE DATABASE `ClosureTable`;

USE `ClosureTable`;

CREATE TABLE `Nodes`(
  `node_id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  `node` VARCHAR(100) UNIQUE NOT NULL
); 

CREATE TABLE `NodePaths`(
  `parent` SMALLINT(5) UNSIGNED NOT NULL, 
  `child` SMALLINT(5) UNSIGNED NOT NULL, 
  `depth` TINYINT(2) UNSIGNED NOT NULL DEFAULT 0, 
  FOREIGN KEY (`parent`) REFERENCES `Nodes`(`node_id`), 
  FOREIGN KEY (`child`) REFERENCES `Nodes`(`node_id`)
);

INSERT INTO `Nodes` (`node`) VALUES ('Williemae Puglia'),   -- 1
  ('Sung Davis'), -- 2
  ('Jenelle Reep'),   -- 3
  ('Sudie Satterlee'),   -- 4
  ('Jeanie Tegeler'),   -- 5
  ('Verena Mowers'),   -- 6
  ('Donnette Erwin'),   -- 7
  ('Brook Lofthouse'),   -- 8
  ('Jacklyn Siller'),   -- 9
  ('Allyn Hembree'),   -- 10
  ('Olinda Daws'),   -- 11
  ('Claud Silverstein'),   -- 12
  ('Bernadette Madigan'),   -- 13
  ('Stephany Valla'),   -- 14
  ('Ivana Lockamy'),   -- 15
  ('Sonja Bermejo'),   -- 16
  ('Wilford Stanback'),   -- 17
  ('Michael Empey'),   -- 18
  ('Joelle Sluss'),   -- 19
  ('Hellen Goltz'),   -- 20
  ('Terence Carter'),   -- 21
  ('Elbert Gauldin'),   -- 22
  ('Louis McMinn'),   -- 23
  ('Annabelle Keppel'),   -- 24
  ('Brigitte Shrock'),   -- 25
  ('Kathern Voisine'),   -- 26
  ('Valorie Hay'),   -- 27
  ('Tiffany Palombo'),   -- 28
  ('Sharell Coster'),   -- 29
  ('Karina Jack'),   -- 30
  ('Leigh Lach'),   -- 31
  ('Patience Meyers'),   -- 32
  ('Noelle Burrage');   -- 33

-- Williemae Puglia (1)
INSERT INTO `NodePaths` (`parent`, `child`, `depth`) VALUES (1, 1, 0), 
  -- Sung Davis (2)
  (1, 2, 1), (2, 2, 0), 
  -- Jenelle Reep (3)
  (1, 3, 2), (2, 3, 1), (3, 3, 0), 
  -- Sudie Satterlee (4)
  (1, 4, 3), (2, 4, 2), (3, 4, 1), (4, 4, 0), 
  -- Jeanie Tegeler (5)
  (1, 5, 3), (2, 5, 2), (3, 5, 1), (5, 5, 0), 
  -- Verena Mowers (6)
  (1, 6, 4), (2, 6, 3), (3, 6, 2), (5, 6, 1), (6, 6, 0), 
  -- Donnette Erwin (7)
  (1, 7, 4), (2, 7, 3), (3, 7, 2), (5, 7, 1), (7, 7, 0), 
  -- Brook Lofthouse (8)
  (1, 8, 3), (2, 8, 2), (3, 8, 1), (8, 8, 0), 
  -- Jacklyn Siller (9)
  (1, 9, 2), (2, 9, 1), (9, 9, 0), 
  -- Allyn Hembree (10)
  (1, 10, 3), (2, 10, 2), (9, 10, 1), (10, 10, 0), 
  -- Olinda Daws (11)
  (1, 11, 3), (2, 11, 2), (9, 11, 1), (11, 11, 0), 
  -- Claud Silverstein (12)
  (1, 12, 3), (2, 12, 2), (9, 12, 1), (12, 12, 0), 
  -- Bernadette Madigan (13)
  (1, 13, 2), (2, 13, 1), (13, 13, 0), 
  -- Stephany Valla (14)
  (1, 14, 2), (2, 14, 1), (14, 14, 0), 
  -- Ivana Lockamy (15)
  (1, 15, 2), (2, 15, 1), (15, 15, 0), 
  -- Sonja Bermejo (16)
  (1, 16, 2), (2, 16, 1), (16, 16, 0), 
  -- Wilford Stanback (17)
  (1, 17, 1), (17, 17, 0), 
  -- Michael Empey (18)
  (1, 18, 2), (17, 18, 1), (18, 18, 0), 
  -- Joelle Sluss (19)
  (1, 19, 3), (17, 19, 2), (18, 19, 1), (19, 19, 0), 
  -- Hellen Goltz (20)
  (1, 20, 3), (17, 20, 2), (18, 20, 1), (20, 20, 0), 
  -- Terence Carter (21)
  (1, 21, 3), (17, 21, 2), (18, 21, 1), (21, 21, 0), 
  -- Elbert Gauldin (22)
  (1, 22, 4), (17, 22, 3), (18, 22, 2), (21, 22, 1), (22, 22, 0), 
  -- Louis McMinn (23)
  (1, 23, 5), (17, 23, 4), (18, 23, 3), (21, 23, 2), (22, 23, 1), (23, 23, 0), 
  -- Annabelle Keppel (24)
  (1, 24, 3), (17, 24, 2), (18, 24, 1), (24, 24, 0), 
  -- Brigitte Shrock (25)
  (1, 25, 2), (17, 25, 1), (25, 25, 0), 
  -- Kathern Voisine (26)
  (1, 26, 2), (17, 26, 1), (26, 26, 0), 
  -- Valorie Hay (27)
  (1, 27, 3), (17, 27, 2), (26, 27, 1), (27, 27, 0), 
  -- Tiffany Palombo (28)
  (1, 28, 3), (17, 28, 2), (26, 28, 1), (28, 28, 0), 
  -- Sharell Coster (29)
  (1, 29, 2), (17, 29, 1), (29, 29, 0), 
  -- Karina Jack (30)
  (1, 30, 1), (30, 30, 0), 
  -- Leigh Lach (31)
  (1, 31, 2), (30, 31, 1), (31, 31, 0), 
  -- Patience Meyers (32)
  (1, 32, 1), (32, 32, 0), 
  -- Noelle Burrage (33)
  (1, 33, 2), (32, 33, 1), (33, 33, 0);
