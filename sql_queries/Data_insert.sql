USE Hardware

DELETE FROM dbo.CPU
DELETE FROM dbo.GPU
DELETE FROM dbo.RAM
DELETE FROM dbo.Motherboard
DELETE FROM dbo.CPU_Radiator
DELETE FROM dbo.PSU
DELETE FROM dbo.HDD
DELETE FROM dbo.SSD


INSERT INTO dbo.CPU

SELECT 'Intel Core i5 2400', '1155', 4, 4, 3100, 95, 0, 6, 1, 0, 916 UNION ALL
SELECT 'Intel Core i9 9940X', '2066', 14, 28, 3300, 165, 1, 19, 0, 1, 24500 UNION ALL
SELECT 'Intel Core i7 3770', '1155', 4, 8, 3400, 77, 0, 8, 1, 1, 3999 UNION ALL
SELECT 'Intel Core i5 9400', '1151v2', 6, 6, 2900, 65, 0, 9, 1, 0, 5500 UNION ALL
SELECT 'Intel Core i7 6700k', '1151', 4, 8, 4000, 91, 1, 8, 1, 1, 8400 UNION ALL
SELECT 'Intel Core i7 8700', '1151', 6, 12, 3200, 65, 0, 12, 0, 1, 9302


INSERT INTO dbo.GPU

SELECT 'Nvidia GeForce GT 1030', 'Office', 2, 6000, 1468, 0, 24, 384, 30, '4k', 2171 UNION ALL
SELECT 'Nvidia Geforce GTX 1050ti', 'Gaming', 4, 7000, 1341, 0, 48, 768, 75, '8k', 4300 UNION ALL
SELECT 'Nvidia Geforce GTX 1060', 'Gaming', 3, 8000, 1500, 0, 72, 1152, 120, '8k', 3400 UNION ALL
SELECT 'Nvidia GeForce GTX 1070', 'Gaming', 8, 8000, 1500, 0, 120, 1920, 150, '8k', 6950 UNION ALL
SELECT 'Nvidia GeForce GTX 1080', 'Gaming', 8, 10108, 1708, 0, 160, 2560, 180, '8k', 11752 UNION ALL
SELECT 'Nvidia Geforce RTX 2060', 'Gaming', 6, 14000, 1365, 1, 120, 1920, 160, '8k', 11200 UNION ALL
SELECT 'Nvidia Geforce RTX 2070', 'Gaming', 8, 14000, 1935, 1, 160, 2560, 215, '8k', 19718 UNION ALL
SELECT 'Nvidia Geforce RTX 2080', 'Gaming', 8, 14000, 1710, 1, 184, 2944, 250, '8k', 19690 UNION ALL
SELECT 'Nvidia Quadro M4000M', 'Professional', 4, 6000, 1227, 0, 80, 1280, 100, '4k', 18500 UNION ALL
SELECT 'Integrated', 'Office', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0



INSERT INTO dbo.RAM

SELECT 'Kingston ValueRAM', 'DDR4', 4, 2400, 1, 0, 584 UNION ALL
SELECT 'TeamGroup Vulcan Z', 'DDR4', 8, 2666, 2, 1, 876 UNION ALL
SELECT 'Patriot Viper Steel', 'DDR4', 8, 3200, 2, 1, 1176 UNION ALL
SELECT 'Patriot Signature', 'DDR4', 16, 2400, 2, 0, 1615 UNION ALL
SELECT 'Geil EVO Spear', 'DDR4', 16, 3200, 2, 1, 2045 UNION ALL
SELECT 'Patriot Signature DDR3', 'DDR3', 4, 1600, 2, 0, 411 UNION ALL
SELECT 'GOODRAM DDR3', 'DDR3', 16, 1600, 2, 0, 1960


INSERT INTO dbo.Motherboard

