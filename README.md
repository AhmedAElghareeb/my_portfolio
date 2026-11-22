# Ahmed Elghareeb · Flutter & Mobile Developer

A Flutter Web portfolio for selected mobile engineering case studies, the full project catalog, experience, technical expertise, education, and professional contact.

## Run locally

Use Flutter 3.32 or later and Dart 3.8 or later. The project was developed with Flutter 3.32.5 and Dart 3.8.1.

```sh
flutter pub get
flutter run -d chrome
flutter analyze
flutter test
flutter build web --release --base-href /my_portfolio/
```

The release build is written to `build/web`. Serve this directory under `/my_portfolio/` when checking the release locally.

## Code and content

- `lib/data/` holds project facts, store links, employment, and skills. UFOO and Geta each keep their customer and driver links in one project.
- `lib/core/` holds themes, breakpoints, spacing, and motion preferences.
- `lib/presentation/` holds the single-page layout and responsive sections.
- `assets/projects/screens/` holds real captures from the Google Play listings for Zidcash, UFOO, and P2P Syria and the App Store listings for Geta and Core Team – SmartHub. Gebal Alrwasay uses its existing logo.
- Manrope is bundled with its SIL Open Font License. The CV is pending approval of a public version.

The HTML shell provides a canonical URL, sharing metadata, and a short no-script summary. The portfolio content is rendered by Flutter.
