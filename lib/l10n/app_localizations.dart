import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In de, this message translates to:
  /// **'Bookmarks'**
  String get appTitle;

  /// No description provided for @filter.
  ///
  /// In de, this message translates to:
  /// **'Filtern'**
  String get filter;

  /// No description provided for @settings.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get settings;

  /// No description provided for @noBookmarksFound.
  ///
  /// In de, this message translates to:
  /// **'Keine Bookmarks gefunden.'**
  String get noBookmarksFound;

  /// No description provided for @linkCopied.
  ///
  /// In de, this message translates to:
  /// **'🔗 Link kopiert: {link}'**
  String linkCopied(String link);

  /// No description provided for @addNewBookmark.
  ///
  /// In de, this message translates to:
  /// **'Neues Bookmark hinzufügen'**
  String get addNewBookmark;

  /// No description provided for @filterOptions.
  ///
  /// In de, this message translates to:
  /// **'Filteroptionen'**
  String get filterOptions;

  /// No description provided for @showFavoritesOnly.
  ///
  /// In de, this message translates to:
  /// **'Nur Favoriten anzeigen'**
  String get showFavoritesOnly;

  /// No description provided for @selectCategory.
  ///
  /// In de, this message translates to:
  /// **'Kategorie auswählen:'**
  String get selectCategory;

  /// No description provided for @all.
  ///
  /// In de, this message translates to:
  /// **'Alle'**
  String get all;

  /// No description provided for @resetFilters.
  ///
  /// In de, this message translates to:
  /// **'Filter zurücksetzen'**
  String get resetFilters;

  /// No description provided for @editBookmark.
  ///
  /// In de, this message translates to:
  /// **'Bookmark bearbeiten'**
  String get editBookmark;

  /// No description provided for @title.
  ///
  /// In de, this message translates to:
  /// **'Titel'**
  String get title;

  /// No description provided for @link.
  ///
  /// In de, this message translates to:
  /// **'Link'**
  String get link;

  /// No description provided for @category.
  ///
  /// In de, this message translates to:
  /// **'Kategorie'**
  String get category;

  /// No description provided for @none.
  ///
  /// In de, this message translates to:
  /// **'Keine'**
  String get none;

  /// No description provided for @cancel.
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get save;

  /// No description provided for @deleteBookmark.
  ///
  /// In de, this message translates to:
  /// **'Bookmark löschen?'**
  String get deleteBookmark;

  /// No description provided for @deleteBookmarkMessage.
  ///
  /// In de, this message translates to:
  /// **'\'{title}\' wird dauerhaft gelöscht.'**
  String deleteBookmarkMessage(String title);

  /// No description provided for @delete.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get delete;

  /// No description provided for @newBookmark.
  ///
  /// In de, this message translates to:
  /// **'Neues Bookmark'**
  String get newBookmark;

  /// No description provided for @titleRequired.
  ///
  /// In de, this message translates to:
  /// **'Titel *'**
  String get titleRequired;

  /// No description provided for @linkRequired.
  ///
  /// In de, this message translates to:
  /// **'Link *'**
  String get linkRequired;

  /// No description provided for @titleEmptyError.
  ///
  /// In de, this message translates to:
  /// **'Titel darf nicht leer sein'**
  String get titleEmptyError;

  /// No description provided for @linkEmptyError.
  ///
  /// In de, this message translates to:
  /// **'Link darf nicht leer sein'**
  String get linkEmptyError;

  /// No description provided for @selectCategoryDropdown.
  ///
  /// In de, this message translates to:
  /// **'Kategorie auswählen'**
  String get selectCategoryDropdown;

  /// No description provided for @addNewCategory.
  ///
  /// In de, this message translates to:
  /// **'Neue Kategorie hinzufügen'**
  String get addNewCategory;

  /// No description provided for @categoryAdded.
  ///
  /// In de, this message translates to:
  /// **'Kategorie \'{name}\' hinzugefügt'**
  String categoryAdded(String name);

  /// No description provided for @settingsTitle.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get settingsTitle;

  /// No description provided for @categories.
  ///
  /// In de, this message translates to:
  /// **'Kategorien'**
  String get categories;

  /// No description provided for @editOrDeleteCategories.
  ///
  /// In de, this message translates to:
  /// **'Bearbeite oder lösche bestehende Kategorien.'**
  String get editOrDeleteCategories;

  /// No description provided for @manageCategories.
  ///
  /// In de, this message translates to:
  /// **'Kategorien verwalten'**
  String get manageCategories;

  /// No description provided for @aboutApp.
  ///
  /// In de, this message translates to:
  /// **'Über die App'**
  String get aboutApp;

  /// No description provided for @version.
  ///
  /// In de, this message translates to:
  /// **'Version: 1.0.0'**
  String get version;

  /// No description provided for @developedBy.
  ///
  /// In de, this message translates to:
  /// **'Entwickelt von: Eaven-René Schmalz'**
  String get developedBy;

  /// No description provided for @aboutDeveloper.
  ///
  /// In de, this message translates to:
  /// **'Über den Entwickler'**
  String get aboutDeveloper;

  /// No description provided for @errorInitializingHive.
  ///
  /// In de, this message translates to:
  /// **'❌ Fehler beim Initialisieren von Hive: {error}'**
  String errorInitializingHive(String error);

  /// No description provided for @errorStartingApp.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Starten der App:\n\n{error}'**
  String errorStartingApp(String error);

  /// No description provided for @manageCategoriesTitle.
  ///
  /// In de, this message translates to:
  /// **'Kategorien verwalten'**
  String get manageCategoriesTitle;

  /// No description provided for @renameCategory.
  ///
  /// In de, this message translates to:
  /// **'Kategorie umbenennen'**
  String get renameCategory;

  /// No description provided for @newName.
  ///
  /// In de, this message translates to:
  /// **'Neuer Name'**
  String get newName;

  /// No description provided for @deleteCategory.
  ///
  /// In de, this message translates to:
  /// **'Kategorie löschen?'**
  String get deleteCategory;

  /// No description provided for @deleteCategoryMessage.
  ///
  /// In de, this message translates to:
  /// **'Die Kategorie \'{name}\' wird aus allen Bookmarks entfernt.'**
  String deleteCategoryMessage(String name);

  /// No description provided for @aboutDeveloperTitle.
  ///
  /// In de, this message translates to:
  /// **'Über den Entwickler'**
  String get aboutDeveloperTitle;

  /// No description provided for @aboutDeveloperText.
  ///
  /// In de, this message translates to:
  /// **'Hi, ich bin Eaven! Ich entwickle mit Liebe minimalistische und durchdachte Flutter-Apps. Diese App ist ein kleines Herzensprojekt von mir – danke, dass du sie verwendest!'**
  String get aboutDeveloperText;

  /// No description provided for @website.
  ///
  /// In de, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @email.
  ///
  /// In de, this message translates to:
  /// **'E-Mail'**
  String get email;

  /// No description provided for @github.
  ///
  /// In de, this message translates to:
  /// **'GitHub'**
  String get github;

  /// No description provided for @couldNotOpen.
  ///
  /// In de, this message translates to:
  /// **'Konnte {url} nicht öffnen'**
  String couldNotOpen(String url);

  /// No description provided for @noCategoriesFound.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Kategorien gefunden.'**
  String get noCategoriesFound;
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
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
