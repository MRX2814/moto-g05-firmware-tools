# Odblokowanie bootloadera Moto G05

## Metoda użyta podczas testu

W przypadku testowanego Moto G05 użyto narzędzia `tanuki-lamu-v2.0.3`. To nie jest narzędzie Motoroli. Jest to projekt społecznościowy oparty na `kaeru` i `Antumbra`, a końcowy krok odblokowania wykonuje:

```text
fastboot oem seccfg-unlock
```

Wcześniej narzędzie zapisuje odpowiednie pliki do trybu MediaTek, przygotowuje przejście do Fastboot i wykonuje `fastboot erase misc`. Nie należy mylić tej procedury z „boot spoofingiem”.

## Ostrzeżenia

- Odblokowanie kasuje dane użytkownika.
- Procedura modyfikuje elementy startowe telefonu; przerwanie pracy może doprowadzić do problemu z uruchomieniem.
- Używaj jej tylko po potwierdzeniu właściwego modelu i wariantu.
- Nie używaj plików z innego modelu ani przypadkowej kopii narzędzia.
- Po odblokowaniu nie blokuj ponownie bootloadera na zmodyfikowanym systemie.
- Odpowiedzialność za użycie ponosi właściciel urządzenia.

## Przygotowanie

1. Wykonaj pełną kopię danych — telefon zostanie wyzerowany.
2. Naładuj telefon i przygotuj sprawny kabel USB.
3. Na Windows zainstaluj sterowniki MediaTek USB. Na Linuxie narzędzie wymaga uprawnień root albo poprawnej reguły udev dla `0e8d`.
4. Pobierz narzędzie `tanuki` wyłącznie z jego oryginalnego źródła i sprawdź integralność plików.
5. Wyłącz telefon całkowicie przed rozpoczęciem.

## Windows

Otwórz terminal w rozpakowanym katalogu narzędzia i uruchom:

```text
tanuki.bat
```

Postępuj zgodnie z komunikatami programu. Nie odłączaj kabla podczas zapisu preloadera, partycji `lk_a`/`lk_b` ani `misc`.

## Linux

W rozpakowanym katalogu narzędzia uruchom:

```bash
sudo ./tanuki.sh
```

Po ponownym uruchomieniu narzędzie może czekać na tryb Fastboot. Jeśli telefon nie przejdzie do niego automatycznie:

1. odłącz kabel USB,
2. wyłącz telefon,
3. przytrzymaj `POWER + VOLUME UP`,
4. wybierz `fastboot`,
5. podłącz kabel ponownie.

Po wykryciu telefonu narzędzie sprawdza wersję `kaeru`, czyści `misc` i wykonuje `seccfg-unlock`.

## Sprawdzenie wyniku

Sukces powinien kończyć się komunikatem o odblokowaniu bootloadera. Przed dalszym flashowaniem sprawdź urządzenie:

```bash
fastboot devices
fastboot getvar product
```

Jeżeli identyfikator produktu nie odpowiada właściwemu wariantowi Moto G05, przerwij dalsze działania.

## Źródła i licencja narzędzia

`tanuki` zawiera informacje o autorach i licencji AGPL-3.0-or-later. W projekcie pomocy należy linkować do oryginalnego źródła zamiast usuwać atrybucję albo przedstawiać narzędzie jako oficjalne Motorola.
