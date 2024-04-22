use firma;

create schema ksiegowosc;

create table ksiegowosc.pracownicy (
    id_pracownika INT PRIMARY KEY,
    imie VARCHAR(15) NOT NULL,
    nazwisko VARCHAR(20) NOT NULL,
    adres VARCHAR(40),
    telefon VARCHAR(20)
) COMMENT 'Tabela przechowująca dane o pracownikach';

create table ksiegowosc.godziny(
    id_godziny int primary key,
    data date not null,
    liczba_godzin float not null,
    id_pracownika int not null,
    FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika)
) COMMENT 'Tabela przechowująca dane o ilosci przepracowanych godzin';


create table ksiegowosc.pensja (
    id_pensji int primary key,
    stanowisko varchar(30),
    kwota double not null,
    id_premii int,
    FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii)
) COMMENT 'Tabela przechowujaca dane o otrzymywanej pensji, jej wysokosci oraz o zajmowanym stanowisku';

create table ksiegowosc.premia (
    id_premii INT PRIMARY KEY,
    rodzaj VARCHAR(50),
    kwota DOUBLE NOT NULL
) COMMENT 'Tabela przechowujaca dane o przyznanych premiach, ich rodzaju i wysokosci';

create table ksiegowosc.wynagrodzenie (
    id_wynagrodzenia INT PRIMARY KEY,
    data DATE NOT NULL,
    id_pracownika int,
    id_godziny int,
    id_pensji int,
    id_premii int,
    FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika),
    FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny),
    FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensja(id_pensji),
    FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii)
) COMMENT 'Tabela przechowujaca dane o finalnej wysokosci wynagrodzenia dla kazdego pracownika z informacja o ilosci wyrobionych godzin';

INSERT INTO ksiegowosc.pracownicy(id_pracownika, imie, nazwisko, adres, telefon)
VALUES
	(1, 'Adam', 'Nowak', 'ul. Lipowa 10, Warszawa', '111-222-333'),
    (2, 'Ewa', 'Kowalska', 'ul. Polna 5, Kraków', '444-555-666'),
    (3, 'Michał', 'Wiśniewski', 'ul. Leśna 20, Gdańsk', '777-888-999'),
    (4, 'Karolina', 'Kaczmarek', 'ul. Słoneczna 30, Poznań', '123-456-789'),
    (5, 'Piotr', 'Lewandowski', 'ul. Radosna 15, Wrocław', '987-654-321'),
    (6, 'Magdalena', 'Dąbrowska', 'ul. Jesienna 12, Łódź', '111-222-333'),
    (7, 'Kamil', 'Wójcik', 'ul. Nadmorska 7, Gdynia', '444-555-666'),
    (8, 'Aleksandra', 'Jankowska', 'ul. Zielona 14, Szczecin', '777-888-999'),
    (9, 'Grzegorz', 'Wojciechowski', 'ul. Wiejska 2, Lublin', '123-456-789'),
    (10, 'Anna', 'Kowalczyk', 'ul. Przemysłowa 6, Katowice', '987-654-321');

INSERT INTO ksiegowosc.godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES
    (1, '2024-04-01', 8, 1),
    (2, '2024-04-01', 7, 2),
    (3, '2024-04-02', 9, 3),
    (4, '2024-04-02', 8, 4),
    (5, '2024-04-03', 7, 5),
    (6, '2024-04-03', 9, 6),
    (7, '2024-04-04', 8, 7),
    (8, '2024-04-04', 7, 8),
    (9, '2024-04-05', 9, 9),
    (10, '2024-04-05', 8, 10);

INSERT INTO ksiegowosc.pensja (id_pensji, stanowisko, kwota, id_premii)
VALUES
    (1, 'Kierownik', 5000, 1),
    (2, 'Pracownik', 4000, 2),
    (3, 'Pracownik', 3500, 3),
    (4, 'Kierownik', 4800, 4),
    (5, 'Pracownik', 4200, 5),
    (6, 'Kierownik', 5300, 6),
    (7, 'Pracownik', 3800, 7),
    (8, 'Pracownik', 3700, 8),
    (9, 'Kierownik', 5100, 9),
    (10, 'Pracownik', 3900, 10);

INSERT INTO ksiegowosc.premia (id_premii, rodzaj, kwota)
VALUES
    (1, 'Premia za wyniki', 1200),
    (2, 'Premia za staż', 800),
    (3, 'Premia za wyniki', 1500),
    (4, 'Premia kwartalna', 1000),
    (5, 'Premia za staż', 900),
    (6, 'Premia za wyniki', 1300),
    (7, 'Premia kwartalna', 1100),
    (8, 'Premia za wyniki', 1400),
    (9, 'Premia za staż', 850),
    (10, 'Premia kwartalna', 950);
	

INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES
    (1, '2024-04-01', 1, 1, 1, 1),
    (2, '2024-04-01', 2, 2, 2, 2),
    (3, '2024-04-02', 3, 3, 3, 3),
    (4, '2024-04-02', 4, 4, 4, 4),
    (5, '2024-04-03', 5, 5, 5, 5),
    (6, '2024-04-03', 6, 6, 6, 6),
    (7, '2024-04-04', 7, 7, 7, 7),
    (8, '2024-04-04', 8, 8, 8, 8),
    (9, '2024-04-05', 9, 9, 9, 9),
    (10, '2024-04-05', 10, 10, 10, 10);

#a
SELECT id_pracownika, nazwisko
FROM ksiegowosc.pracownicy;

#b
SELECT p.id_pracownika
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = p.id_pracownika
JOIN ksiegowosc.pensja pen ON w.id_pensji = pen.id_pensji
JOIN ksiegowosc.premia pr ON w.id_premii = pr.id_premii
GROUP BY p.id_pracownika
HAVING SUM(pen.kwota + pr.kwota) > 1000;


#c
SELECT p.id_pracownika
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = p.id_pracownika
JOIN ksiegowosc.pensja pen ON w.id_pensji = pen.id_pensji
JOIN ksiegowosc.premia pr ON w.id_premii = pr.id_premii
WHERE pen.kwota > 2000 AND pr.kwota IS NULL;

#d
SELECT *
FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%';

#e
SELECT *
FROM ksiegowosc.pracownicy
WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';

#f
SELECT p.imie, p.nazwisko, SUM(g.liczba_godzin) - 160 AS nadgodziny
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.godziny g ON p.id_pracownika = g.id_pracownika
GROUP BY p.imie, p.nazwisko;

#g
SELECT p.imie, p.nazwisko
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = p.id_pracownika
JOIN ksiegowosc.pensja pen ON w.id_pensji = pen.id_pensji
WHERE pen.kwota BETWEEN 1500 AND 4000;

#h
SELECT p.imie, p.nazwisko
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = p.id_pracownika
JOIN ksiegowosc.godziny g ON w.id_godziny = g.id_godziny
JOIN ksiegowosc.premia pr ON w.id_premii = pr.id_premii
WHERE g.liczba_godzin > 160 AND pr.id_premii IS NULL;

#i
SELECT p.imie, p.nazwisko, pen.kwota
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = p.id_pracownika
JOIN ksiegowosc.pensja pen ON w.id_pensji = pen.id_pensji
ORDER BY pen.kwota;

#j
SELECT p.imie, p.nazwisko, pen.kwota, pr.kwota
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = p.id_pracownika
JOIN ksiegowosc.pensja pen ON w.id_pensji = pen.id_pensji
JOIN ksiegowosc.premia pr ON w.id_premii = pr.id_premii
ORDER BY pen.kwota DESC, pr.kwota DESC;














