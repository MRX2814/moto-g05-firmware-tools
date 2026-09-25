# Pierwsze wydanie narzędzi Moto G05

Wydanie zawiera pliki użyte podczas testów na Motorola Moto G05 XT2523-3 / `lamul`, Android 15, build `VVTAS35.51-153-3`.

## Pliki wydania

- `tanuki-lamu-v2.0.3.zip` — narzędzie odblokowania MediaTek/Fastboot; nieoficjalne względem Motoroli.
- `Magisk-v30.7.apk` — aplikacja Magisk.
- `magisk_patched-30700_GdPnV.img` — obraz spatchowany Magiskiem; tylko dla dokładnie zgodnego urządzenia i firmware.

## SHA-256

```text
d0a89f5f293c0309150af6d2cd56db203d280665cd45c0106c06add737361555  tanuki-lamu-v2.0.3.zip
e0d32d2123532860f97123d927b1bb86c4e08e6fd8a48bfc6b5bee0afae9ebd5  Magisk-v30.7.apk
180f7a7f8a7152a74549d72550dbd77f3c0ca72028d93315d59488066dccf903  magisk_patched-30700_GdPnV.img
```

## Krytyczne ostrzeżenie

Spatchowany obraz nie jest uniwersalny. Nie używaj go na innym modelu, wariancie, slocie ani kompilacji. Najbezpieczniejsza metoda to samodzielne spatchowanie własnego `init_boot.img` w Magisk według [instrukcji root](05-root-magisk.md).

Archiwum Tanuki zawiera komponenty wymagane do procedury MediaTek. Nie zmieniaj jego zawartości i nie przerywaj zapisu preloadera, `lk_a`/`lk_b` ani `misc`.
