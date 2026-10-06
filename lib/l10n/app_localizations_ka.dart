// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Georgian (`ka`).
class AppLocalizationsKa extends AppLocalizations {
  AppLocalizationsKa([String locale = 'ka']) : super(locale);

  @override
  String get appTitle => 'ნიველირის კალკულატორი';

  @override
  String get appTagline =>
      'უბრალოდ უპასუხეთ კითხვებს. სიმაღლეებს აპლიკაცია თვითონ დათვლის.';

  @override
  String get projects => 'პროექტები';

  @override
  String get noProjects => 'ჯერ პროექტი არ გაქვთ. შექმენით პირველი.';

  @override
  String get newMeasurement => 'ახალი გაზომვა';

  @override
  String get newMeasurementHint => 'სიმაღლეების გაზომვა წერტილებზე';

  @override
  String get newStakeout => 'ახალი დაზუსტება';

  @override
  String get newStakeoutHint =>
      'იატაკის მოჭიმვა, არხი, კანალიზაცია, გზა: რამდენი ამოიღოთ ან შეავსოთ';

  @override
  String get settings => 'პარამეტრები';

  @override
  String get theme => 'თემა';

  @override
  String get themeSystem => 'სისტემის მიხედვით';

  @override
  String get themeLight => 'თეთრი';

  @override
  String get themeDark => 'მუქი';

  @override
  String get language => 'ენა';

  @override
  String get about => 'ავტორების შესახებ';

  @override
  String get copyright => '© საავტორო უფლებები დაცულია';

  @override
  String get originalAuthorTitle => 'იდეის ავტორი და შემსრულებელი';

  @override
  String get originalAuthorName => 'გოგიტა შაინიძე';

  @override
  String get phone => 'ტელეფონი';

  @override
  String get facebook => 'Facebook';

  @override
  String get feedbackNote =>
      'აღნიშნული იდეის განვითარების ან ხარვეზის გამოვლენის შემთხვევაში, გთხოვთ, დაუკავშირდეთ ზემოთ მითითებულ ნომერზე.';

  @override
  String get usedWithPermission =>
      'აპლიკაცია გადმოტანილია Flutter-ზე იდეის ავტორის ნებართვით.';

  @override
  String get developerTitle => 'Flutter-ზე გადატანა და განვითარება';

  @override
  String get version => 'ვერსია';

  @override
  String get newProjectName => 'ახალი პროექტის სახელი';

  @override
  String get projectNameHint => 'მაგ. ეზო, ქუჩა 5';

  @override
  String get enterProjectName => 'ჩაწერეთ პროექტის სახელი.';

  @override
  String get open => 'გახსნა';

  @override
  String get delete => 'წაშლა';

  @override
  String get cancel => 'გაუქმება';

  @override
  String get save => 'შენახვა';

  @override
  String deleteProjectConfirm(String name) {
    return 'პროექტი „$name“ სამუდამოდ წაიშალოს?';
  }

  @override
  String pointsCount(int count) {
    return '$count წერტილი';
  }

  @override
  String get loadExample => 'მაგალითის ნახვა';

  @override
  String get exampleName => 'მაგალითი';

  @override
  String get backToProjects => 'პროექტები';

  @override
  String get step1Title => '1️⃣ საწყისი წერტილი';

  @override
  String get step1Text =>
      'აიღეთ წერტილი, რომლის სიმაღლეც უკვე იცით (რეპერი). ლარტყა დადგით მასზე.';

  @override
  String get pointName => 'წერტილის სახელი';

  @override
  String get pointNameOptional => 'წერტილის სახელი (არასავალდებულო)';

  @override
  String get startHeightLabel => 'მისი სიმაღლე (მეტრი)';

  @override
  String get rodReadingFirst => 'ნიველირის მილში რა რიცხვი ჩანს ლარტყაზე?';

  @override
  String instrumentHeightIs(String v) {
    return 'ნიველირის ხედვის სიმაღლე: $v მ';
  }

  @override
  String get continueBtn => 'გაგრძელება →';

  @override
  String get fillHeightAndReading => 'ჩაწერეთ სიმაღლე და ლარტყის რიცხვი.';

  @override
  String get fillReading => 'ჩაწერეთ რიცხვი, რომელიც ლარტყაზე ჩანს.';

  @override
  String get nextPointTitle => '📏 შემდეგი წერტილი';

  @override
  String get nextPointText =>
      'ლარტყა გადაიტანეთ შემდეგ წერტილზე. ნიველირს ადგილიდან ჯერ ნუ ამოძრავებთ. რა რიცხვი ჩანს?';

