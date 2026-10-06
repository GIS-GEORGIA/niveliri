# Niveliri · ნიველირის კალკულატორი

Georgian / English leveling calculator for surveyors and builders. You answer
the questions, the app calculates the heights.

ქართულ-ინგლისური ნიველირის კალკულატორი გეოდეზისტებისა და მშენებლებისთვის.
უბრალოდ უპასუხეთ კითხვებს, სიმაღლეებს აპლიკაცია თვითონ დათვლის.

**Web:** https://level.qgis.ge

## Features

- **Measurement mode:** start benchmark, intermediate points, moving the level,
  end point, closing check against a known benchmark, error distribution.
- **Stakeout mode:** design height and slope, how much to remove or fill
  (screed, trench, sewer, road).
- Projects saved on the device, edit any point and everything recalculates.
- PDF and Excel export with the full "how it was calculated" breakdown.
- Georgian and English, light and dark theme.
- Android, iOS, Web and Windows from one Flutter codebase.

## Develop

```bash
flutter pub get
flutter gen-l10n
flutter test
flutter run -d chrome
```

The calculation core is plain Dart in `lib/core/leveling.dart` and is covered by
unit tests in `test/`. Texts live in `lib/l10n/*.arb`.

## Contributing

Ideas, bug reports and pull requests are welcome. See
[CONTRIBUTING.md](CONTRIBUTING.md).

## Credits

- **Idea author and original developer:** Gogita Shainidze (გოგიტა შაინიძე),
  +995 593 55 10 10, https://www.facebook.com/geomapping2018
- **Flutter port and development:** Giorgi Kapanadze (გიორგი კაპანაძე),
  [GIS GEORGIA](https://github.com/GIS-GEORGIA)

Published with the permission of the original author. See [NOTICE](NOTICE).

## License

[MIT](LICENSE). The bundled Noto Sans Georgian font is under the SIL OFL 1.1
(`assets/fonts/OFL.txt`).
