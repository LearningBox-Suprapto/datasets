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
INSERT INTO `NodePaths` (`parent`, `child`) VALUES (1, 1), 
  -- Sung Davis (2)
  (1, 2), (2, 2), 
  -- Jenelle Reep (3)
  (1, 3), (2, 3), (3, 3), 
  -- Sudie Satterlee (4)
  (1, 4), (2, 4), (3, 4), (4, 4), 
  -- Jeanie Tegeler (5)
  (1, 5), (2, 5), (3, 5), (5, 5), 
  -- Verena Mowers (6)
  (1, 6), (2, 6), (3, 6), (5, 6), (6, 6), 
  -- Donnette Erwin (7)
  (1, 7), (2, 7), (3, 7), (5, 7), (7, 7), 
  -- Brook Lofthouse (8)
  (1, 8), (2, 8), (3, 8), (8, 8), 
  -- Jacklyn Siller (9)
  (1, 9), (2, 9), (9, 9), 
  -- Allyn Hembree (10)
  (1, 10), (2, 10), (9, 10), (10, 10), 
  -- Olinda Daws (11)
  (1, 11), (2, 11), (9, 11), (11, 11), 
  -- Claud Silverstein (12)
  (1, 12), (2, 12), (9, 12), (12, 12), 
  -- Bernadette Madigan (13)
  (1, 13), (2, 13), (13, 13), 
  -- Stephany Valla (14)
  (1, 14), (2, 14), (14, 14), 
  -- Ivana Lockamy (15)
  (1, 15), (2, 15), (15, 15), 
  -- Sonja Bermejo (16)
  (1, 16), (2, 16), (16, 16), 
  -- Wilford Stanback (17)
  (1, 17), (17, 17), 
  -- Michael Empey (18)
  (1, 18), (17, 18), (18, 18), 
  -- Joelle Sluss (19)
  (1, 19), (17, 19), (18, 19), (19, 19), 
  -- Hellen Goltz (20)
  (1, 20), (17, 20), (18, 20), (20, 20), 
  -- Terence Carter (21)
  (1, 21), (17, 21), (18, 21), (21, 21), 
  -- Elbert Gauldin (22)
  (1, 22), (17, 22), (18, 22), (21, 22), (22, 22), 
  -- Louis McMinn (23)
  (1, 23), (17, 23), (18, 23), (21, 23), (22, 23), (23, 23), 
  -- Annabelle Keppel (24)
  (1, 24), (17, 24), (18, 24), (24, 24), 
  -- Brigitte Shrock (25)
  (1, 25), (17, 25), (25, 25), 
  -- Kathern Voisine (26)
  (1, 26), (17, 26), (26, 26), 
  -- Valorie Hay (27)
  (1, 27), (17, 27), (26, 27), (27, 27), 
  -- Tiffany Palombo (28)
  (1, 28), (17, 28), (26, 28), (28, 28), 
  -- Sharell Coster (29)
  (1, 29), (17, 29), (29, 29), 
  -- Karina Jack (30)
  (1, 30), (30, 30), 
  -- Leigh Lach (31)
  (1, 31), (30, 31), (31, 31), 
  -- Patience Meyers (32)
  (1, 32), (32, 32), 
  -- Noelle Burrage (33)
  (1, 33), (32, 33), (33, 33);