  @override
  String get rodNumber => 'რიცხვი ლარტყაზე (მეტრი)';

  @override
  String pointHeightIs(String v) {
    return 'ამ წერტილის სიმაღლე: $v მ';
  }

  @override
  String get whatNow => 'ახლა რა გინდათ?';

  @override
  String get addIntermediate => '➕ კიდევ ერთი წერტილის გაზომვა';

  @override
  String get addIntermediateHint => 'ნიველირი აქვე რჩება';

  @override
  String get moveLevel => '🔄 ნიველირი უნდა გადავიტანო';

  @override
  String get moveLevelHint => 'ლარტყა ამ წერტილზე დარჩება!';

  @override
  String get lastPoint => '🏁 ეს ბოლო წერტილია';

  @override
  String currentInstrumentNote(String v) {
    return 'ნიველირის ხედვის სიმაღლე ახლა: $v მ (თვითონ ითვლება)';
  }

  @override
  String get moveTitle => '🔄 ნიველირი გადაიტანეთ';

  @override
  String moveText(String name, String v) {
    return 'ლარტყა დარჩა წერტილზე $name ($v მ). ნიველირი დააყენეთ ახალ ადგილას. ახლა იმავე ლარტყაზე რა რიცხვი ჩანს?';
  }

  @override
  String newInstrumentHeightIs(String v) {
    return 'ახალი ხედვის სიმაღლე: $v მ';
  }

  @override
  String get moveNote => 'ამის შემდეგ ლარტყა წაიღეთ შემდეგ წერტილზე.';

  @override
  String get doneTitle => '🎉 გაზომვა დასრულებულია';

  @override
  String get doneText => 'ყველა წერტილის სიმაღლე ჩანს ქვემოთ.';

  @override
  String get closingCheck => 'ჩაკეტვის შემოწმება';

  @override
  String get noKnownEnd =>
      'ბოლო რეპერის სიმაღლე არ არის მითითებული, ამიტომ ჩაკეტვის შემოწმება არ ხდება.';

  @override
  String get needLength =>
      'ჩაწერეთ გავლილი მანძილი (კმ), რომ დასაშვებს შევადაროთ.';

  @override
  String get needTolerance => 'ჩაწერეთ დასაშვები ცდომილება (მმ).';

  @override
  String closingDiff(String mm, String allowed) {
    return 'განსხვავება: $mm მმ (დასაშვებია $allowed მმ)';
  }

  @override
  String closingDiffOnly(String mm) {
    return 'განსხვავება: $mm მმ';
  }

  @override
  String get closingOk => '✔ გაზომვა ზუსტია';

  @override
  String get closingBad => '✘ ცდომილება დიდია – გაზომვა გაიმეორეთ';

  @override
  String get editClosing => '✏ ბოლო რეპერის ან ცდომილების შეცვლა';

  @override
  String get pointsAndHeights => 'წერტილები და მათი სიმაღლეები';

  @override
  String get undoLast => 'ბოლოს გაუქმება';

  @override
  String get resetAll => 'თავიდან დაწყება';

  @override
  String get resetConfirm => 'ყველაფერი წაიშალოს და თავიდან დაიწყოს?';

  @override
  String get paramsTitle => '⚙ პარამეტრები';

  @override
  String get paramsSubtitle => 'რეპერები და ცდომილება';

  @override
  String get startBenchmarkName => 'საწყისი რეპერის სახელი';

  @override
  String get startBenchmarkHeight => 'საწყისი რეპერის სიმაღლე (მ)';

  @override
  String get endKnownHeight =>
      'ბოლო რეპერის ცნობილი სიმაღლე (მ) – არასავალდებულო';

  @override
  String get skip => 'გამოტოვება';

  @override
  String get skipHint => 'გამოტოვება შეიძლება';

  @override
  String get toleranceTitle => 'ცდომილების დასაშვები ზღვარი';

  @override
  String get tolFormula => 'ფორმულით: c × √L';

  @override
  String get tolFixed => 'ფიქსირებული მნიშვნელობა (მმ)';

  @override
  String get coefficientC => 'კოეფიციენტი c (მმ)';

  @override
  String get lengthKm => 'სვლის სიგრძე L (კმ)';

  @override
  String get allowedMm => 'დასაშვები ცდომილება (მმ)';

  @override
  String get tolFormulaNote =>
      'დასაშვები ცდომილება = c × √L. მაგ. c = 10, 12, 20 ან 50, თქვენი ნორმატივის მიხედვით.';

  @override
  String correctedHeight(String v) {
    return 'გასწორებული: $v';
  }

  @override
  String get editPoint => '✏ წერტილის რედაქტირება';

