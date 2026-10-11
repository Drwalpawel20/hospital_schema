/*
Created: 26.04.2025
Modified: 29.05.2025
Model: fizyczny model v1
Database: PostgreSQL 12
*/

-- Drop foreign keys (relationships) section ---------------------------------------------------

ALTER TABLE "szpital"."wizyta" DROP CONSTRAINT IF EXISTS "Relationship15"
;
ALTER TABLE "szpital"."hospitalizacja" DROP CONSTRAINT IF EXISTS "Relationship25"
;
ALTER TABLE "szpital"."wizyta" DROP CONSTRAINT IF EXISTS "Relationship27"
;
ALTER TABLE "szpital"."platnosc" DROP CONSTRAINT IF EXISTS "Relationship28"
;
ALTER TABLE "szpital"."wizyta_recepta" DROP CONSTRAINT IF EXISTS "Relationship32"
;
ALTER TABLE "szpital"."wizyta_diagnoza" DROP CONSTRAINT IF EXISTS "Relationship33"
;
ALTER TABLE "szpital"."wizyta_diagnoza" DROP CONSTRAINT IF EXISTS "Relationship34"
;
ALTER TABLE "szpital"."pacjent_ubezpieczenie" DROP CONSTRAINT IF EXISTS "Relationship40"
;
ALTER TABLE "szpital"."pacjent_ubezpieczenie" DROP CONSTRAINT IF EXISTS "Relationship41"
;
ALTER TABLE "szpital"."rezerwacja_sprzetu" DROP CONSTRAINT IF EXISTS "Relationship42"
;
ALTER TABLE "szpital"."sprzety_medyczne_do_rezerwacji" DROP CONSTRAINT IF EXISTS "Relationship43"
;
ALTER TABLE "szpital"."sprzety_medyczne_do_rezerwacji" DROP CONSTRAINT IF EXISTS "Relationship44"
;
ALTER TABLE "szpital"."wizyta_recepta" DROP CONSTRAINT IF EXISTS "Relationship45"
;
ALTER TABLE "szpital"."leki_na_recepcie" DROP CONSTRAINT IF EXISTS "Relationship46"
;
ALTER TABLE "szpital"."leki_na_recepcie" DROP CONSTRAINT IF EXISTS "Relationship47"
;
ALTER TABLE "szpital"."wizyta_badanie" DROP CONSTRAINT IF EXISTS "Relationship49"
;
ALTER TABLE "szpital"."wizyta_badanie" DROP CONSTRAINT IF EXISTS "Relationship50"
;

-- Drop keys section -------------------------------------------------

ALTER TABLE "szpital"."wizyta_badanie" DROP CONSTRAINT IF EXISTS "PK_wizyta_badanie"
;
ALTER TABLE "szpital"."lek" DROP CONSTRAINT IF EXISTS "Unique_Identifier17"
;
ALTER TABLE "szpital"."leki_na_recepcie" DROP CONSTRAINT IF EXISTS "Unique_Identifier16"
;
ALTER TABLE "szpital"."sprzety_medyczne_do_rezerwacji" DROP CONSTRAINT IF EXISTS "Unique_Identifier15"
;
ALTER TABLE "szpital"."pacjent_ubezpieczenie" DROP CONSTRAINT IF EXISTS "Unique_Identifier14"
;
ALTER TABLE "szpital"."wizyta_diagnoza" DROP CONSTRAINT IF EXISTS "Unique_Identifier13"
;
ALTER TABLE "szpital"."wizyta_recepta" DROP CONSTRAINT IF EXISTS "Unique_Identifier12"
;
ALTER TABLE "szpital"."badanie" DROP CONSTRAINT IF EXISTS "Unique_Identifier11"
;
ALTER TABLE "szpital"."lekarz" DROP CONSTRAINT IF EXISTS "Unique_Identifier10"
;
ALTER TABLE "szpital"."recepta" DROP CONSTRAINT IF EXISTS "Unique_Identifier9"
;
ALTER TABLE "szpital"."diagnoza" DROP CONSTRAINT IF EXISTS "Unique_Identifier8"
;
ALTER TABLE "szpital"."wizyta" DROP CONSTRAINT IF EXISTS "Unique_Identifier7"
;
ALTER TABLE "szpital"."sprzet_medyczny" DROP CONSTRAINT IF EXISTS "Unique_Identifier6"
;
ALTER TABLE "szpital"."rezerwacja_sprzetu" DROP CONSTRAINT IF EXISTS "Unique_Identifier5"
;
ALTER TABLE "szpital"."ubezpieczenie" DROP CONSTRAINT IF EXISTS "Unique_Identifier4"
;
ALTER TABLE "szpital"."platnosc" DROP CONSTRAINT IF EXISTS "Unique_Identifier3"
;
ALTER TABLE "szpital"."hospitalizacja" DROP CONSTRAINT IF EXISTS "PK_hospitalizacja"
;
ALTER TABLE "szpital"."hospitalizacja" DROP CONSTRAINT IF EXISTS "Key1"
;
ALTER TABLE "szpital"."pacjent" DROP CONSTRAINT IF EXISTS "Unique_Identifier1"
;

