# Root i Magisk — Moto G05 XT2523-3 / lamul

Instrukcja obejmuje root na fabrycznym Androidzie 15 oraz LineageOS 23.2 /
Androidzie 16. Pełna, przetestowana instalacja LineageOS znajduje się w
[osobnym przewodniku](09-lineageos-23-2.md). Nie traktuj jej jako uniwersalnej
dla każdego wariantu Moto G05.

## Zasady bezpieczeństwa

- Bootloader musi być już odblokowany zgodnie z [osobną instrukcją](03-odblokowanie-bootloadera.md).
- `init_boot.img` musi pochodzić z dokładnie tej samej kompilacji, która działa na telefonie.
- Oryginalny `init_boot.img` zachowaj przed patchowaniem.
- Nie używaj spatchowanego obrazu z innego telefonu.
- Nie flashuj w ciemno `boot.img`, `vbmeta.img` ani `super.img`.
- Próby z niezgodnym obrazem powodowały Red State i pętlę startową.

## 1. Sprawdzenie telefonu

```bash
adb devices -l
adb shell getprop ro.product.model
adb shell getprop ro.boot.hardware
adb shell getprop ro.build.display.id
adb shell getprop ro.boot.slot_suffix
adb shell getprop ro.boot.flash.locked
```

W teście stockowym model to Moto G05/`lamul`, build
`VVTAS35.51-153-3`, początkowy slot `a`. Po instalacji LineageOS aktywny był
slot `b`. Slotu nie wolno zakładać z góry — odczytaj go w każdym urządzeniu.
Jeżeli model lub obraz źródłowy się nie zgadza, przerwij.

## 2. Przygotowanie obrazu w Magisk

1. Pobierz Magisk wyłącznie z oficjalnego projektu.
2. Skopiuj z właściwego firmware oryginalny `init_boot.img` do telefonu.
3. W aplikacji Magisk wybierz `Zainstaluj` → `Wybierz i spatchuj plik`.
4. Wskaż oryginalny `init_boot.img`.
5. Skopiuj wynik `magisk_patched-*.img` z telefonu na komputer.

Przykładowo:

```bash
adb pull /sdcard/Download/magisk_patched-*.img .
sha256sum magisk_patched-*.img
```

## 3. Flashowanie właściwego obrazu

Najpierw przejdź do Fastboot i sprawdź urządzenie:

```bash
adb reboot bootloader
fastboot devices
fastboot getvar current-slot
fastboot getvar product
```

W procedurze testowej LineageOS fastboot potwierdził aktywny slot `b`, więc
spatchowany obraz z tego samego wydania zapisano tylko do:

```bash
fastboot flash init_boot_b magisk_patched-lineage.img
fastboot reboot
```

Litera `b` jest wynikiem tego jednego testu, nie wartością uniwersalną. Użyj
partycyjnej nazwy odpowiadającej aktualnemu `fastboot getvar current-slot`,
tylko jeśli patched image pochodzi z dokładnego systemu na telefonie. Po
uruchomieniu sprawdź:

```bash
adb shell su -c id
adb shell getprop ro.boot.verifiedbootstate
```

Sukces oznaczał `uid=0(root)`; stan Verified Boot może być `orange` po modyfikacji.

## 4. Co z `bldr_spoof`?

Podczas testów funkcja/ustawienie `bldr_spoof` zostało wyłączone. Nie było
potrzebne do końcowego uzyskania roota i nie należy włączać go bez konkretnej
przyczyny oraz kopii stockowych plików. Nie opisujemy go jako obowiązkowego
kroku ani nie publikujemy niezweryfikowanych komend przełączających.

## 5. Powrót do stockowego obrazu

Jeśli telefon wpadnie w bootloop, nie zgaduj kolejnych obrazów. Przywróć
oryginalny `init_boot_a` z tej samej kompilacji i dopiero potem diagnozuj:

```bash
fastboot devices
fastboot flash init_boot_a init_boot.img
fastboot reboot
```

Zachowaj kopię obrazu Magisk oraz oryginalnego obrazu i zapisz dokładny
komunikat błędu.

## Powiązane narzędzia

- odblokowanie bootloadera: [Tanuki/Kaeru](03-odblokowanie-bootloadera.md),
- komendy diagnostyczne: [ADB i Fastboot](02-adb-fastboot.md),
- zgłoszenie problemu: [SUPPORT.md](../SUPPORT.md).
