CREATE DATABASE firma;

CREATE SCHEMA rozliczenia;

USE firma;

CREATE TABLE rozliczenia.pracownicy (
    id_pracownika INTEGER NOT NULL PRIMARY KEY,
    imie VARCHAR(15) NOT NULL,
    nazwisko VARCHAR(20) NOT NULL,
    adres VARCHAR(40),
    telefon VARCHAR(20)
);

CREATE TABLE rozliczenia.godziny (
    id_godziny INTEGER NOT NULL PRIMARY KEY,
    data DATE NOT NULL,
    liczba_godzin FLOAT NOT NULL,
    id_pracownika INTEGER NOT NULL
	FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika)
);

CREATE TABLE rozliczenia.pensje (
    id_pensji INTEGER NOT NULL PRIMARY KEY,
    stanowisko VARCHAR(30),
    kwota FLOAT NOT NULL,
    id_premii INTEGER
	FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii)
);

CREATE TABLE rozliczenia.premie (
    id_premii INTEGER NOT NULL PRIMARY KEY,
    rodzaj VARCHAR(50),
    kwota INTEGER 
);

ALTER TABLE rozliczenia.godziny
ADD CONSTRAINT id_pracownika
FOREIGN KEY (id_pracownika)
REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE rozliczenia.pensje
ADD CONSTRAINT id_premii
FOREIGN KEY (id_premii) 
REFERENCES rozliczenia.pracownicy(id_premii);

-- 4. Wype³nienie tabeli pracownicy danymi losowymi dla 10 pracowników
INSERT INTO rozliczenia.pracownicy (imie, nazwisko, adres, telefon)
VALUES
    ('Adam', 'Nowak', 'ul. Lipowa 10, Warszawa', '111-222-333'),
    ('Ewa', 'Kowalska', 'ul. Polna 5, Kraków', '444-555-666'),
    ('Micha³', 'Wiœniewski', 'ul. Leœna 20, Gdañsk', '777-888-999'),
    ('Karolina', 'Kaczmarek', 'ul. S³oneczna 30, Poznañ', '123-456-789'),
    ('Piotr', 'Lewandowski', 'ul. Radosna 15, Wroc³aw', '987-654-321'),
    ('Magdalena', 'D¹browska', 'ul. Jesienna 12, £ódŸ', '111-222-333'),
    ('Kamil', 'Wójcik', 'ul. Nadmorska 7, Gdynia', '444-555-666'),
    ('Aleksandra', 'Jankowska', 'ul. Zielona 14, Szczecin', '777-888-999'),
    ('Grzegorz', 'Wojciechowski', 'ul. Wiejska 2, Lublin', '123-456-789'),
    ('Anna', 'Kowalczyk', 'ul. Przemys³owa 6, Katowice', '987-654-321');

-- 4. Wype³nienie tabeli godziny danymi losowymi dla 10 pracowników
INSERT INTO rozliczenia.godziny (data, liczba_godzin, id_pracownika)
VALUES
    ('2024-04-01', 8, 1),
    ('2024-04-02', 7, 2),
    ('2024-04-03', 9, 3),
    ('2024-04-04', 8, 4),
    ('2024-04-05', 7, 5),
    ('2024-04-06', 9, 6),
    ('2024-04-07', 8, 7),
    ('2024-04-08', 7, 8),
    ('2024-04-09', 9, 9),
    ('2024-04-10', 8, 10);

--4. Wype³nienie tabeli pensje danymi losowymi dla 10 pracowników
INSERT INTO rozliczenia.pensje (stanowisko, kwota, id_premii)
VALUES
    ('Kierownik', 5500, 1),
    ('Pracownik', 4500, 2),
    ('Pracownik', 4000, 3),
    ('Kierownik', 5300, 4),
    ('Pracownik', 4700, 5),
    ('Kierownik', 5800, 6),
    ('Pracownik', 4200, 7),
    ('Pracownik', 4100, 8),
    ('Kierownik', 5600, 9),
    ('Pracownik', 4300, 10);

--4. Wype³nienie tabeli premie danymi losowymi dla 10 pracowników
INSERT INTO rozliczenia.premie (rodzaj, kwota)
VALUES
    ('Premia za wyniki', 1200),
    ('Premia za sta¿', 800),
    ('Premia za wyniki', 1500),
    ('Premia kwartalna', 1000),
    ('Premia za sta¿', 900),
    ('Premia za wyniki', 1300),
    ('Premia kwartalna', 1100),
    ('Premia za wyniki', 1400),
    ('Premia za sta¿', 850),
    ('Premia kwartalna', 950);
	
--5. wyœwietlenie nazwisk i adresów
SELECT nazwisko, adres
FROM rozliczenia.pracownicy;

--6. przekonwertowanie daty
SELECT data
    DATEPART(DW, data) AS dzien_tygodnia, 
    DATEPART(MONTH, data) AS miesiac
FROM 
    rozliczenia.godziny;


-- 7. Zmiana nazwy kolumny kwota na kwota_brutto
ALTER TABLE rozliczenia.pensje
RENAME COLUMN kwota to kwota_brutto;

-- 7. Dodanie nowej kolumny kwota_netto
ALTER TABLE rozliczenia.pensje
ADD COLUMN kwota_netto DECIMAL(10,2);

-- 7. Obliczenie i aktualizacja wartoœci kwoty netto
UPDATE rozliczenia.pensje
SET kwota_netto = kwota_brutto / 1.23; -- 