-- Drop indexes section -------------------------------------------------

DROP INDEX IF EXISTS "szpital"."Index1"
;
DROP INDEX IF EXISTS "szpital"."UX_pacjent_pesel"
;
ALTER TABLE "szpital"."hospitalizacja" DROP CONSTRAINT IF EXISTS "UX_hosp_pacjent_daty"
;
DROP INDEX IF EXISTS "szpital"."IX_Relationship28"
;
DROP INDEX IF EXISTS "szpital"."IX_Relationship42"
;

-- Drop tables section ---------------------------------------------------

DROP TABLE IF EXISTS "szpital"."wizyta_badanie"
;
DROP TABLE IF EXISTS "szpital"."lek"
;
DROP TABLE IF EXISTS "szpital"."leki_na_recepcie"
;
DROP TABLE IF EXISTS "szpital"."sprzety_medyczne_do_rezerwacji"
;
DROP TABLE IF EXISTS "szpital"."pacjent_ubezpieczenie"
;
DROP TABLE IF EXISTS "szpital"."wizyta_diagnoza"
;
DROP TABLE IF EXISTS "szpital"."wizyta_recepta"
;
DROP TABLE IF EXISTS "szpital"."badanie"
;
DROP TABLE IF EXISTS "szpital"."lekarz"
;
DROP TABLE IF EXISTS "szpital"."recepta"
;
DROP TABLE IF EXISTS "szpital"."diagnoza"
;
DROP TABLE IF EXISTS "szpital"."wizyta"
;
DROP TABLE IF EXISTS "szpital"."sprzet_medyczny"
;
DROP TABLE IF EXISTS "szpital"."rezerwacja_sprzetu"
;
DROP TABLE IF EXISTS "szpital"."ubezpieczenie"
;
DROP TABLE IF EXISTS "szpital"."platnosc"
;
DROP TABLE IF EXISTS "szpital"."hospitalizacja"
;
DROP TABLE IF EXISTS "szpital"."pacjent"
;

-- Drop schemas section ---------------------------------------------------

DROP SCHEMA IF EXISTS "szpital"
;

-- Create schemas section -------------------------------------------------

CREATE SCHEMA "szpital"
;

-- Create tables section -------------------------------------------------

-- Table szpital.pacjent

CREATE TABLE "szpital"."pacjent"
(
  "id_pacjenta" Integer NOT NULL,
  "imie" Character varying(50),
  "nazwisko" Character varying(50),
  "pesel" Character(11) NOT NULL,
  "data_urodzenia" Date,
  "adres_zamieszkania" Text,
  "telefon" Character varying(15),
  "email" Character varying(100),
  "haslo" Character varying(100),
  "id_ubezpieczenia" Integer
)
WITH (
  autovacuum_enabled=true)
;

CREATE UNIQUE INDEX "Index1" ON "szpital"."pacjent" ("id_pacjenta")
;

CREATE UNIQUE INDEX "UX_pacjent_pesel" ON "szpital"."pacjent" ("pesel")
;

ALTER TABLE "szpital"."pacjent" ADD CONSTRAINT "Unique_Identifier1" PRIMARY KEY ("id_pacjenta")
;

