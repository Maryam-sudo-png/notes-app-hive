# Notes App (Flutter + Hive)

A cross-platform notes app built with **Flutter**, featuring full **CRUD** functionality and **encrypted local storage** using **Hive** — no internet or backend required.

## Features

- 📝 Create, edit, and delete notes
- 🔐 Local authentication (login/register) with data persisted via Hive
- 🔍 Search notes by title
- 🗑️ Bulk delete (clear all notes)
- 🎨 Custom "notebook paper" themed UI with a wood-textured background
- 💾 Fully offline — all data stored locally on-device

## Tech Stack

- **Flutter** (Dart) — cross-platform UI framework
- **Hive** & **hive_flutter** — lightweight, fast local NoSQL database
- **intl** — date/time formatting
- **build_runner** & **hive_generator** — Hive type adapter code generation

## Project Structure

```
lib/
├── main.dart              # App entry point, Hive initialization
├── note_model.dart         # Note data model (Hive object)
├── note_model.g.dart        # Auto-generated Hive adapter
├── auth_service.dart        # Local login/register logic
├── login_screen.dart        # Login/register UI
├── notes_home_screen.dart   # Main notes list, search, CRUD UI
├── wood_background.dart     # Reusable wood-textured background widget
└── paper_card.dart          # Reusable ruled-paper styled card widget
```

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/Maryam-sudo-png/notes-app-hive.git
   cd notes-app-hive
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Generate Hive adapters (if needed):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Notes

- Authentication is local-only (stored in a Hive box) and intended for demo purposes, not production-grade security.
- Each device maintains its own independent local data — there is no cloud sync.

## Author

**Maryam** — [GitHub](https://github.com/Maryam-sudo-png)
