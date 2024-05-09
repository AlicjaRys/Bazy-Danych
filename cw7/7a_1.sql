
USE normalizacja;

Create schema wizyty;

CREATE TABLE wizyty.Pracownicy (
    IDPracownika VARCHAR(10) PRIMARY KEY,
    NazwaLekarza VARCHAR(50)
);

CREATE TABLE wizyty.Pacjenci (
    IDPacjenta VARCHAR(10) PRIMARY KEY,
    NazwaPacjenta VARCHAR(50)
);

CREATE TABLE wizyty.Zabiegi (
    IDZabiegu VARCHAR(10) PRIMARY KEY,
    NazwaZabiegu VARCHAR(50)
);

CREATE TABLE wizyty.Wizyty (
    IDWizyty INT PRIMARY KEY,
    IDPracownika VARCHAR(10),
    IDPacjenta VARCHAR(10),
    DataGodzinaWizyty DATETIME,
    IDZabiegu VARCHAR(10),
    FOREIGN KEY (IDPracownika) REFERENCES wizyty.Pracownicy(IDPracownika),
    FOREIGN KEY (IDPacjenta) REFERENCES wizyty.Pacjenci(IDPacjenta),
    FOREIGN KEY (IDZabiegu) REFERENCES wizyty.Zabiegi(IDZabiegu)
);

INSERT INTO wizyty.Pracownicy (IDPracownika, NazwaLekarza)
VALUES
    ('S1011', 'Maria Nowak'),
    ('S1024', 'Jan Kowalski'),
    ('S1045', 'Anna Jab³oñska'),
    ('S1034', 'Marek Potocki');

INSERT INTO wizyty.Pacjenci (IDPacjenta, NazwaPacjenta)
VALUES
    ('P100', 'Anna Jeleñ'),
    ('P105', 'Jaros³aw Nicpoñ'),
    ('P108', 'Joanna Nosek'),
    ('P120', 'Jan Ka³u¿a'),
    ('P130', 'Jerzy Lis'),
    ('P123', 'Olga Nowacka');

INSERT INTO wizyty.Zabiegi (IDZabiegu, NazwaZabiegu)
VALUES
    ('Z500', 'Borowanie'),
    ('Z496', 'Lakowanie'),
    ('Z503', 'Usuwanie kamienia');

INSERT INTO wizyty.Wizyty (IDWizyty, IDPracownika, IDPacjenta, DataGodzinaWizyty, IDZabiegu)
VALUES
    (1, 'S1011', 'P100', '2020-03-12 10:00:00', 'Z500'),
    (2, 'S1011', 'P105', '2020-03-12 13:00:00', 'Z496'),
    (3, 'S1011', 'P108', '2020-03-14 10:00:00', 'Z500'),
    (4, 'S1024', 'P108', '2020-03-16 17:00:00', 'Z503'),
    (5, 'S1045', 'P120', '2020-03-18 09:00:00', 'Z500'),
    (6, 'S1034', 'P130', '2020-03-20 08:00:00', 'Z496'),
    (7, 'S1034', 'P123', '2020-03-12 15:00:00', 'Z503');

SELECT * FROM wizyty.Pracownicy;
SELECT * FROM wizyty.Pacjenci;
SELECT * FROM wizyty.Zabiegi;
SELECT * FROM wizyty.Wizyty;

--wyœwietlenie tabeli w odpowiednim uk³adzie
SELECT 
    W.IDPracownika, 
    P1.NazwaLekarza, 
    W.IDPacjenta, 
    P2.NazwaPacjenta, 
    W.DataGodzinaWizyty, 
    W.IDZabiegu, 
    Z.NazwaZabiegu
FROM 
    wizyty.Wizyty W
JOIN 
    wizyty.Pracownicy P1 ON W.IDPracownika = P1.IDPracownika
JOIN 
    wizyty.Pacjenci P2 ON W.IDPacjenta = P2.IDPacjenta
JOIN 
    wizyty.Zabiegi Z ON W.IDZabiegu = Z.IDZabiegu;