-- Table szpital.hospitalizacja

CREATE TABLE "szpital"."hospitalizacja"
(
  "id_hospitalizacji" Integer NOT NULL,
  "data_przyjecia" Date NOT NULL,
  "data_wypisu" Date NOT NULL,
  "oddzial" Character varying(100),
  "lozko" Character varying(20),
  "id_pacjenta" Integer NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "szpital"."hospitalizacja" ADD CONSTRAINT "UX_hosp_pacjent_daty" EXCLUDE USING gist ( id_pacjenta WITH =, daterange(data_przyjecia, data_wypisu) WITH &&)
;

ALTER TABLE "szpital"."hospitalizacja" ADD CONSTRAINT "PK_hospitalizacja" PRIMARY KEY ("id_hospitalizacji","id_pacjenta")
;

ALTER TABLE "szpital"."hospitalizacja" ADD CONSTRAINT "Key1" UNIQUE ("id_hospitalizacji","data_przyjecia","data_wypisu")
;

-- Table szpital.platnosc

CREATE TABLE "szpital"."platnosc"
(
  "id_platnosci" Integer NOT NULL,
  "data_platnosci" Date,
  "kwota" Numeric(10,2),
  "typ_platnosci" Character varying(30),
  "id_pacjenta" Integer NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX "IX_Relationship28" ON "szpital"."platnosc" ("id_pacjenta")
;

ALTER TABLE "szpital"."platnosc" ADD CONSTRAINT "Unique_Identifier3" PRIMARY KEY ("id_platnosci")
;

-- Table szpital.ubezpieczenie

CREATE TABLE "szpital"."ubezpieczenie"
(
  "id_ubezpieczenia" Integer NOT NULL,
  "nazwa" Character varying(100),
  "typ" Character varying(50),
  "zakres" Text
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "szpital"."ubezpieczenie" ADD CONSTRAINT "Unique_Identifier4" PRIMARY KEY ("id_ubezpieczenia")
;

-- Table szpital.rezerwacja_sprzetu

CREATE TABLE "szpital"."rezerwacja_sprzetu"
(
  "id_rezerwacji" Integer NOT NULL,
  "data_rezerwacji" Date,
  "id_pacjenta" Integer
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX "IX_Relationship42" ON "szpital"."rezerwacja_sprzetu" ("id_pacjenta")
;

ALTER TABLE "szpital"."rezerwacja_sprzetu" ADD CONSTRAINT "Unique_Identifier5" PRIMARY KEY ("id_rezerwacji")
;

-- Table szpital.sprzet_medyczny

CREATE TABLE "szpital"."sprzet_medyczny"
(
  "id_sprzetu" Integer NOT NULL,
  "nazwa_sprzetu" Character varying(100),
  "typ" Character varying(100),
  "dostepnosc" Boolean
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "szpital"."sprzet_medyczny" ADD CONSTRAINT "Unique_Identifier6" PRIMARY KEY ("id_sprzetu")
;

-- Table szpital.wizyta

CREATE TABLE "szpital"."wizyta"
(
  "id_wizyty" Integer NOT NULL,
  "id_lekarz" Integer,
  "data_wizyty" Date NOT NULL,
  "godzina" Time,
  "rodzaj_wizyty" Character varying(30),
  "numer_pwz" Integer NOT NULL,
  "id_pacjenta" Integer NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "szpital"."wizyta" ADD CONSTRAINT "Unique_Identifier7" PRIMARY KEY ("data_wizyty","numer_pwz","id_pacjenta")
;

-- Table szpital.diagnoza

CREATE TABLE "szpital"."diagnoza"
(
  "id_diagnoza" Integer NOT NULL,
  "kod_icd" Bigint
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "szpital"."diagnoza" ADD CONSTRAINT "Unique_Identifier8" PRIMARY KEY ("id_diagnoza")
;

-- Table szpital.recepta

CREATE TABLE "szpital"."recepta"
(
  "id_recepta" Integer NOT NULL,
  "id_wizyty" Integer,
  "data_wystawienia" Date,
  "zalecenia" Text,
  "id_lek" Bigint
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "szpital"."recepta" ADD CONSTRAINT "Unique_Identifier9" PRIMARY KEY ("id_recepta")
;

-- Table szpital.lekarz

CREATE TABLE "szpital"."lekarz"
(
  "numer_pwz" Integer NOT NULL,
  "imie" Character varying(50),
  "nazwisko" Character varying(50),
  "specjalizacja" Character varying(100),
  "numer_licencji" Character varying(50),
  "email" Character varying(100),
  "telefon" Character varying(15)
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "szpital"."lekarz" ADD CONSTRAINT "Unique_Identifier10" PRIMARY KEY ("numer_pwz")
;

-- Table szpital.badanie

CREATE TABLE "szpital"."badanie"
(
  "id_badanie" Integer NOT NULL,
  "typ_badania" Character varying(100)
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "szpital"."badanie" ADD CONSTRAINT "Unique_Identifier11" PRIMARY KEY ("id_badanie")
;

-- Table szpital.wizyta_recepta

CREATE TABLE "szpital"."wizyta_recepta"
(
  "id_recepta" Integer NOT NULL,
  "data_wizyty" Date NOT NULL,
  "numer_pwz" Integer NOT NULL,
  "id_pacjenta" Integer NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "szpital"."wizyta_recepta" ADD CONSTRAINT "Unique_Identifier12" PRIMARY KEY ("id_recepta","data_wizyty","numer_pwz","id_pacjenta")
;

-- Table szpital.wizyta_diagnoza

CREATE TABLE "szpital"."wizyta_diagnoza"
(
  "opis" Character varying(100),
  "data_wizyty" Date NOT NULL,
  "numer_pwz" Integer NOT NULL,
  "id_pacjenta" Integer NOT NULL,
  "id_diagnoza" Integer NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "szpital"."wizyta_diagnoza" ADD CONSTRAINT "Unique_Identifier13" PRIMARY KEY ("data_wizyty","numer_pwz","id_pacjenta","id_diagnoza")
;

-- Table szpital.pacjent_ubezpieczenie

CREATE TABLE "szpital"."pacjent_ubezpieczenie"
(
  "id_pacjenta" Integer NOT NULL,
  "id_ubezpieczenia" Integer NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "szpital"."pacjent_ubezpieczenie" ADD CONSTRAINT "Unique_Identifier14" PRIMARY KEY ("id_pacjenta","id_ubezpieczenia")
;

-- Table szpital.sprzety_medyczne_do_rezerwacji

CREATE TABLE "szpital"."sprzety_medyczne_do_rezerwacji"
(
  "id_rezerwacji" Integer NOT NULL,
  "id_sprzetu" Integer NOT NULL,
  "czas_od" Time,
  "czas_do" Time,
  "data_od" Date,
  "data_do" Date
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "szpital"."sprzety_medyczne_do_rezerwacji" ADD CONSTRAINT "Unique_Identifier15" PRIMARY KEY ("id_rezerwacji","id_sprzetu")
;

-- Table szpital.leki_na_recepcie

CREATE TABLE "szpital"."leki_na_recepcie"
(
  "id_recepta" Integer NOT NULL,
  "id_lek" Bigint NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "szpital"."leki_na_recepcie" ADD CONSTRAINT "Unique_Identifier16" PRIMARY KEY ("id_recepta","id_lek")
;

-- Table szpital.lek

CREATE TABLE "szpital"."lek"
(
  "id_lek" Bigint NOT NULL,
  "nazwa_leku" Character varying(250)
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "szpital"."lek" ADD CONSTRAINT "Unique_Identifier17" PRIMARY KEY ("id_lek")
;

-- Table szpital.wizyta_badanie

CREATE TABLE "szpital"."wizyta_badanie"
(
  "data_wizyty" Date NOT NULL,
  "numer_pwz" Integer NOT NULL,
  "id_pacjenta" Integer NOT NULL,
  "id_badanie" Integer NOT NULL,
  "wynik" Character varying(150)
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "szpital"."wizyta_badanie" ADD CONSTRAINT "PK_wizyta_badanie" PRIMARY KEY ("data_wizyty","numer_pwz","id_pacjenta","id_badanie")
;

-- Create foreign keys (relationships) section -------------------------------------------------

ALTER TABLE "szpital"."wizyta"
  ADD CONSTRAINT "Relationship15"
    FOREIGN KEY ("numer_pwz")
    REFERENCES "szpital"."lekarz" ("numer_pwz")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "szpital"."hospitalizacja"
  ADD CONSTRAINT "Relationship25"
    FOREIGN KEY ("id_pacjenta")
    REFERENCES "szpital"."pacjent" ("id_pacjenta")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "szpital"."wizyta"
  ADD CONSTRAINT "Relationship27"
    FOREIGN KEY ("id_pacjenta")
    REFERENCES "szpital"."pacjent" ("id_pacjenta")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "szpital"."platnosc"
  ADD CONSTRAINT "Relationship28"
    FOREIGN KEY ("id_pacjenta")
    REFERENCES "szpital"."pacjent" ("id_pacjenta")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "szpital"."wizyta_recepta"
  ADD CONSTRAINT "Relationship32"
    FOREIGN KEY ("id_recepta")
    REFERENCES "szpital"."recepta" ("id_recepta")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "szpital"."wizyta_diagnoza"
  ADD CONSTRAINT "Relationship33"
    FOREIGN KEY ("data_wizyty", "numer_pwz", "id_pacjenta")
    REFERENCES "szpital"."wizyta" ("data_wizyty", "numer_pwz", "id_pacjenta")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "szpital"."wizyta_diagnoza"
  ADD CONSTRAINT "Relationship34"
    FOREIGN KEY ("id_diagnoza")
    REFERENCES "szpital"."diagnoza" ("id_diagnoza")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "szpital"."pacjent_ubezpieczenie"
  ADD CONSTRAINT "Relationship40"
    FOREIGN KEY ("id_pacjenta")
    REFERENCES "szpital"."pacjent" ("id_pacjenta")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "szpital"."pacjent_ubezpieczenie"
  ADD CONSTRAINT "Relationship41"
    FOREIGN KEY ("id_ubezpieczenia")
    REFERENCES "szpital"."ubezpieczenie" ("id_ubezpieczenia")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "szpital"."rezerwacja_sprzetu"
  ADD CONSTRAINT "Relationship42"
    FOREIGN KEY ("id_pacjenta")
    REFERENCES "szpital"."pacjent" ("id_pacjenta")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "szpital"."sprzety_medyczne_do_rezerwacji"
  ADD CONSTRAINT "Relationship43"
    FOREIGN KEY ("id_rezerwacji")
    REFERENCES "szpital"."rezerwacja_sprzetu" ("id_rezerwacji")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "szpital"."sprzety_medyczne_do_rezerwacji"
  ADD CONSTRAINT "Relationship44"
    FOREIGN KEY ("id_sprzetu")
    REFERENCES "szpital"."sprzet_medyczny" ("id_sprzetu")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "szpital"."wizyta_recepta"
  ADD CONSTRAINT "Relationship45"
    FOREIGN KEY ("data_wizyty", "numer_pwz", "id_pacjenta")
    REFERENCES "szpital"."wizyta" ("data_wizyty", "numer_pwz", "id_pacjenta")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "szpital"."leki_na_recepcie"
  ADD CONSTRAINT "Relationship46"
    FOREIGN KEY ("id_recepta")
    REFERENCES "szpital"."recepta" ("id_recepta")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "szpital"."leki_na_recepcie"
  ADD CONSTRAINT "Relationship47"
    FOREIGN KEY ("id_lek")
    REFERENCES "szpital"."lek" ("id_lek")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "szpital"."wizyta_badanie"
  ADD CONSTRAINT "Relationship49"
    FOREIGN KEY ("data_wizyty", "numer_pwz", "id_pacjenta")
    REFERENCES "szpital"."wizyta" ("data_wizyty", "numer_pwz", "id_pacjenta")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "szpital"."wizyta_badanie"
  ADD CONSTRAINT "Relationship50"
    FOREIGN KEY ("id_badanie")
    REFERENCES "szpital"."badanie" ("id_badanie")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

-- Grant permissions section -------------------------------------------------


