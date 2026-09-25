# LineageOS 23.2 + MindTheGapps + Magisk — Moto G05 XT2523-3

Procedura przetestowana 25.09.2026 na Moto G05 XT2523-3, wariant 3,
identyfikatory `lamu`/`lamul`, z fabrycznym Androidem 15
`VVTAS35.51-153-3`. Wynik: LineageOS 23.2 (Android 16), MindTheGapps i
działający root Magisk 30.7. Inny wariant, build lub wydanie może wymagać
innych plików i kroków. Nie kontynuuj, jeśli identyfikatory telefonu się nie
zgadzają.

## Co zostanie skasowane i czego potrzebujesz

Odblokowanie bootloadera kasuje dane. Instalacja LineageOS wymaga
`Factory Reset → Format data`; oznacza to skasowanie danych użytkownika.
Najpierw wykonaj i sprawdź kopię zdjęć/filmów, kontaktów, SMS-ów i historii
połączeń. Zapisz ją poza telefonem. Aplikacje można zainstalować ponownie.
Usuń konta Google z telefonu przed formatowaniem, aby uniknąć blokady FRP.

Potrzebne są:

- Moto G05 XT2523-3 z już odblokowanym bootloaderem, na fabrycznym Androidzie
  15 `VVTAS35.51-153-3` przed rozpoczęciem;
- komputer z `adb`, `fastboot`, `sha256sum` i `unzip`;
- stabilny kabel USB, naładowany telefon i dostęp do wszystkich ekranów
  recovery/konfiguracji Androida;
- oficjalne LineageOS 23.2 dla `lamu`, obrazy z tego samego wydania oraz
  MindTheGapps ARM64 dla Androida 16;
- Magisk pobrany z oficjalnego projektu.

Nie blokuj ponownie bootloadera po instalacji custom ROM-u. Nie używaj
fabrycznego obrazu `magisk_patched` na LineageOS.

## 1. Pobierz i sprawdź pliki

Źródła:

