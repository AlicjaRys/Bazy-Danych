#a
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT('(+48) ', telefon)

SELECT *
FROM ksiegowosc.pracownicy;

#b
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT(SUBSTRING(telefon, 1, 3), '-', SUBSTRING(telefon, 4, 3), '-', SUBSTRING(telefon, 7, 3))

#c
SELECT id_pracownika, UPPER(imie) AS imie, UPPER(nazwisko) AS nazwisko, UPPER(adres) AS adres, telefon
FROM ksiegowosc.pracownicy
WHERE UPPER(nazwisko) = (
    SELECT TOP 1 UPPER(nazwisko)
    FROM ksiegowosc.pracownicy
    ORDER BY LEN(nazwisko) DESC
);

#d
SELECT
HASHBYTES('MD5', nazwisko) AS nazwisko_md5,
HASHBYTES('MD5', imie) AS imie_md5,
HASHBYTES('MD5', CAST(s.kwota AS VARCHAR(100))) AS pensja_md5
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensja s ON w.id_pensji = s.id_pensji;

#f
SELECT p.imie, p.nazwisko, p.telefon, pen.stanowisko, pen.kwota AS pensja, prm.rodzaj AS premia, prm.kwota AS kwota_premii
FROM ksiegowosc.pracownicy p
LEFT JOIN ksiegowosc.pensja pen ON p.id_pracownika = pen.id_pensji
LEFT JOIN ksiegowosc.premia prm ON pen.id_premii = prm.id_premii;

#g
SELECT CONCAT('Pracownik ', p.imie, ' ', p.nazwisko, ', w dniu ', w.data,
    ' otrzyma³ pensjê ca³kowit¹ na kwotê ', pe.kwota + pr.kwota + ((g.liczba_godzin - 160) * 40), ' z³, gdzie ',
    'wynagrodzenie zasadnicze wynosi³o: ', pe.kwota, ' z³, premia: ', pr.kwota, 
    ' z³, nadgodziny: ', ((g.liczba_godzin - 160) * 40), ' z³') AS raport
FROM ksiegowosc.pracownicy p
LEFT JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
LEFT JOIN ksiegowosc.pensja pe ON w.id_pensji = pe.id_pensji
LEFT JOIN ksiegowosc.premia pr ON w.id_premii = pr.id_premii
LEFT JOIN ksiegowosc.godziny g ON w.id_godziny = g.id_godziny;