  @override
  String get editPointHint => 'ცვლილება მყისვე გადაითვლება ყველაფერზე';

  @override
  String get readingOnRod => 'ათვლა ლარტყაზე (მ)';

  @override
  String get knownHeightOptional =>
      'ამ წერტილის ცნობილი სიმაღლე (მ) – არასავალდებულო';

  @override
  String get fsLabel => 'წინ ათვლა – ლარტყა ამ წერტილზე, ძველი დგომიდან (მ)';

  @override
  String get bsLabel => 'უკან ათვლა – იმავე ლარტყაზე, ახალი დგომიდან (მ)';

  @override
  String get deletePoint => 'წერტილის წაშლა';

  @override
  String get deletePointConfirm => 'ეს შუალედური წერტილი წაიშალოს?';

  @override
  String get close => 'დახურვა';

  @override
  String get sameLevel => '🎯 ერთ სიმაღლეზეა';

  @override
  String cmUp(String v) {
    return '⬆ $v სმ მაღლა';
  }

  @override
  String cmDown(String v) {
    return '⬇ $v სმ დაბლა';
  }

  @override
  String vsStart(String c) {
    return 'საწყის რეპერთან: $c';
  }

  @override
  String vsTurn(String name, String c) {
    return 'გარდამავალ $name-თან: $c';
  }

  @override
  String vsEnd(String c) {
    return 'ბოლო რეპერთან: $c';
  }

  @override
  String get defaultEndName => 'ბოლო';

  @override
  String get metersShort => 'მ';

  @override
  String get stakeTip =>
      '🎯 დაზუსტება: ჩაწერეთ, რა სიმაღლე უნდა იყოს საწყის წერტილზე და რა ქანობით უნდა იცვლებოდეს მანძილის მიხედვით. იატაკისთვის ქანობი 0 დატოვეთ.';

  @override
  String get designStartLabel => 'საპროექტო სიმაღლე საწყის წერტილში (მ)';

  @override
  String get slopePercent => 'ქანობი (%)';

  @override
  String get slopeDirection => 'მიმართულება';

  @override
  String get descending => 'დაღმავალი (−)';

  @override
  String get ascending => 'აღმავალი (+)';

  @override
  String get slopeNote => '0.5% = 5 მმ ყოველ 1 მეტრზე.';

  @override
  String get stakeToleranceLabel => 'დასაშვები გადახრა (მმ)';

  @override
  String get enterDesign => 'ჩაწერეთ საპროექტო სიმაღლე.';

  @override
  String get chainageLabel => 'მანძილი საწყისი წერტილიდან (მ)';

  @override
  String get chainageLabelOptional =>
      'მანძილი საწყისი წერტილიდან (მ) – არასავალდებულო';

  @override
  String designHeightIs(String v) {
    return 'საპროექტო სიმაღლე: $v მ';
  }

  @override
  String rodShouldShow(String v) {
    return 'ლარტყაზე უნდა ჩანდეს: $v';
  }

  @override
  String actualHeightIs(String v) {
    return 'ფაქტიური სიმაღლე: $v მ';
  }

  @override
  String verdictExact(String mm) {
    return '✔ ზუსტია ($mm მმ)';
  }

  @override
  String verdictRemove(String mm) {
    return '⬇ ამოიღეთ $mm მმ';
  }

  @override
  String verdictFill(String mm) {
    return '⬆ შეავსეთ $mm მმ';
  }

  @override
  String designShort(String v) {
    return 'საპროექტო $v';
  }

  @override
  String get stakeParams => 'დაზუსტების პარამეტრები';

  @override
  String get exportTitle => 'შენახვა';

  @override
  String get exportPdf => 'PDF';

  @override
  String get exportXlsx => 'Excel';

  @override
  String get exportShare => 'გაზიარება';

  @override
  String get exportNote =>
      'გაზიარებით ფაილს პირდაპირ გაგზავნით WhatsApp-ით, Viber-ით, Telegram-ით, მეილით და სხვა აპლიკაციებით.';

  @override
  String exportSaved(String name) {
    return 'ფაილი შენახულია: $name';
  }

  @override
  String get exportShared => 'გაზიარების ფანჯარა გაიხსნა.';

  @override
  String exportError(String e) {
    return 'შეცდომა: $e';
  }

  @override
  String reportProject(String name) {
    return 'პროექტი: $name';
  }

  @override
  String get reportJournal => 'ნიველირის ჟურნალი';

  @override
  String get reportDate => 'თარიღი';

  @override
  String get reportStartPoint => 'საწყისი წერტილი (რეპერი)';

