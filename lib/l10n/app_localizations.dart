import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ka.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ka'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In ka, this message translates to:
  /// **'ნიველირის კალკულატორი'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In ka, this message translates to:
  /// **'უბრალოდ უპასუხეთ კითხვებს. სიმაღლეებს აპლიკაცია თვითონ დათვლის.'**
  String get appTagline;

  /// No description provided for @projects.
  ///
  /// In ka, this message translates to:
  /// **'პროექტები'**
  String get projects;

  /// No description provided for @noProjects.
  ///
  /// In ka, this message translates to:
  /// **'ჯერ პროექტი არ გაქვთ. შექმენით პირველი.'**
  String get noProjects;

  /// No description provided for @newMeasurement.
  ///
  /// In ka, this message translates to:
  /// **'ახალი გაზომვა'**
  String get newMeasurement;

  /// No description provided for @newMeasurementHint.
  ///
  /// In ka, this message translates to:
  /// **'სიმაღლეების გაზომვა წერტილებზე'**
  String get newMeasurementHint;

  /// No description provided for @newStakeout.
  ///
  /// In ka, this message translates to:
  /// **'ახალი დაზუსტება'**
  String get newStakeout;

  /// No description provided for @newStakeoutHint.
  ///
  /// In ka, this message translates to:
  /// **'იატაკის მოჭიმვა, არხი, კანალიზაცია, გზა: რამდენი ამოიღოთ ან შეავსოთ'**
  String get newStakeoutHint;

  /// No description provided for @settings.
  ///
  /// In ka, this message translates to:
  /// **'პარამეტრები'**
  String get settings;

  /// No description provided for @theme.
  ///
  /// In ka, this message translates to:
  /// **'თემა'**
  String get theme;

  /// No description provided for @themeSystem.
  ///
  /// In ka, this message translates to:
  /// **'სისტემის მიხედვით'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In ka, this message translates to:
  /// **'თეთრი'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In ka, this message translates to:
  /// **'მუქი'**
  String get themeDark;

  /// No description provided for @language.
  ///
  /// In ka, this message translates to:
  /// **'ენა'**
  String get language;

  /// No description provided for @about.
  ///
  /// In ka, this message translates to:
  /// **'ავტორების შესახებ'**
  String get about;

  /// No description provided for @copyright.
  ///
  /// In ka, this message translates to:
  /// **'© საავტორო უფლებები დაცულია'**
  String get copyright;

  /// No description provided for @originalAuthorTitle.
  ///
  /// In ka, this message translates to:
  /// **'იდეის ავტორი და შემსრულებელი'**
  String get originalAuthorTitle;

  /// No description provided for @originalAuthorName.
  ///
  /// In ka, this message translates to:
  /// **'გოგიტა შაინიძე'**
  String get originalAuthorName;

  /// No description provided for @phone.
  ///
  /// In ka, this message translates to:
  /// **'ტელეფონი'**
  String get phone;

  /// No description provided for @facebook.
  ///
  /// In ka, this message translates to:
  /// **'Facebook'**
  String get facebook;

  /// No description provided for @feedbackNote.
  ///
  /// In ka, this message translates to:
  /// **'აღნიშნული იდეის განვითარების ან ხარვეზის გამოვლენის შემთხვევაში, გთხოვთ, დაუკავშირდეთ ზემოთ მითითებულ ნომერზე.'**
  String get feedbackNote;

  /// No description provided for @usedWithPermission.
  ///
  /// In ka, this message translates to:
  /// **'აპლიკაცია გადმოტანილია Flutter-ზე იდეის ავტორის ნებართვით.'**
  String get usedWithPermission;

  /// No description provided for @developerTitle.
  ///
  /// In ka, this message translates to:
  /// **'Flutter-ზე გადატანა და განვითარება'**
  String get developerTitle;

  /// No description provided for @version.
  ///
  /// In ka, this message translates to:
  /// **'ვერსია'**
  String get version;

  /// No description provided for @newProjectName.
  ///
  /// In ka, this message translates to:
  /// **'ახალი პროექტის სახელი'**
  String get newProjectName;

  /// No description provided for @projectNameHint.
  ///
  /// In ka, this message translates to:
  /// **'მაგ. ეზო, ქუჩა 5'**
  String get projectNameHint;

  /// No description provided for @enterProjectName.
  ///
  /// In ka, this message translates to:
  /// **'ჩაწერეთ პროექტის სახელი.'**
  String get enterProjectName;

  /// No description provided for @open.
  ///
  /// In ka, this message translates to:
  /// **'გახსნა'**
  String get open;

  /// No description provided for @delete.
  ///
  /// In ka, this message translates to:
  /// **'წაშლა'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In ka, this message translates to:
  /// **'გაუქმება'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In ka, this message translates to:
  /// **'შენახვა'**
  String get save;

  /// No description provided for @deleteProjectConfirm.
  ///
  /// In ka, this message translates to:
  /// **'პროექტი „{name}“ სამუდამოდ წაიშალოს?'**
  String deleteProjectConfirm(String name);

  /// No description provided for @pointsCount.
  ///
  /// In ka, this message translates to:
  /// **'{count} წერტილი'**
  String pointsCount(int count);

  /// No description provided for @loadExample.
  ///
  /// In ka, this message translates to:
  /// **'მაგალითის ნახვა'**
  String get loadExample;

  /// No description provided for @exampleName.
  ///
  /// In ka, this message translates to:
  /// **'მაგალითი'**
  String get exampleName;

  /// No description provided for @backToProjects.
  ///
  /// In ka, this message translates to:
  /// **'პროექტები'**
  String get backToProjects;

  /// No description provided for @step1Title.
  ///
  /// In ka, this message translates to:
  /// **'1️⃣ საწყისი წერტილი'**
  String get step1Title;

  /// No description provided for @step1Text.
  ///
  /// In ka, this message translates to:
  /// **'აიღეთ წერტილი, რომლის სიმაღლეც უკვე იცით (რეპერი). ლარტყა დადგით მასზე.'**
  String get step1Text;

  /// No description provided for @pointName.
  ///
  /// In ka, this message translates to:
  /// **'წერტილის სახელი'**
  String get pointName;

  /// No description provided for @pointNameOptional.
  ///
  /// In ka, this message translates to:
  /// **'წერტილის სახელი (არასავალდებულო)'**
  String get pointNameOptional;

  /// No description provided for @startHeightLabel.
  ///
  /// In ka, this message translates to:
  /// **'მისი სიმაღლე (მეტრი)'**
  String get startHeightLabel;

  /// No description provided for @rodReadingFirst.
  ///
  /// In ka, this message translates to:
  /// **'ნიველირის მილში რა რიცხვი ჩანს ლარტყაზე?'**
  String get rodReadingFirst;

  /// No description provided for @instrumentHeightIs.
  ///
  /// In ka, this message translates to:
  /// **'ნიველირის ხედვის სიმაღლე: {v} მ'**
  String instrumentHeightIs(String v);

  /// No description provided for @continueBtn.
  ///
  /// In ka, this message translates to:
  /// **'გაგრძელება →'**
  String get continueBtn;

  /// No description provided for @fillHeightAndReading.
  ///
  /// In ka, this message translates to:
  /// **'ჩაწერეთ სიმაღლე და ლარტყის რიცხვი.'**
  String get fillHeightAndReading;

  /// No description provided for @fillReading.
  ///
  /// In ka, this message translates to:
  /// **'ჩაწერეთ რიცხვი, რომელიც ლარტყაზე ჩანს.'**
  String get fillReading;

  /// No description provided for @nextPointTitle.
  ///
  /// In ka, this message translates to:
  /// **'📏 შემდეგი წერტილი'**
  String get nextPointTitle;

  /// No description provided for @nextPointText.
  ///
  /// In ka, this message translates to:
  /// **'ლარტყა გადაიტანეთ შემდეგ წერტილზე. ნიველირს ადგილიდან ჯერ ნუ ამოძრავებთ. რა რიცხვი ჩანს?'**
  String get nextPointText;

  /// No description provided for @rodNumber.
  ///
  /// In ka, this message translates to:
  /// **'რიცხვი ლარტყაზე (მეტრი)'**
  String get rodNumber;

  /// No description provided for @pointHeightIs.
  ///
  /// In ka, this message translates to:
  /// **'ამ წერტილის სიმაღლე: {v} მ'**
  String pointHeightIs(String v);

  /// No description provided for @whatNow.
  ///
  /// In ka, this message translates to:
  /// **'ახლა რა გინდათ?'**
  String get whatNow;

  /// No description provided for @addIntermediate.
  ///
  /// In ka, this message translates to:
  /// **'➕ კიდევ ერთი წერტილის გაზომვა'**
  String get addIntermediate;

  /// No description provided for @addIntermediateHint.
  ///
  /// In ka, this message translates to:
  /// **'ნიველირი აქვე რჩება'**
  String get addIntermediateHint;

  /// No description provided for @moveLevel.
  ///
  /// In ka, this message translates to:
  /// **'🔄 ნიველირი უნდა გადავიტანო'**
  String get moveLevel;

  /// No description provided for @moveLevelHint.
  ///
  /// In ka, this message translates to:
  /// **'ლარტყა ამ წერტილზე დარჩება!'**
  String get moveLevelHint;

  /// No description provided for @lastPoint.
  ///
  /// In ka, this message translates to:
  /// **'🏁 ეს ბოლო წერტილია'**
  String get lastPoint;

  /// No description provided for @currentInstrumentNote.
  ///
  /// In ka, this message translates to:
  /// **'ნიველირის ხედვის სიმაღლე ახლა: {v} მ (თვითონ ითვლება)'**
  String currentInstrumentNote(String v);

  /// No description provided for @moveTitle.
  ///
  /// In ka, this message translates to:
  /// **'🔄 ნიველირი გადაიტანეთ'**
  String get moveTitle;

  /// No description provided for @moveText.
  ///
  /// In ka, this message translates to:
  /// **'ლარტყა დარჩა წერტილზე {name} ({v} მ). ნიველირი დააყენეთ ახალ ადგილას. ახლა იმავე ლარტყაზე რა რიცხვი ჩანს?'**
  String moveText(String name, String v);

  /// No description provided for @newInstrumentHeightIs.
  ///
  /// In ka, this message translates to:
  /// **'ახალი ხედვის სიმაღლე: {v} მ'**
  String newInstrumentHeightIs(String v);

  /// No description provided for @moveNote.
  ///
  /// In ka, this message translates to:
  /// **'ამის შემდეგ ლარტყა წაიღეთ შემდეგ წერტილზე.'**
  String get moveNote;

  /// No description provided for @doneTitle.
  ///
  /// In ka, this message translates to:
  /// **'🎉 გაზომვა დასრულებულია'**
  String get doneTitle;

  /// No description provided for @doneText.
  ///
  /// In ka, this message translates to:
  /// **'ყველა წერტილის სიმაღლე ჩანს ქვემოთ.'**
  String get doneText;

  /// No description provided for @closingCheck.
  ///
  /// In ka, this message translates to:
  /// **'ჩაკეტვის შემოწმება'**
  String get closingCheck;

  /// No description provided for @noKnownEnd.
  ///
  /// In ka, this message translates to:
  /// **'ბოლო რეპერის სიმაღლე არ არის მითითებული, ამიტომ ჩაკეტვის შემოწმება არ ხდება.'**
  String get noKnownEnd;

  /// No description provided for @needLength.
  ///
  /// In ka, this message translates to:
  /// **'ჩაწერეთ გავლილი მანძილი (კმ), რომ დასაშვებს შევადაროთ.'**
  String get needLength;

  /// No description provided for @needTolerance.
  ///
  /// In ka, this message translates to:
  /// **'ჩაწერეთ დასაშვები ცდომილება (მმ).'**
  String get needTolerance;

  /// No description provided for @closingDiff.
  ///
  /// In ka, this message translates to:
  /// **'განსხვავება: {mm} მმ (დასაშვებია {allowed} მმ)'**
  String closingDiff(String mm, String allowed);

  /// No description provided for @closingDiffOnly.
  ///
  /// In ka, this message translates to:
  /// **'განსხვავება: {mm} მმ'**
  String closingDiffOnly(String mm);

  /// No description provided for @closingOk.
  ///
  /// In ka, this message translates to:
  /// **'✔ გაზომვა ზუსტია'**
  String get closingOk;

  /// No description provided for @closingBad.
  ///
  /// In ka, this message translates to:
  /// **'✘ ცდომილება დიდია – გაზომვა გაიმეორეთ'**
  String get closingBad;

  /// No description provided for @editClosing.
  ///
  /// In ka, this message translates to:
  /// **'✏ ბოლო რეპერის ან ცდომილების შეცვლა'**
  String get editClosing;

  /// No description provided for @pointsAndHeights.
  ///
  /// In ka, this message translates to:
  /// **'წერტილები და მათი სიმაღლეები'**
  String get pointsAndHeights;

  /// No description provided for @undoLast.
  ///
  /// In ka, this message translates to:
  /// **'ბოლოს გაუქმება'**
  String get undoLast;

  /// No description provided for @resetAll.
  ///
  /// In ka, this message translates to:
  /// **'თავიდან დაწყება'**
  String get resetAll;

  /// No description provided for @resetConfirm.
  ///
  /// In ka, this message translates to:
  /// **'ყველაფერი წაიშალოს და თავიდან დაიწყოს?'**
  String get resetConfirm;

  /// No description provided for @paramsTitle.
  ///
  /// In ka, this message translates to:
  /// **'⚙ პარამეტრები'**
  String get paramsTitle;

  /// No description provided for @paramsSubtitle.
  ///
  /// In ka, this message translates to:
  /// **'რეპერები და ცდომილება'**
  String get paramsSubtitle;

  /// No description provided for @startBenchmarkName.
  ///
  /// In ka, this message translates to:
  /// **'საწყისი რეპერის სახელი'**
  String get startBenchmarkName;

  /// No description provided for @startBenchmarkHeight.
  ///
  /// In ka, this message translates to:
  /// **'საწყისი რეპერის სიმაღლე (მ)'**
  String get startBenchmarkHeight;

  /// No description provided for @endKnownHeight.
  ///
  /// In ka, this message translates to:
  /// **'ბოლო რეპერის ცნობილი სიმაღლე (მ) – არასავალდებულო'**
  String get endKnownHeight;

  /// No description provided for @skip.
  ///
  /// In ka, this message translates to:
  /// **'გამოტოვება'**
  String get skip;

  /// No description provided for @skipHint.
  ///
  /// In ka, this message translates to:
  /// **'გამოტოვება შეიძლება'**
  String get skipHint;

  /// No description provided for @toleranceTitle.
  ///
  /// In ka, this message translates to:
  /// **'ცდომილების დასაშვები ზღვარი'**
  String get toleranceTitle;

  /// No description provided for @tolFormula.
  ///
  /// In ka, this message translates to:
  /// **'ფორმულით: c × √L'**
  String get tolFormula;

  /// No description provided for @tolFixed.
  ///
  /// In ka, this message translates to:
  /// **'ფიქსირებული მნიშვნელობა (მმ)'**
  String get tolFixed;

  /// No description provided for @coefficientC.
  ///
  /// In ka, this message translates to:
  /// **'კოეფიციენტი c (მმ)'**
  String get coefficientC;

  /// No description provided for @lengthKm.
  ///
  /// In ka, this message translates to:
  /// **'სვლის სიგრძე L (კმ)'**
  String get lengthKm;

  /// No description provided for @allowedMm.
  ///
  /// In ka, this message translates to:
  /// **'დასაშვები ცდომილება (მმ)'**
  String get allowedMm;

  /// No description provided for @tolFormulaNote.
  ///
  /// In ka, this message translates to:
  /// **'დასაშვები ცდომილება = c × √L. მაგ. c = 10, 12, 20 ან 50, თქვენი ნორმატივის მიხედვით.'**
  String get tolFormulaNote;

  /// No description provided for @correctedHeight.
  ///
  /// In ka, this message translates to:
  /// **'გასწორებული: {v}'**
  String correctedHeight(String v);

  /// No description provided for @editPoint.
  ///
  /// In ka, this message translates to:
  /// **'✏ წერტილის რედაქტირება'**
  String get editPoint;

  /// No description provided for @editPointHint.
  ///
  /// In ka, this message translates to:
  /// **'ცვლილება მყისვე გადაითვლება ყველაფერზე'**
  String get editPointHint;

  /// No description provided for @readingOnRod.
  ///
  /// In ka, this message translates to:
  /// **'ათვლა ლარტყაზე (მ)'**
  String get readingOnRod;

  /// No description provided for @knownHeightOptional.
  ///
  /// In ka, this message translates to:
  /// **'ამ წერტილის ცნობილი სიმაღლე (მ) – არასავალდებულო'**
  String get knownHeightOptional;

  /// No description provided for @fsLabel.
  ///
  /// In ka, this message translates to:
  /// **'წინ ათვლა – ლარტყა ამ წერტილზე, ძველი დგომიდან (მ)'**
  String get fsLabel;

  /// No description provided for @bsLabel.
  ///
  /// In ka, this message translates to:
  /// **'უკან ათვლა – იმავე ლარტყაზე, ახალი დგომიდან (მ)'**
  String get bsLabel;

  /// No description provided for @deletePoint.
  ///
  /// In ka, this message translates to:
  /// **'წერტილის წაშლა'**
  String get deletePoint;

  /// No description provided for @deletePointConfirm.
  ///
  /// In ka, this message translates to:
  /// **'ეს შუალედური წერტილი წაიშალოს?'**
  String get deletePointConfirm;

  /// No description provided for @close.
  ///
  /// In ka, this message translates to:
  /// **'დახურვა'**
  String get close;

  /// No description provided for @sameLevel.
  ///
  /// In ka, this message translates to:
  /// **'🎯 ერთ სიმაღლეზეა'**
  String get sameLevel;

  /// No description provided for @cmUp.
  ///
  /// In ka, this message translates to:
  /// **'⬆ {v} სმ მაღლა'**
  String cmUp(String v);

  /// No description provided for @cmDown.
  ///
  /// In ka, this message translates to:
  /// **'⬇ {v} სმ დაბლა'**
  String cmDown(String v);

  /// No description provided for @vsStart.
  ///
  /// In ka, this message translates to:
  /// **'საწყის რეპერთან: {c}'**
  String vsStart(String c);

  /// No description provided for @vsTurn.
  ///
  /// In ka, this message translates to:
  /// **'გარდამავალ {name}-თან: {c}'**
  String vsTurn(String name, String c);

  /// No description provided for @vsEnd.
  ///
  /// In ka, this message translates to:
  /// **'ბოლო რეპერთან: {c}'**
  String vsEnd(String c);

  /// No description provided for @defaultEndName.
  ///
  /// In ka, this message translates to:
  /// **'ბოლო'**
  String get defaultEndName;

  /// No description provided for @metersShort.
  ///
  /// In ka, this message translates to:
  /// **'მ'**
  String get metersShort;

  /// No description provided for @stakeTip.
  ///
  /// In ka, this message translates to:
  /// **'🎯 დაზუსტება: ჩაწერეთ, რა სიმაღლე უნდა იყოს საწყის წერტილზე და რა ქანობით უნდა იცვლებოდეს მანძილის მიხედვით. იატაკისთვის ქანობი 0 დატოვეთ.'**
  String get stakeTip;

  /// No description provided for @designStartLabel.
  ///
  /// In ka, this message translates to:
  /// **'საპროექტო სიმაღლე საწყის წერტილში (მ)'**
  String get designStartLabel;

  /// No description provided for @slopePercent.
  ///
  /// In ka, this message translates to:
  /// **'ქანობი (%)'**
  String get slopePercent;

  /// No description provided for @slopeDirection.
  ///
  /// In ka, this message translates to:
  /// **'მიმართულება'**
  String get slopeDirection;

  /// No description provided for @descending.
  ///
  /// In ka, this message translates to:
  /// **'დაღმავალი (−)'**
  String get descending;

  /// No description provided for @ascending.
  ///
  /// In ka, this message translates to:
  /// **'აღმავალი (+)'**
  String get ascending;

  /// No description provided for @slopeNote.
  ///
  /// In ka, this message translates to:
  /// **'0.5% = 5 მმ ყოველ 1 მეტრზე.'**
  String get slopeNote;

  /// No description provided for @stakeToleranceLabel.
  ///
  /// In ka, this message translates to:
  /// **'დასაშვები გადახრა (მმ)'**
  String get stakeToleranceLabel;

  /// No description provided for @enterDesign.
  ///
  /// In ka, this message translates to:
  /// **'ჩაწერეთ საპროექტო სიმაღლე.'**
  String get enterDesign;

  /// No description provided for @chainageLabel.
  ///
  /// In ka, this message translates to:
  /// **'მანძილი საწყისი წერტილიდან (მ)'**
  String get chainageLabel;

  /// No description provided for @chainageLabelOptional.
  ///
  /// In ka, this message translates to:
  /// **'მანძილი საწყისი წერტილიდან (მ) – არასავალდებულო'**
  String get chainageLabelOptional;

  /// No description provided for @designHeightIs.
  ///
  /// In ka, this message translates to:
  /// **'საპროექტო სიმაღლე: {v} მ'**
  String designHeightIs(String v);

  /// No description provided for @rodShouldShow.
  ///
  /// In ka, this message translates to:
  /// **'ლარტყაზე უნდა ჩანდეს: {v}'**
  String rodShouldShow(String v);

  /// No description provided for @actualHeightIs.
  ///
  /// In ka, this message translates to:
  /// **'ფაქტიური სიმაღლე: {v} მ'**
  String actualHeightIs(String v);

  /// No description provided for @verdictExact.
  ///
  /// In ka, this message translates to:
  /// **'✔ ზუსტია ({mm} მმ)'**
  String verdictExact(String mm);

  /// No description provided for @verdictRemove.
  ///
  /// In ka, this message translates to:
  /// **'⬇ ამოიღეთ {mm} მმ'**
  String verdictRemove(String mm);

  /// No description provided for @verdictFill.
  ///
  /// In ka, this message translates to:
  /// **'⬆ შეავსეთ {mm} მმ'**
  String verdictFill(String mm);

  /// No description provided for @designShort.
  ///
  /// In ka, this message translates to:
  /// **'საპროექტო {v}'**
  String designShort(String v);

  /// No description provided for @stakeParams.
  ///
  /// In ka, this message translates to:
  /// **'დაზუსტების პარამეტრები'**
  String get stakeParams;

  /// No description provided for @exportTitle.
  ///
  /// In ka, this message translates to:
  /// **'შენახვა'**
  String get exportTitle;

  /// No description provided for @exportPdf.
  ///
  /// In ka, this message translates to:
  /// **'PDF'**
  String get exportPdf;

  /// No description provided for @exportXlsx.
  ///
  /// In ka, this message translates to:
  /// **'Excel'**
  String get exportXlsx;

  /// No description provided for @exportShare.
  ///
  /// In ka, this message translates to:
  /// **'გაზიარება'**
  String get exportShare;

  /// No description provided for @exportNote.
  ///
  /// In ka, this message translates to:
  /// **'გაზიარებით ფაილს პირდაპირ გაგზავნით WhatsApp-ით, Viber-ით, Telegram-ით, მეილით და სხვა აპლიკაციებით.'**
  String get exportNote;

  /// No description provided for @exportSaved.
  ///
  /// In ka, this message translates to:
  /// **'ფაილი შენახულია: {name}'**
  String exportSaved(String name);

  /// No description provided for @exportShared.
  ///
  /// In ka, this message translates to:
  /// **'გაზიარების ფანჯარა გაიხსნა.'**
  String get exportShared;

  /// No description provided for @exportError.
  ///
  /// In ka, this message translates to:
  /// **'შეცდომა: {e}'**
  String exportError(String e);

  /// No description provided for @reportProject.
  ///
  /// In ka, this message translates to:
  /// **'პროექტი: {name}'**
  String reportProject(String name);

  /// No description provided for @reportJournal.
  ///
  /// In ka, this message translates to:
  /// **'ნიველირის ჟურნალი'**
  String get reportJournal;

  /// No description provided for @reportDate.
  ///
  /// In ka, this message translates to:
  /// **'თარიღი'**
  String get reportDate;

  /// No description provided for @reportStartPoint.
  ///
  /// In ka, this message translates to:
  /// **'საწყისი წერტილი (რეპერი)'**
  String get reportStartPoint;

  /// No description provided for @reportHeightM.
  ///
  /// In ka, this message translates to:
  /// **'სიმაღლე (მ)'**
  String get reportHeightM;

  /// No description provided for @reportDesignAtStart.
  ///
  /// In ka, this message translates to:
  /// **'საპროექტო სიმაღლე საწყის წერტილში'**
  String get reportDesignAtStart;

  /// No description provided for @reportSlope.
  ///
  /// In ka, this message translates to:
  /// **'ქანობი (%)'**
  String get reportSlope;

  /// No description provided for @reportTolerance.
  ///
  /// In ka, this message translates to:
  /// **'დასაშვები გადახრა (მმ)'**
  String get reportTolerance;

  /// No description provided for @legendTitle.
  ///
  /// In ka, this message translates to:
  /// **'განმარტება'**
  String get legendTitle;

  /// No description provided for @howCalculated.
  ///
  /// In ka, this message translates to:
  /// **'როგორ დავთვალეთ'**
  String get howCalculated;

  /// No description provided for @howCalculatedPerPoint.
  ///
  /// In ka, this message translates to:
  /// **'როგორ დავთვალეთ (თითოეული წერტილი)'**
  String get howCalculatedPerPoint;

  /// No description provided for @controlTitle.
  ///
  /// In ka, this message translates to:
  /// **'კონტროლი (როგორ შევამოწმეთ)'**
  String get controlTitle;

  /// No description provided for @typeStart.
  ///
  /// In ka, this message translates to:
  /// **'საწყისი წერტილი (რეპერი)'**
  String get typeStart;

  /// No description provided for @typeIntermediate.
  ///
  /// In ka, this message translates to:
  /// **'შუალედური წერტილი'**
  String get typeIntermediate;

  /// No description provided for @typeTurning.
  ///
  /// In ka, this message translates to:
  /// **'გარდამავალი (ნიველირი აქ გადაიტანეს)'**
  String get typeTurning;

  /// No description provided for @typeEnd.
  ///
  /// In ka, this message translates to:
  /// **'ბოლო წერტილი'**
  String get typeEnd;

  /// No description provided for @colNo.
  ///
  /// In ka, this message translates to:
  /// **'#'**
  String get colNo;

  /// No description provided for @colPoint.
  ///
  /// In ka, this message translates to:
  /// **'წერტილი'**
  String get colPoint;

  /// No description provided for @colType.
  ///
  /// In ka, this message translates to:
  /// **'ტიპი'**
  String get colType;

  /// No description provided for @colBacksight.
  ///
  /// In ka, this message translates to:
  /// **'ათვლა უკან (BS)'**
  String get colBacksight;

  /// No description provided for @colIntermediate.
  ///
  /// In ka, this message translates to:
  /// **'შუალედური ათვლა'**
  String get colIntermediate;

  /// No description provided for @colForesight.
  ///
  /// In ka, this message translates to:
  /// **'ათვლა წინ (FS)'**
  String get colForesight;

  /// No description provided for @colInstrument.
  ///
  /// In ka, this message translates to:
  /// **'ნიველირის ხედვის სიმაღლე'**
  String get colInstrument;

  /// No description provided for @colPointHeight.
  ///
  /// In ka, this message translates to:
  /// **'წერტილის სიმაღლე (მ)'**
  String get colPointHeight;

  /// No description provided for @colAdjusted.
  ///
  /// In ka, this message translates to:
  /// **'გასწორებული სიმაღლე (მ)'**
  String get colAdjusted;

  /// No description provided for @colChainage.
  ///
  /// In ka, this message translates to:
  /// **'მანძილი დასაწყისიდან (მ)'**
  String get colChainage;

  /// No description provided for @colRodReading.
  ///
  /// In ka, this message translates to:
  /// **'ათვლა ლარტყაზე'**
  String get colRodReading;

  /// No description provided for @colActualHeight.
  ///
  /// In ka, this message translates to:
  /// **'ფაქტიური სიმაღლე (მ)'**
  String get colActualHeight;

  /// No description provided for @colDesignHeight.
  ///
  /// In ka, this message translates to:
  /// **'საპროექტო სიმაღლე (მ)'**
  String get colDesignHeight;

  /// No description provided for @colShouldRead.
  ///
  /// In ka, this message translates to:
  /// **'ლარტყაზე უნდა ჩანდეს'**
  String get colShouldRead;

  /// No description provided for @colDeviation.
  ///
  /// In ka, this message translates to:
  /// **'გადახრა (მმ): + ამოიღეთ, − შეავსეთ'**
  String get colDeviation;

  /// No description provided for @colAction.
  ///
  /// In ka, this message translates to:
  /// **'ქმედება'**
  String get colAction;

  /// No description provided for @actExact.
  ///
  /// In ka, this message translates to:
  /// **'ზუსტია'**
  String get actExact;

  /// No description provided for @actRemove.
  ///
  /// In ka, this message translates to:
  /// **'ამოიღეთ'**
  String get actRemove;

  /// No description provided for @actFill.
  ///
  /// In ka, this message translates to:
  /// **'შეავსეთ'**
  String get actFill;

  /// No description provided for @legendM1.
  ///
  /// In ka, this message translates to:
  /// **'საწყისი – ცნობილი სიმაღლის წერტილი (რეპერი), საიდანაც იწყება გაზომვა.'**
  String get legendM1;

  /// No description provided for @legendM2.
  ///
  /// In ka, this message translates to:
  /// **'შუალედური – ჩვეულებრივი წერტილი, ნიველირი ადგილიდან არ გადაუტანიათ.'**
  String get legendM2;

  /// No description provided for @legendM3.
  ///
  /// In ka, this message translates to:
  /// **'გარდამავალი – წერტილი, რომელზეც ლარტყა დარჩა და ნიველირი გადაიტანეს.'**
  String get legendM3;

  /// No description provided for @legendM4.
  ///
  /// In ka, this message translates to:
  /// **'ბოლო – გაზომვის ბოლო წერტილი.'**
  String get legendM4;

  /// No description provided for @legendM5.
  ///
  /// In ka, this message translates to:
  /// **'ათვლა უკან (BS) – რიცხვი ლარტყაზე, როცა ლარტყა ცნობილი სიმაღლის წერტილზე დგას.'**
  String get legendM5;

  /// No description provided for @legendM6.
  ///
  /// In ka, this message translates to:
  /// **'შუალედური ათვლა – რიცხვი ლარტყაზე შუალედურ წერტილზე, ნიველირი ადგილიდან არ გადაუტანიათ.'**
  String get legendM6;

  /// No description provided for @legendM7.
  ///
  /// In ka, this message translates to:
  /// **'ათვლა წინ (FS) – რიცხვი ლარტყაზე გარდამავალ ან ბოლო წერტილზე.'**
  String get legendM7;

  /// No description provided for @legendM8.
  ///
  /// In ka, this message translates to:
  /// **'ნიველირის ხედვის სიმაღლე – სიმაღლე, რომელზეც ნიველირის ხედვის ხაზი გადის (წერტილის სიმაღლე + უკან ათვლა).'**
  String get legendM8;

  /// No description provided for @legendM9.
  ///
  /// In ka, this message translates to:
  /// **'წერტილის სიმაღლე (მ) – წერტილის გამოთვლილი სიმაღლე მეტრებში.'**
  String get legendM9;

  /// No description provided for @legendM10.
  ///
  /// In ka, this message translates to:
  /// **'გასწორებული სიმაღლე (მ) – სიმაღლე ცდომილების გასწორების შემდეგ. ჩანს მხოლოდ მაშინ, როცა ბოლო რეპერის სიმაღლე მითითებულია.'**
  String get legendM10;

  /// No description provided for @legendS1.
  ///
  /// In ka, this message translates to:
  /// **'მანძილი დასაწყისიდან (მ) – მანძილი საწყისი წერტილიდან, მეტრებში.'**
  String get legendS1;

  /// No description provided for @legendS2.
  ///
  /// In ka, this message translates to:
  /// **'ათვლა ლარტყაზე – რიცხვი, რომელიც ლარტყაზე ჩანდა.'**
  String get legendS2;

  /// No description provided for @legendS3.
  ///
  /// In ka, this message translates to:
  /// **'ფაქტიური სიმაღლე (მ) – სიმაღლე, რომელიც ნამდვილად გაზომეთ.'**
  String get legendS3;

  /// No description provided for @legendS4.
  ///
  /// In ka, this message translates to:
  /// **'საპროექტო სიმაღლე (მ) – სიმაღლე, რომელიც უნდა იყოს (საწყისი სიმაღლე და ქანობი × მანძილი).'**
  String get legendS4;

  /// No description provided for @legendS5.
  ///
  /// In ka, this message translates to:
  /// **'ლარტყაზე უნდა ჩანდეს – რიცხვი, რომელიც ლარტყაზე უნდა ჩანდეს, თუ წერტილი საპროექტო სიმაღლეზეა.'**
  String get legendS5;

  /// No description provided for @legendS6.
  ///
  /// In ka, this message translates to:
  /// **'გადახრა (მმ) – ფაქტიური და საპროექტო სიმაღლის სხვაობა. პლუსი (+) – ფაქტიური საპროექტოზე მაღლაა, ამოიღეთ. მინუსი (−) – დაბლაა, შეავსეთ.'**
  String get legendS6;

  /// No description provided for @legendS7.
  ///
  /// In ka, this message translates to:
  /// **'ქმედება – რა უნდა გააკეთოთ: ამოიღეთ, შეავსეთ ან ზუსტია.'**
  String get legendS7;

  /// No description provided for @stepStart.
  ///
  /// In ka, this message translates to:
  /// **'{pn}: სიმაღლე ცნობილია = {start}. ხედვის სიმაღლე = {start} + {bs} (უკან ათვლა) = {hi}'**
  String stepStart(String pn, String start, String bs, String hi);

  /// No description provided for @stepIntermediate.
  ///
  /// In ka, this message translates to:
  /// **'{pn}: სიმაღლე = {hp} (ხედვის სიმაღლე) − {r} (ათვლა) = {rr}'**
  String stepIntermediate(String pn, String hp, String r, String rr);

  /// No description provided for @stepTurning.
  ///
  /// In ka, this message translates to:
  /// **'{pn}: სიმაღლე = {hp} (ხედვის სიმაღლე) − {fs} (წინ ათვლა) = {rr}. ნიველირი გადაიტანეს. ახალი ხედვის სიმაღლე = {rr} + {bs} (უკან ათვლა) = {hi}'**
  String stepTurning(
    String pn,
    String hp,
    String fs,
    String rr,
    String bs,
    String hi,
  );

  /// No description provided for @stepEnd.
  ///
  /// In ka, this message translates to:
  /// **'{pn}: სიმაღლე = {hp} (ხედვის სიმაღლე) − {fs} (წინ ათვლა) = {rr}'**
  String stepEnd(String pn, String hp, String fs, String rr);

  /// No description provided for @stepAdjusted.
  ///
  /// In ka, this message translates to:
  /// **'გასწორებული = {rr} − ({e} × {setup}/{cnt}) = {cor}'**
  String stepAdjusted(
    String rr,
    String e,
    String setup,
    String cnt,
    String cor,
  );

  /// No description provided for @stepDesign.
  ///
  /// In ka, this message translates to:
  /// **'საპროექტო = {d0} + ({slope}% × {ch} მ) = {d}'**
  String stepDesign(String d0, String slope, String ch, String d);

  /// No description provided for @stepStake.
  ///
  /// In ka, this message translates to:
  /// **'ლარტყაზე უნდა ჩანდეს = {hp} − {d} = {need}. გადახრა = {rr} − {d} = {dev} მმ ({act})'**
  String stepStake(
    String hp,
    String d,
    String need,
    String rr,
    String dev,
    String act,
  );

  /// No description provided for @chkSumBs.
  ///
  /// In ka, this message translates to:
  /// **'ΣBS (უკან ათვლების ჯამი)'**
  String get chkSumBs;

  /// No description provided for @chkSumFs.
  ///
  /// In ka, this message translates to:
  /// **'ΣFS (წინ ათვლების ჯამი)'**
  String get chkSumFs;

  /// No description provided for @chkDiffSums.
  ///
  /// In ka, this message translates to:
  /// **'სხვაობა ΣBS − ΣFS'**
  String get chkDiffSums;

  /// No description provided for @chkEndMinusStart.
  ///
  /// In ka, this message translates to:
  /// **'ბოლო წერტილი − საწყისი'**
  String get chkEndMinusStart;

  /// No description provided for @chkVerify.
  ///
  /// In ka, this message translates to:
  /// **'შემოწმება'**
  String get chkVerify;

  /// No description provided for @chkVerifyOk.
  ///
  /// In ka, this message translates to:
  /// **'ორივე სხვაობა ერთნაირია, გამოთვლა სწორია'**
  String get chkVerifyOk;

  /// No description provided for @chkVerifyBad.
  ///
  /// In ka, this message translates to:
  /// **'სხვაობები არ ემთხვევა, გადაამოწმეთ ჩანაწერები'**
  String get chkVerifyBad;

  /// No description provided for @chkKnownEnd.
  ///
  /// In ka, this message translates to:
  /// **'ბოლო წერტილის ცნობილი სიმაღლე'**
  String get chkKnownEnd;

  /// No description provided for @chkError.
  ///
  /// In ka, this message translates to:
  /// **'ცდომილება'**
  String get chkError;

  /// No description provided for @chkErrorValue.
  ///
  /// In ka, this message translates to:
  /// **'{calc} (გამოთვლილი) − {known} (ცნობილი) = {e} მ = {mm} მმ'**
  String chkErrorValue(String calc, String known, String e, String mm);

  /// No description provided for @chkAllowed.
  ///
  /// In ka, this message translates to:
  /// **'დასაშვები ცდომილება'**
  String get chkAllowed;

  /// No description provided for @chkAllowedFormula.
  ///
  /// In ka, this message translates to:
  /// **'{c} × √{l} = {a} მმ'**
  String chkAllowedFormula(String c, String l, String a);

  /// No description provided for @chkAllowedFixed.
  ///
  /// In ka, this message translates to:
  /// **'{a} მმ (ფიქსირებული)'**
  String chkAllowedFixed(String a);

  /// No description provided for @chkConclusion.
  ///
  /// In ka, this message translates to:
  /// **'დასკვნა'**
  String get chkConclusion;

  /// No description provided for @chkConclOk.
  ///
  /// In ka, this message translates to:
  /// **'ცდომილება დასაშვებია'**
  String get chkConclOk;

  /// No description provided for @chkConclBad.
  ///
  /// In ka, this message translates to:
  /// **'ცდომილება აჭარბებს დასაშვებს, გაზომვა გაიმეორეთ'**
  String get chkConclBad;

  /// No description provided for @chkAdjust.
  ///
  /// In ka, this message translates to:
  /// **'გასწორება'**
  String get chkAdjust;

  /// No description provided for @chkAdjustValue.
  ///
  /// In ka, this message translates to:
  /// **'ცდომილება თანაბრად ნაწილდება {n} დგომაზე: ყოველ დგომაზე {mm} მმ'**
  String chkAdjustValue(String n, String mm);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ka'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ka':
      return AppLocalizationsKa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
