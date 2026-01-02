// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Bookmarks';

  @override
  String get filter => 'Filtern';

  @override
  String get settings => 'Einstellungen';

  @override
  String get noBookmarksFound => 'Keine Bookmarks gefunden.';

  @override
  String linkCopied(String link) {
    return '🔗 Link kopiert: $link';
  }

  @override
  String get addNewBookmark => 'Neues Bookmark hinzufügen';

  @override
  String get filterOptions => 'Filteroptionen';

  @override
  String get showFavoritesOnly => 'Nur Favoriten anzeigen';

  @override
  String get selectCategory => 'Kategorie auswählen:';

  @override
  String get all => 'Alle';

  @override
  String get resetFilters => 'Filter zurücksetzen';

  @override
  String get editBookmark => 'Bookmark bearbeiten';

  @override
  String get title => 'Titel';

  @override
  String get link => 'Link';

  @override
  String get category => 'Kategorie';

  @override
  String get none => 'Keine';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Speichern';

  @override
  String get deleteBookmark => 'Bookmark löschen?';

  @override
  String deleteBookmarkMessage(String title) {
    return '\'$title\' wird dauerhaft gelöscht.';
  }

  @override
  String get delete => 'Löschen';

  @override
  String get newBookmark => 'Neues Bookmark';

  @override
  String get titleRequired => 'Titel *';

  @override
  String get linkRequired => 'Link *';

  @override
  String get titleEmptyError => 'Titel darf nicht leer sein';

  @override
  String get linkEmptyError => 'Link darf nicht leer sein';

  @override
  String get selectCategoryDropdown => 'Kategorie auswählen';

  @override
  String get addNewCategory => 'Neue Kategorie hinzufügen';

  @override
  String categoryAdded(String name) {
    return 'Kategorie \'$name\' hinzugefügt';
  }

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get categories => 'Kategorien';

  @override
  String get editOrDeleteCategories =>
      'Bearbeite oder lösche bestehende Kategorien.';

  @override
  String get manageCategories => 'Kategorien verwalten';

  @override
  String get aboutApp => 'Über die App';

  @override
  String get version => 'Version: 1.0.0';

  @override
  String get developedBy => 'Entwickelt von: Eaven-René Schmalz';

  @override
  String get aboutDeveloper => 'Über den Entwickler';

  @override
  String errorInitializingHive(String error) {
    return '❌ Fehler beim Initialisieren von Hive: $error';
  }

  @override
  String errorStartingApp(String error) {
    return 'Fehler beim Starten der App:\n\n$error';
  }
}
