CREATE TABLE GeoEon (
	id_eon INTEGER NOT NULL PRIMARY KEY,
    nazwa_eon VARCHAR(15) NOT NULL
);
CREATE TABLE GeoEra (
	id_era INTEGER NOT NULL PRIMARY KEY,
	id_eon INTEGER NOT null,
	nazwa_era VARCHAR(15) NOT null,
	FOREIGN KEY (id_eon) REFERENCES geo.GeoEon(id_eon)
);
CREATE TABLE GeoOkres(
	id_okres INTEGER NOT NULL PRIMARY KEY,
	id_era INTEGER NOT null,
		FOREIGN KEY (id_era) REFERENCES geo.GeoEra(id_era),
    nazwa_okres VARCHAR(15) NOT NULL	
);
CREATE TABLE GeoEpoka(
	id_epoka INTEGER NOT NULL PRIMARY KEY,
	id_okres INTEGER NOT null,
		FOREIGN KEY (id_okres) REFERENCES GeoOkres(id_okres),
    nazwa_epoka VARCHAR(15) NOT NULL	
);

CREATE TABLE GeoPietro(
	id_pietro INTEGER NOT NULL PRIMARY KEY,
	id_epoka INTEGER NOT null,
		FOREIGN KEY (id_epoka) references GeoEpoka(id_epoka),
    nazwa_pietro VARCHAR(15) NOT NULL	
);

--uzupełnienie tabel
INSERT INTO GeoEon (id_eon, nazwa_eon) VALUES (1, 'Fanerozoik');

INSERT INTO GeoEra (id_era, id_eon, nazwa_era) VALUES 
	(1, 1, 'Kenozoik'),
	(2, 1, 'Mezozoik'),
	(3, 1, 'Paleozoik');

INSERT INTO GeoOkres (id_okres, id_era, nazwa_okres) VALUES 
    (1, 1, 'Czwartorzęd'),
    (2, 1, 'Neogen'),
    (3, 1, 'Paleogen'),
    (4, 2, 'Kreda'),
    (5, 2, 'Jura'),
    (6, 2, 'Trias'),
    (7, 3, 'Perm'),
    (8, 3, 'Karbon'),
    (9, 3, 'Dewon');

INSERT INTO GeoEpoka (id_epoka, id_okres, nazwa_epoka) VALUES 
    (1, 1, 'Halocen'),
    (2, 1, 'Plejstocen'),
    (3, 2, 'Pliocen'),
    (4, 2, 'Miocen'),
    (5, 3, 'Oligocen'),
    (6, 3, 'Eocen'),
    (7, 3, 'Paleocen'),
    (8, 4, 'Górna'),
    (9, 4, 'Dolna'),
    (10, 5, 'Górna'),
    (11, 5, 'Środkowa'),
    (12, 5, 'Dolna'),
    (13, 6, 'Górna'),
    (14, 6, 'Środkowa'),
    (15, 6, 'Dolna'),
    (16, 7, 'Górny'),
    (17, 7, 'Dolny'),
    (18, 8, 'Górny'),
    (19, 8, 'Dolny'),
    (20, 9, 'Górny'),
    (21, 9, 'Środkowy'),
    (22, 9, 'Dolny');
   
--zdenormalizowany schemat tabeli geochronoligcznej
CREATE TABLE GeoTabela AS (SELECT * FROM GeoEpoka NATURAL 
JOIN GeoOkres NATURAL JOIN GeoEra NATURAL JOIN GeoEon );

ALTER TABLE GeoTabela
ADD PRIMARY KEY (id_epoka);


--wyświetlenie jako jednej tabeli
SELECT 
    eon.nazwa_eon AS Eon,
    era.nazwa_era AS Era,
    okres.nazwa_okres AS Okres,
    epoka.nazwa_epoka AS Epoka
FROM 
    geo.GeoEon eon
    JOIN geo.GeoEra era ON eon.id_eon = era.id_eon
    JOIN geo.GeoOkres okres ON era.id_era = okres.id_era
    JOIN geo.GeoEpoka epoka ON okres.id_okres = epoka.id_okres
ORDER BY 
    eon.id_eon, era.id_era, okres.id_okres, epoka.id_epoka;


-- Tworzenie tabeli Dziesiec
CREATE TABLE Dziesiec (
    cyfra INT,
    bit INT
);

-- uzupełnienie tabeli Dziesiec
INSERT INTO Dziesiec (cyfra, bit) VALUES 
    (0, 0), (1, 1), (2, 0), (3, 1), (4, 0), (5, 1), (6, 0), (7, 1), (8, 0), (9, 1);

SELECT * FROM geo.Dziesiec
SELECT * FROM Milion ORDER BY liczba

-- Tworzenie tabeli Milion na podstawie autozłączenia tabeli Dziesiec
CREATE TABLE Milion (liczba int, cyfra int, bit int);
INSERT INTO Milion
SELECT 
    a1.cyfra + 10 * a2.cyfra + 100 * a3.cyfra + 1000 * a4.cyfra + 10000 * a5.cyfra + 100000 * a6.cyfra AS liczba,
    a1.cyfra AS cyfra,
    a1.bit AS bit
FROM 
    Dziesiec a1, Dziesiec a2, Dziesiec a3, Dziesiec a4, Dziesiec a5, Dziesiec a6;

DROP TABLE Dziesiec



--zapytania 
SELECT COUNT(*) FROM Milion INNER JOIN GeoTabela ON 
(mod(Milion.liczba,22)=(GeoTabela.id_epoka));

SELECT COUNT(*) FROM Milion INNER JOIN GeoEpoka ON 
(mod(Milion.liczba,22)= GeoEpoka.id_epoka) NATURAL JOIN 
GeoOkres NATURAL JOIN GeoEra NATURAL JOIN GeoEon;

SELECT COUNT(*) FROM Milion WHERE mod(Milion.liczba,22)= 
(SELECT id_epoka FROM GeoTabela WHERE mod(Milion.liczba,22)=(id_epoka));

SELECT COUNT(*) FROM Milion WHERE mod(Milion.liczba,22) IN
(SELECT GeoEpoka.id_epoka FROM GeoEpoka NATURAL JOIN GeoOkres NATURAL JOIN GeoEra NATURAL JOIN GeoEon );

--PostgreSQL - sprawdzenie czasu
SELECT * FROM pg_stat_statements;
SELECT pg_stat_statements_reset();

--MySQL - sprawdzenie czasu
SET profiling = 1
SHOW PROFILES;

--utworzenie indeksów
CREATE INDEX idx_liczba_mod22 ON Milion ((mod(liczba, 22)));
CREATE INDEX idx_id_epoka ON GeoTabela (id_epoka);

CREATE INDEX idx_id_geoepoka ON GeoEpoka (id_epoka);
CREATE INDEX idx_id_okres ON GeoOkres (id_okres);
CREATE INDEX idx_id_era ON GeoEra (id_era);
CREATE INDEX idx_id_eon ON GeoEon (id_eon);