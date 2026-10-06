# Contributing

Thank you for helping. Anyone with an idea for an improvement or a bug report
is welcome.

1. Open an issue first for larger changes, so we can agree on the approach.
2. Fork, create a branch, make the change.
3. Run `flutter gen-l10n`, `flutter analyze` and `flutter test`. All must pass.
4. Open a pull request and describe what changed and why.

## Rules of thumb

- **Calculation changes need a test.** The math lives in `lib/core/leveling.dart`;
  add a case to `test/leveling_test.dart` with hand-checked numbers.
- **Every user-visible text goes into both `lib/l10n/app_ka.arb` and
  `lib/l10n/app_en.arb`.** No hard-coded strings in widgets.
- Keep the credit to the original author (`NOTICE`, About screen) intact.
- By contributing you agree your work is released under the project's MIT license.