- [Instrukcja LineageOS dla Moto G05, wariant 3](https://wiki.lineageos.org/devices/lamu/install/variant3/)
- [Oficjalne wydania LineageOS dla lamu](https://download.lineageos.org/devices/lamu/builds)
- [Zalecenia LineageOS dotyczące Google Apps](https://wiki.lineageos.org/gapps/)
- [MindTheGapps ARM64 Android 16 — oficjalne wydania](https://github.com/MindTheGapps/16.0.0-arm64/releases)
- [Magisk — oficjalne wydania](https://github.com/topjohnwu/Magisk/releases)

Użyte podczas testu wydanie LineageOS:
`lineage-23.2-20260924-nightly-lamu-signed.zip`.
Nie pobieraj plików ROM-u z przypadkowych serwisów. Z manifestu/API konkretnego
wydania pobierz również `boot.img`, `dtbo.img`, `vendor_boot.img` i
`init_boot.img`. MindTheGapps musi być ARM64 i Android 16. Wydanie użyte w
teście: `MindTheGapps-16.0.0-arm64-20260915_222150.zip`.

Sprawdź sumy SHA-256 przed użyciem. Sumy zweryfikowane dla plików użytych w
teście znajdują się w [manifeście sum](../releases/lineageos-23.2-lamu-sumy-sha256.txt).
Porównuj sumę z oficjalnym manifestem/źródłem, nie tylko z tą dokumentacją.
Sprawdź też archiwa:

```bash
sha256sum lineage-23.2-20260924-nightly-lamu-signed.zip boot.img dtbo.img vendor_boot.img init_boot.img
sha256sum MindTheGapps-16.0.0-arm64-20260915_222150.zip Magisk-v30.7.apk
unzip -tq lineage-23.2-20260924-nightly-lamu-signed.zip
unzip -tq MindTheGapps-16.0.0-arm64-20260915_222150.zip
```

## 2. Kontrola telefonu i kopia danych

W Androidzie włącz Opcje programistyczne i debugowanie USB, podłącz telefon,
zaakceptuj klucz komputera i sprawdź urządzenie:

```bash
adb devices -l
adb shell getprop ro.product.model
adb shell getprop ro.product.device
adb shell getprop ro.build.display.id
adb shell getprop ro.boot.slot_suffix
```

Oczekiwany telefon to `moto_g05` / `lamul`, build przed instalacją
`VVTAS35.51-153-3`. Jeżeli widzisz `unauthorized`, odblokuj ekran i zaakceptuj
debugowanie USB. Zrób i sprawdź kopię danych; nie przechodź dalej, jeśli nie
masz kopii.

## 3. Wgraj wymagany boot stack i Lineage Recovery

Instrukcja wariantu 3 wymaga odpowiedniego obrazu `boot`, `dtbo` i
`vendor_boot`. Uruchom bootloader i upewnij się, że fastboot widzi telefon:

```bash
adb reboot bootloader
fastboot devices -l
fastboot getvar product
fastboot getvar current-slot
fastboot getvar unlocked
```

Sprawdź, że produkt odpowiada `lamu`/`lamul` oraz `unlocked: yes`. W teście
telefon początkowo był na slocie A. Wgraj pliki z tego samego oficjalnego
wydania:

```bash
fastboot flash boot boot.img
fastboot flash dtbo dtbo.img
fastboot reboot bootloader
fastboot flash vendor_boot vendor_boot.img
fastboot reboot recovery
```

Każde polecenie flashowania musi zakończyć się `OKAY`. Jeśli którykolwiek krok
zwróci błąd, zatrzymaj się i zachowaj dokładny komunikat — nie próbuj losowych
partycji ani obrazów.

## 4. Format danych i instalacja ROM-u

Na Lineage Recovery wybierz:

1. `Factory reset` → `Format data / factory reset` i potwierdź.
2. Wróć do menu głównego, wybierz `Apply update` → `Apply from ADB`.
3. Na komputerze sideload ROM:

```bash
adb devices -l
adb sideload lineage-23.2-20260924-nightly-lamu-signed.zip
```

Recovery może wyświetlić ostrzeżenie weryfikacji/podpisu dla dodatku Google
niepodpisanego kluczem LineageOS — w teście MindTheGapps SHA-256 wcześniej
zweryfikowano z wydaniem. Nie ignoruj błędu transferu ani niezgodnej sumy.
Procent ADB może zatrzymać się w okolicy 47% mimo kontynuowania pracy recovery;
czekaj na zakończenie i sprawdź końcowy komunikat, nie odłączaj kabla.

## 5. Zainstaluj MindTheGapps przed pierwszym startem

Po zakończeniu sideload ROM-u ponownie wybierz `Apply update` → `Apply from
ADB` i na komputerze wykonaj:

```bash
adb sideload MindTheGapps-16.0.0-arm64-20260915_222150.zip
```

Poczekaj na zakończenie instalacji. Dopiero potem w recovery wybierz
`Reboot system now`. Pierwsze uruchomienie może potrwać kilka minut. Dokończ
konfigurację Androida i — jeśli pojawi się monit — zaakceptuj debugowanie USB.

## 6. Sprawdź LineageOS przed rootem

```bash
adb devices -l
adb shell getprop sys.boot_completed
adb shell getprop ro.build.version.release
adb shell getprop ro.product.device
adb shell getprop ro.boot.slot_suffix
```

Kontynuuj dopiero, gdy system jest uruchomiony (`sys.boot_completed` równe
`1`) i rozpoznaje urządzenie jako `lamul`. Zapisz aktywny slot. Po instalacji
slot może się różnić od slotu, do którego wgrano początkowy boot stack; w
przetestowanym przebiegu system uruchomił się z B, mimo że przygotowanie
rozpoczęto na A. Zawsze sprawdzaj stan bieżącego urządzenia — nie kopiuj
przykładowej litery slotu.

## 7. Dodaj root Magisk

Zainstaluj oficjalny APK Magisk na telefonie i skopiuj `init_boot.img` z
**dokładnie tego samego wydania LineageOS**:

```bash
adb install Magisk-v30.7.apk
adb push init_boot.img /sdcard/Download/init_boot.img
```

W aplikacji Magisk wybierz `Zainstaluj` → `Wybierz i załatkuj plik`, wskaż
`Download/init_boot.img` i poczekaj na komunikat zakończenia. Odczytaj
utworzoną nazwę (zwykle `magisk_patched-*.img`) i skopiuj dokładnie ten plik
na komputer:

```bash
adb shell ls -l /sdcard/Download/magisk_patched-*.img
adb pull /sdcard/Download/magisk_patched-NAZWA.img ./magisk_patched-lineage.img
sha256sum ./magisk_patched-lineage.img
```

Nie używaj opublikowanego obrazu patched z innego urządzenia/builda. Teraz
wejdź do bootloadera i **ponownie** odczytaj bieżący slot i blokadę:

```bash
adb reboot bootloader
fastboot devices -l
fastboot getvar current-slot
fastboot getvar product
fastboot getvar unlocked
```

Upewnij się, że `product` pasuje do `lamu` i bootloader pokazuje
`unlocked: yes`. Wstaw literę slotu zwróconą przez `current-slot`:

```bash
fastboot flash init_boot_b magisk_patched-lineage.img
fastboot reboot
```

W powyższym przykładzie B jest wyłącznie przykładem z przetestowanego
przebiegu. Jeśli fastboot wskazuje A, użyj `init_boot_a`; nie flashuj obu
slotów. Nie używaj `fastboot -w` ani nie blokuj bootloadera.

Po pełnym uruchomieniu zweryfikuj root:

```bash
adb shell getprop sys.boot_completed
adb shell su -c id
adb shell su -c magisk -v
```

W teście wynik `su -c id` zawierał `uid=0(root)`, a wersja Magisk wynosiła
`30.7`.

## 8. Kontrola po instalacji i kopia danych

Sprawdź ręcznie: SIM, połączenia przychodzące/wychodzące, SMS, dane komórkowe,
Wi‑Fi, aparat, Bluetooth, odcisk palca, głośnik/mikrofon i ładowanie. Root i
pomyślne uruchomienie nie zastępują testu sprzętu/operatora.

Kontakty, SMS-y, historię połączeń i zdjęcia/filmy przywróć z własnej kopii
zapasowej. Surowe bazy Androida kopiowane z roota nie zawsze nadają się do
bezpośredniego przywrócenia między wersjami systemu; preferuj import kontaktów
oraz obsługiwany przez aplikację import SMS. Nie przywracaj całej starej
bazy telefonicznej bez kopii nowego stanu.

## Znane problemy z testu

- `adb` może na chwilę pokazywać `unauthorized`: zaakceptuj monit USB na
  telefonie.
- Sideload może wizualnie stanąć około 47%; czekaj na końcowy status recovery.
- Po restarcie slot zmienił się na B. Slot zawsze ustalaj ponownie przed rootem.
- Lokalny serwer ADB na komputerze może nie uruchomić się z powodu uprawnień;
  nie flashuj wtedy niczego, dopóki ADB/Fastboot nie widzi właściwego telefonu.
- `su` powinno być zatwierdzone przez aplikację Magisk; jeśli root nie działa,
  wróć do diagnostyki i nie flashuj stockowego patched image.

## Dziennik przetestowanego przebiegu

Na XT2523-3 z fabrycznego Androida 15 `VVTAS35.51-153-3` wgrano wymagane
obrazy Lineage, sformatowano dane, zainstalowano LineageOS 23.2 i MindTheGapps,
a następnie uruchomiono Androida 16. Magisk 30.7 spatchował `init_boot.img` z
tego wydania; fastboot potwierdził slot B i odblokowany bootloader, po czym
obraz zapisano do `init_boot_b`. Po restarcie `sys.boot_completed=1`,
`su -c id` potwierdziło UID 0. Testy połączeń i sprzętu pozostają do wykonania
przez użytkownika.