  @override
  String get reportHeightM => 'სიმაღლე (მ)';

  @override
  String get reportDesignAtStart => 'საპროექტო სიმაღლე საწყის წერტილში';

  @override
  String get reportSlope => 'ქანობი (%)';

  @override
  String get reportTolerance => 'დასაშვები გადახრა (მმ)';

  @override
  String get legendTitle => 'განმარტება';

  @override
  String get howCalculated => 'როგორ დავთვალეთ';

  @override
  String get howCalculatedPerPoint => 'როგორ დავთვალეთ (თითოეული წერტილი)';

  @override
  String get controlTitle => 'კონტროლი (როგორ შევამოწმეთ)';

  @override
  String get typeStart => 'საწყისი წერტილი (რეპერი)';

  @override
  String get typeIntermediate => 'შუალედური წერტილი';

  @override
  String get typeTurning => 'გარდამავალი (ნიველირი აქ გადაიტანეს)';

  @override
  String get typeEnd => 'ბოლო წერტილი';

  @override
  String get colNo => '#';

  @override
  String get colPoint => 'წერტილი';

  @override
  String get colType => 'ტიპი';

  @override
  String get colBacksight => 'ათვლა უკან (BS)';

  @override
  String get colIntermediate => 'შუალედური ათვლა';

  @override
  String get colForesight => 'ათვლა წინ (FS)';

  @override
  String get colInstrument => 'ნიველირის ხედვის სიმაღლე';

  @override
  String get colPointHeight => 'წერტილის სიმაღლე (მ)';

  @override
  String get colAdjusted => 'გასწორებული სიმაღლე (მ)';

  @override
  String get colChainage => 'მანძილი დასაწყისიდან (მ)';

  @override
  String get colRodReading => 'ათვლა ლარტყაზე';

  @override
  String get colActualHeight => 'ფაქტიური სიმაღლე (მ)';

  @override
  String get colDesignHeight => 'საპროექტო სიმაღლე (მ)';

  @override
  String get colShouldRead => 'ლარტყაზე უნდა ჩანდეს';

  @override
  String get colDeviation => 'გადახრა (მმ): + ამოიღეთ, − შეავსეთ';

  @override
  String get colAction => 'ქმედება';

  @override
  String get actExact => 'ზუსტია';

  @override
  String get actRemove => 'ამოიღეთ';

  @override
  String get actFill => 'შეავსეთ';

  @override
  String get legendM1 =>
      'საწყისი – ცნობილი სიმაღლის წერტილი (რეპერი), საიდანაც იწყება გაზომვა.';

  @override
  String get legendM2 =>
      'შუალედური – ჩვეულებრივი წერტილი, ნიველირი ადგილიდან არ გადაუტანიათ.';

  @override
  String get legendM3 =>
      'გარდამავალი – წერტილი, რომელზეც ლარტყა დარჩა და ნიველირი გადაიტანეს.';

  @override
  String get legendM4 => 'ბოლო – გაზომვის ბოლო წერტილი.';

  @override
  String get legendM5 =>
      'ათვლა უკან (BS) – რიცხვი ლარტყაზე, როცა ლარტყა ცნობილი სიმაღლის წერტილზე დგას.';

  @override
  String get legendM6 =>
      'შუალედური ათვლა – რიცხვი ლარტყაზე შუალედურ წერტილზე, ნიველირი ადგილიდან არ გადაუტანიათ.';

  @override
  String get legendM7 =>
      'ათვლა წინ (FS) – რიცხვი ლარტყაზე გარდამავალ ან ბოლო წერტილზე.';

  @override
  String get legendM8 =>
      'ნიველირის ხედვის სიმაღლე – სიმაღლე, რომელზეც ნიველირის ხედვის ხაზი გადის (წერტილის სიმაღლე + უკან ათვლა).';

  @override
  String get legendM9 =>
      'წერტილის სიმაღლე (მ) – წერტილის გამოთვლილი სიმაღლე მეტრებში.';

  @override
  String get legendM10 =>
      'გასწორებული სიმაღლე (მ) – სიმაღლე ცდომილების გასწორების შემდეგ. ჩანს მხოლოდ მაშინ, როცა ბოლო რეპერის სიმაღლე მითითებულია.';

  @override
  String get legendS1 =>
      'მანძილი დასაწყისიდან (მ) – მანძილი საწყისი წერტილიდან, მეტრებში.';

  @override
  String get legendS2 => 'ათვლა ლარტყაზე – რიცხვი, რომელიც ლარტყაზე ჩანდა.';

