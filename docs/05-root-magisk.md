# Root i Magisk — Moto G05 XT2523-3 / lamul

Instrukcja opiera się na przetestowanym urządzeniu z Androidem 15, kompilacją
`VVTAS35.51-153-3` i Magisk 30.7. Nie traktuj jej jako uniwersalnej dla każdego
wariantu Moto G05.

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

Oczekiwany test bazowy z naszej procedury to model Moto G05/`lamul`, build
`VVTAS35.51-153-3` i aktywny slot `a`. Jeżeli build lub model się nie zgadza,
przerwij.

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

W przetestowanej procedurze aktywny był slot `a`, a używany był zgodny obraz
`init_boot`:

```bash
fastboot flash init_boot_a magisk_patched-*.img
fastboot reboot
```

Nie używaj tego polecenia, jeśli `current-slot` wskazuje inny slot albo plik
pochodzi z innej kompilacji. Po uruchomieniu sprawdź:

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