SELECT 'Asus Prime Z270-P', 'ATX', '1151', 'Z270', 'DDR4', 3866, 2, 1, 'SATA/M.2', 1, 1270 UNION ALL
SELECT 'Asus H110M-CS', 'Micro-ATX', '1151', 'H110', 'DDR4', 2133, 2, 1, 'SATA', 0, 1385 UNION ALL
SELECT 'ASrock H310M-DVS', 'Micro-ATX', '1151v2', 'H310', 'DDR4', 2666, 2, 1, 'SATA', 0, 1401 UNION ALL
SELECT 'Gigabyte GA-H61M-DS2', 'Micro-ATX', '1155', 'H61M', 'DDR3', 1600, 2, 1, 'SATA', 0, 1440 UNION ALL
SELECT 'MSI X299 GAMING PRO CARBON', 'ATX', '2066', 'X299', 'DDR4', 4500, 4, 0, 'SATA/M.2', 1, 5151


INSERT INTO dbo.CPU_Radiator

SELECT 'DeepCool Gamma Archer', 'AM2/AM3/FM1/FM2/AM4/775/1150/1155/1156/1151/1151v2', 'Horizontal', 95, 21, 200 UNION ALL
SELECT 'DeepCool GAMMAXX 300', 'AM2/AM3/FM1/FM2/AM4/775/1150/1155/1156/1151/1151v2', 'Tower', 130, 21, 488 UNION ALL
SELECT 'ARCTIC Freezer 34 CO', 'AM4/1150/1155/1156/2011/2011v3/Intel2066/1151/1151v2', 'Tower', 150, 21, 832 UNION ALL
SELECT 'Aardwolf Performa 10X', 'AM2/AM3/FM1/FM2/AM4/775/1150/1155/1156/1366/2011/2011v3/2066/1151/1151v2', 'Tower', 180, 35, 999 UNION ALL
SELECT 'Cooler Master MasterAir  MA620P', 'AM2/AM3/FM1/FM2/AM4/775/1150/1155/1156/1366/2011/2011v3/2066/1151/1151v2', 'Tower', 200, 31, 2233


INSERT INTO dbo.PSU

SELECT 'Raidmax XT Series', 'ATX', 'not_moduled', 400, 531 UNION ALL
SELECT 'Chieftec PPS', 'ATX', 'not_moduled', 500, 785 UNION ALL
SELECT 'Raidmax Cobra RX', 'ATX', 'semi-moduled', 700, 1163 UNION ALL
SELECT 'Chieftec Force', 'ATX', 'not_moduled', 750, 1699 UNION ALL
SELECT 'Chieftec A135 Modular', 'ATX', 'semi-moduled', 850, 2599


INSERT INTO dbo.HDD

SELECT 'Western Digital Caviar Blue WD5000AAKX', 'SATA3', 7200, 16, 500, 499 UNION ALL
SELECT 'Seagate Barracuda 7200. 12 ST500DM002', 'SATA3', 7200, 16, 500, 432 UNION ALL
SELECT 'Western Digital AV-GP WD10EURX', 'SATA3', 7200, 64, 1024, 869 UNION ALL
SELECT 'Seagata BarraCuda Compute ST500DM009', 'SATA3', 7200, 32, 500, 1017 UNION ALL
SELECT 'Western Digital Caviar Blue WD3200AAJS', 'SATA2', 7200, 8, 320, 389 UNION ALL
SELECT 'None', NULL, NULL, NULL, NULL, 0 


INSERT INTO dbo.SSD

SELECT 'Crucial BX500', 'SATA', 120, 540, 500, 718 UNION ALL
SELECT 'GOODRAM CL100 GEN 2 CL100-120', 'SATA', 120, 485, 380, 733 UNION ALL
SELECT 'GOODRAM CL100 GEN 2 CL100-480', 'SATA', 480, 550, 450, 1620 UNION ALL
SELECT 'Patriot Scorch M.2 PS128GPM280SSDR', 'M.2', 128, 1450, 415, 804 UNION ALL
SELECT 'Kingston A2000 M.2 SA2000M8/250G', 'M.2', 250, 2000, 1100, 1519 UNION ALL
SELECT 'None', NULL, NULL, NULL, NULL, 0

SELECT * FROM dbo.CPU
SELECT * FROM dbo.GPU
SELECT * FROM dbo.RAM
SELECT * FROM dbo.Motherboard
SELECT * FROM dbo.CPU_Radiator
SELECT * FROM dbo.PSU
SELECT * FROM dbo.HDD
SELECT * FROM dbo.SSD