# Flipper Zero qFlipper App Repository

This repository contains a manifest of Flipper Zero application package files that can be loaded using qFlipper. The listed file type is `.fap`, which is the correct package format for Flipper Zero community apps.

## Contents

- `apps-list.csv` — categorized list of unique `.fap` packages
- `apps-list.json` — machine-readable metadata
- `scripts/generate-app-manifest.ps1` — regenerate the manifest from the source artifact folder

## How to use

1. Download or copy the `.fap` app file to your PC.
2. Open qFlipper.
3. Select `Apps` or `Custom apps` and choose the `.fap` file.
4. Transfer the file to your Flipper device.

## Categories included

- Bluetooth
- Games
- GPIO
- iButton
- Infrared
- Media
- NFC
- RFID
- Sub-GHz
- Tools
- USB

## Notes

- Only `.fap` files are listed here because they are the standard Flipper Zero app package format.
- Firmware files such as `.dfu` are not included.
- Make sure qFlipper is up to date before loading community apps.

## Sample app entries

| Category | App file | Path |
|---|---|---|
| Bluetooth | bt_trigger.fap | Bluetooth/bt_trigger.fap |
| Bluetooth | btremote_kodi.fap | Bluetooth/btremote_kodi.fap |
| Bluetooth | claude_remote_ble.fap | Bluetooth/claude_remote_ble.fap |
| Bluetooth | pc_monitor.fap | Bluetooth/pc_monitor.fap |
| Games | 4inrow.fap | Games/4inrow.fap |
| Games | air_labyrinth.fap | Games/air_labyrinth.fap |
| Games | arddrivin.fap | Games/arddrivin.fap |
| Games | ardugolf.fap | Games/ardugolf.fap |
| Games | arduventure.fap | Games/arduventure.fap |
| Games | asteroids.fap | Games/asteroids.fap |
