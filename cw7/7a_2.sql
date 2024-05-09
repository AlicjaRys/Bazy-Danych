USE normalizacja;

Create schema zamowienia;

CREATE TABLE zamowienia.Produkty (
    NazwaProduktu VARCHAR(255) PRIMARY KEY,
    CenaID INT
);

CREATE TABLE zamowienia.Dostawca1 (
    Dostawca1 VARCHAR(255) PRIMARY KEY,
    AdresDostawcy1 VARCHAR(255)
);

CREATE TABLE zamowienia.Dostawca2 (
    Dostawca2 VARCHAR(255) PRIMARY KEY,
    AdresDostawcy2 VARCHAR(255)
);


CREATE TABLE zamowienia.Ceny (
    CenaID INT PRIMARY KEY,
    CenaNetto VARCHAR(50),
    CenaBrutto VARCHAR(50)
);

CREATE TABLE zamowienia.ProduktyDostawcy (
    NazwaProduktu VARCHAR(255),
    Dostawca1 VARCHAR(255),
    Dostawca2 VARCHAR(255),
    FOREIGN KEY (NazwaProduktu) REFERENCES zamowienia.Produkty(NazwaProduktu),
    FOREIGN KEY (Dostawca1) REFERENCES zamowienia.Dostawca1(Dostawca1),
    FOREIGN KEY (Dostawca2) REFERENCES zamowienia.Dostawca2(Dostawca2)
);



INSERT INTO zamowienia.Produkty (NazwaProduktu, CenaID)
VALUES
    ('Makaron Nitki', 1),
    ('Keczup pikantny', 2),
    ('Sos pomidorowy', 3);

INSERT INTO zamowienia.Ceny (CenaID, CenaNetto, CenaBrutto)
VALUES
    (1, '130 z�', '150 z�'),
    (2, '200 z�', '220 z�'),
    (3, '89 z�', '110 z�');

INSERT INTO zamowienia.Dostawca1 (Dostawca1, AdresDostawcy1)
VALUES
    ('Makarony Polskie', 'Turystyczna 40, 31-435 Krak�w'),
    ('Polskie przetwory', 'Wojska Polskiego 44a, 31-342 Krak�w');

INSERT INTO zamowienia.Dostawca2 (Dostawca2, AdresDostawcy2)
VALUES
    ('Lubelski Makaron', 'Pi�sudskiego 332a, 04-242 Lublin'),
    ('Przetwory pomidorowe', 'Rolnicza 22/4, 30-243 Tarn�w'),
	('Ma�opolskie smaki', 'Mickiewicza 223/77, 35-434 Nowy Targ');


INSERT INTO zamowienia.ProduktyDostawcy (NazwaProduktu, Dostawca1, Dostawca2)
VALUES
    ('Makaron Nitki', 'Makarony Polskie', 'Lubelski Makaron'),
    ('Keczup pikantny', 'Polskie przetwory', 'Przetwory pomidorowe'),
    ('Sos pomidorowy', 'Polskie przetwory', 'Ma�opolskie smaki');

SELECT * FROM zamowienia.Produkty;
SELECT * FROM zamowienia.Ceny;
SELECT * FROM zamowienia.Dostawca1;
SELECT * FROM zamowienia.Dostawca2;
SELECT * FROM zamowienia.ProduktyDostawcy;

--wy�wietlenie tabeli w odpowiednim uk�adzie
SELECT 
    p.NazwaProduktu,
    d1.Dostawca1,
    d2.Dostawca2,
    d1.AdresDostawcy1,
    d2.AdresDostawcy2,
    'Netto ' + c.CenaNetto + ', ' + 'brutto ' + c.CenaBrutto AS Cena
FROM 
    zamowienia.Produkty p
JOIN 
    zamowienia.ProduktyDostawcy pd ON p.NazwaProduktu = pd.NazwaProduktu
JOIN 
    zamowienia.Dostawca1 d1 ON pd.Dostawca1 = d1.Dostawca1
JOIN 
    zamowienia.Dostawca2 d2 ON pd.Dostawca2 = d2.Dostawca2
JOIN 
    zamowienia.Ceny c ON p.CenaID = c.CenaID;