  @override
  String get legendS3 =>
      'ფაქტიური სიმაღლე (მ) – სიმაღლე, რომელიც ნამდვილად გაზომეთ.';

  @override
  String get legendS4 =>
      'საპროექტო სიმაღლე (მ) – სიმაღლე, რომელიც უნდა იყოს (საწყისი სიმაღლე და ქანობი × მანძილი).';

  @override
  String get legendS5 =>
      'ლარტყაზე უნდა ჩანდეს – რიცხვი, რომელიც ლარტყაზე უნდა ჩანდეს, თუ წერტილი საპროექტო სიმაღლეზეა.';

  @override
  String get legendS6 =>
      'გადახრა (მმ) – ფაქტიური და საპროექტო სიმაღლის სხვაობა. პლუსი (+) – ფაქტიური საპროექტოზე მაღლაა, ამოიღეთ. მინუსი (−) – დაბლაა, შეავსეთ.';

  @override
  String get legendS7 =>
      'ქმედება – რა უნდა გააკეთოთ: ამოიღეთ, შეავსეთ ან ზუსტია.';

  @override
  String stepStart(String pn, String start, String bs, String hi) {
    return '$pn: სიმაღლე ცნობილია = $start. ხედვის სიმაღლე = $start + $bs (უკან ათვლა) = $hi';
  }

  @override
  String stepIntermediate(String pn, String hp, String r, String rr) {
    return '$pn: სიმაღლე = $hp (ხედვის სიმაღლე) − $r (ათვლა) = $rr';
  }

  @override
  String stepTurning(
    String pn,
    String hp,
    String fs,
    String rr,
    String bs,
    String hi,
  ) {
    return '$pn: სიმაღლე = $hp (ხედვის სიმაღლე) − $fs (წინ ათვლა) = $rr. ნიველირი გადაიტანეს. ახალი ხედვის სიმაღლე = $rr + $bs (უკან ათვლა) = $hi';
  }

  @override
  String stepEnd(String pn, String hp, String fs, String rr) {
    return '$pn: სიმაღლე = $hp (ხედვის სიმაღლე) − $fs (წინ ათვლა) = $rr';
  }

  @override
  String stepAdjusted(
    String rr,
    String e,
    String setup,
    String cnt,
    String cor,
  ) {
    return 'გასწორებული = $rr − ($e × $setup/$cnt) = $cor';
  }

  @override
  String stepDesign(String d0, String slope, String ch, String d) {
    return 'საპროექტო = $d0 + ($slope% × $ch მ) = $d';
  }

  @override
  String stepStake(
    String hp,
    String d,
    String need,
    String rr,
    String dev,
    String act,
  ) {
    return 'ლარტყაზე უნდა ჩანდეს = $hp − $d = $need. გადახრა = $rr − $d = $dev მმ ($act)';
  }

  @override
  String get chkSumBs => 'ΣBS (უკან ათვლების ჯამი)';

  @override
  String get chkSumFs => 'ΣFS (წინ ათვლების ჯამი)';

  @override
  String get chkDiffSums => 'სხვაობა ΣBS − ΣFS';

  @override
  String get chkEndMinusStart => 'ბოლო წერტილი − საწყისი';

  @override
  String get chkVerify => 'შემოწმება';

  @override
  String get chkVerifyOk => 'ორივე სხვაობა ერთნაირია, გამოთვლა სწორია';

  @override
  String get chkVerifyBad => 'სხვაობები არ ემთხვევა, გადაამოწმეთ ჩანაწერები';

  @override
  String get chkKnownEnd => 'ბოლო წერტილის ცნობილი სიმაღლე';

  @override
  String get chkError => 'ცდომილება';

  @override
  String chkErrorValue(String calc, String known, String e, String mm) {
    return '$calc (გამოთვლილი) − $known (ცნობილი) = $e მ = $mm მმ';
  }

  @override
  String get chkAllowed => 'დასაშვები ცდომილება';

  @override
  String chkAllowedFormula(String c, String l, String a) {
    return '$c × √$l = $a მმ';
  }

  @override
  String chkAllowedFixed(String a) {
    return '$a მმ (ფიქსირებული)';
  }

  @override
  String get chkConclusion => 'დასკვნა';

  @override
  String get chkConclOk => 'ცდომილება დასაშვებია';

  @override
  String get chkConclBad => 'ცდომილება აჭარბებს დასაშვებს, გაზომვა გაიმეორეთ';

  @override
  String get chkAdjust => 'გასწორება';

  @override
  String chkAdjustValue(String n, String mm) {
    return 'ცდომილება თანაბრად ნაწილდება $n დგომაზე: ყოველ დგომაზე $mm მმ';
  }
}
