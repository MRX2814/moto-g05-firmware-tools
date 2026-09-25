# Narzędzia i pliki projektu

## Tanuki

Lokalnie użyto `tanuki-lamu-v2.0.3` dla Moto G05 `lamul`. Pakiet zawiera
`tanuki.sh`, `tanuki.bat`, Antumbrę, Fastboot, DA, preloader, `lamu-kaeru.bin`
i plik wiadomości bootloadera. Pełna procedura znajduje się w [instrukcji
odblokowania](03-odblokowanie-bootloadera.md).

Nie publikuj plików z przypadkowej kopii ani nie przedstawiaj Tanuki jako
oprogramowania Motoroli. Zachowaj atrybucję autorów i licencję narzędzia.

## Magisk

Magisk służy do spatchowania właściwego `init_boot.img`. Obraz
`magisk_patched-*.img` jest wynikiem zależnym od konkretnego telefonu i
kompilacji — nie należy używać go na innym urządzeniu.

Do publicznego repozytorium dodajemy instrukcję i odnośnik do oryginalnego
źródła Magisk, a nie cudzy spatchowany obraz bez metadanych.

## Sumy plików

Przed każdym wydaniem oblicz sumy SHA-256:

```bash
sha256sum tanuki-lamu-v2.0.3.zip
sha256sum init_boot.img
sha256sum magisk_patched-*.img
```

W tabeli wydania zapisz nazwę pliku, rozmiar, kompilację firmware, model,
slot oraz SHA-256.
