# Blog App

A cross-platform Flutter blogging application example (starter template).

This repo contains a starter project for a Flutter app with user authentication, blog posting with image upload, and offline caching.

---

## Table of contents
- [Features](#features)
- [Tech stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Getting started](#getting-started)
- [Environment & Secrets](#environment--secrets)
- [Change app name](#change-app-name)
- [App icons (how to generate)](#app-icons-how-to-generate)
- [Project structure](#project-structure)
- [Running tests & static checks](#running-tests--static-checks)
- [Adding a new feature](#adding-a-new-feature)
- [Security](#security)
- [Contributing](#contributing)
- [License](#license)

---

## Features
- Authentication (Supabase) using Supabase Auth
- Blog posting (create) with image upload to Supabase Storage
- Blog browsing & viewing
- Offline caching for blog list (Hive)
 
## Tech stack
- Flutter SDK (Dart >= 3.9.0)
- Supabase (supabase_flutter)
- State: `flutter_bloc`
- Dependency injection: `get_it`
- Local cache: `hive`
- Image selection: `image_picker`
- Other: `uuid`, `intl`, `internet_connection_checker_plus`

Dev tools:
- `flutter_lints`
- `flutter_launcher_icons` (dev)

---

## Prerequisites
- Flutter SDK (https://docs.flutter.dev/get-started/install)
- Xcode (macOS) for iOS builds
- Android Studio / Android SDK for Android builds
- Chrome for web development

Recommended Flutter commands to validate environment:

```bash
flutter doctor
```

---

## Getting started
1. Clone the repo and install dependencies:

```bash
git clone <repo-url>
cd blog_app
flutter pub get
```

2. Configure Supabase keys (see [Environment & Secrets](#environment--secrets)).

3. Optionally add your app icon (replace `assets/icons/app_icon.png`).

4. Run app (choose a platform/device):

```bash
flutter run
flutter run -d chrome   # web
flutter run -d <device> # specific device
```

5. Build release artifacts:

```bash
flutter build apk
flutter build ios
flutter build web
```

---

## Environment & Secrets
This repo includes `lib/core/secrets/app_keys.dart`. **Do not commit production secrets** in public repos.

Recommended:

1. Replace `lib/core/secrets/app_keys.dart` with safe placeholder values and use environment variables in CI.
2. Or use `flutter_dotenv` to manage a `.env` file that is added to `.gitignore` (safe for development), e.g.: 

```bash
# .env
SUPABASE_URL=https://YOUR_PROJECT.supabase.co
SUPABASE_ANON_KEY=eyJ...yourkey...
```

And in code use `dotenv.get('SUPABASE_URL')` and `dotenv.get('SUPABASE_ANON_KEY')`.

Important: If you leave credentials in `lib/core/secrets/app_keys.dart`, rotate them from Supabase if this repo is public.

---

## Change app name
Platform-specific instructions to update the application name (label / display name):

- Android: `android/app/src/main/AndroidManifest.xml` — update `android:label`.
	Example:
	```xml
	<application android:label="My Blog App" ...>
	```

- iOS: `ios/Runner/Info.plist` — set `CFBundleDisplayName` to `My Blog App`.

- Web: `web/index.html` — set `<title>` & `<meta name=\"apple-mobile-web-app-title\"/>` and update `web/manifest.json` `name` and `short_name`.

- macOS: `macos/Runner/Info.plist` — set `CFBundleName`/`CFBundleDisplayName`.

- Linux: `linux/runner/my_application.cc` — update title in `gtk_header_bar_set_title` and `gtk_window_set_title`.

- Windows: `windows/runner/main.cpp` — update title in `Win32Window::Create(L"My Blog App", ...)` and update `windows/runner/Runner.rc` `ProductName` and `FileDescription`.

Note: Changing the display name does not change the package/bundle id.

---

## App icons (how to generate)
We have a `flutter_launcher_icons` config in `pubspec.yaml` and helper scripts.

Steps:
1. Replace `assets/icons/app_icon.png` with a 1024x1024 PNG.
2. Run:

```bash
flutter pub get
flutter pub run flutter_launcher_icons:main
```

Or use the included helper which makes backups first:

```bash
bash scripts/generate_icons.sh
```

Where icons will be updated in:
- Android: `android/app/src/main/res/mipmap-*/` (ic_launcher variants)
- iOS: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

Note: `scripts/decode_icon.sh` creates a small placeholder `assets/icons/app_icon.png` if absent.

---

## Project structure (main areas)
- `android`, `ios`, `web`, `macos`, `linux`, `windows`: platform folders
- `lib/`: app code (feature-based structure)
	- `lib/init_dependencies.dart` & `init_dependencies_main.dart` — GetIt setup, Supabase & Hive initialization
	- `lib/core/`: shared code — constants, themes, utilities, secrets
	- `lib/features/`: feature modules (auth, blog, domain / data / presentation)

---

## Running tests & static checks
```bash
flutter test
flutter analyze
```

Optional: use `flutter pub outdated` to check for dependency updates.

---

## Adding a new feature — recommended workflow
1. Implement the domain use case and repository interface.
2. Add data sources (remote & local) and repository implementation.
3. Register new dependencies in `init_dependencies.dart`.
4. Add BLoC and UI pages under `lib/features/` and wire them up.
5. Add tests.

---

## Security
- Remove committed secrets and use environment-managed keys.
- Rotate keys if they were committed and the repo is public.

---

## Contributing
1. Fork repo & open a PR.
2. Run `flutter analyze` & `flutter test` and include test coverage for new code.
3. Describe changes in the PR and provide screenshots if UI changes.

---

## License
Add a `LICENSE` file to the repo root for your preferred license (MIT recommended for open-source projects).

---

If you’d like I can also:
- Add `flutter_dotenv` migration to remove `app_keys.dart` and add `app_keys.example.dart` and `.env.example`.
- Add a default `LICENSE` (MIT) and a `CONTRIBUTING.md`.
- Replace `assets/icons/app_icon.png` with a generated logo placeholder and run `flutter_launcher_icons` so icons are committed.

Let me know next steps to implement.
