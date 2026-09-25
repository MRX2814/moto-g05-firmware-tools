# Moto G05 — firmware, Fastboot i pomoc

Publiczny projekt pomocy dla użytkowników Motorola Moto G05.

## Zawartość

- oficjalne pakiety firmware i sumy SHA-256,
- ADB i Fastboot,
- odblokowanie bootloadera,
- root i Magisk,
- przywracanie telefonu po błędach,
- FAQ oraz pomoc przez Issues i Discussions.

## Aktualny pakiet roboczy

`fastboot_lamu_g_user_15_VVTAS35.51_153_3_76a43c_release_keys`

Pakiet został pobrany oficjalnym narzędziem Motoroli. Przed publikacją trzeba potwierdzić wariant telefonu, region, sumy SHA-256 i prawo do redystrybucji.

## Ważne ostrzeżenia

- Odblokowanie bootloadera zwykle kasuje wszystkie dane.
- Nie blokuj ponownie bootloadera na zmodyfikowanym systemie.
- Nie publikuj haseł, tokenów, numerów IMEI ani prywatnych kluczy podpisujących.
- Przed flashowaniem sprawdź model, wariant i anti-rollback.
- Duże obrazy powinny być dodawane jako GitHub Release, nie do zwykłego repozytorium.

## Dokumentacja

- [Przygotowanie i kopia danych](docs/01-przygotowanie.md)
- [ADB i Fastboot](docs/02-adb-fastboot.md)
- [Odblokowanie bootloadera](docs/03-odblokowanie-bootloadera.md)
- [Firmware i flashowanie](docs/04-firmware-fastboot.md)
- [Root i Magisk](docs/05-root-magisk.md)
- [Ratowanie telefonu](docs/06-ratowanie-telefonu.md)
- [Narzędzia i pliki](docs/07-narzedzia-i-pliki.md)
- [FAQ](docs/faq.md)
- [Pomoc i zgłaszanie problemów](SUPPORT.md)

Instrukcje oznaczone jako `DRAFT` wymagają testu na właściwym wariancie Moto G05.

Odblokowanie opisane w dokumentacji korzysta z nieoficjalnego narzędzia `tanuki`/`kaeru`/`Antumbra`; nie jest to oprogramowanie Motoroli.
