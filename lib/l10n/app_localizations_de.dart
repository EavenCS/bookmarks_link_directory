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
  String get appearance => 'Erscheinungsbild';

  @override
  String get darkMode => 'Dunkler Modus';

  @override
  String get darkModeDescription => 'Dunkles Design für die App aktivieren';

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
  String get version => 'Version: 1.0.1';

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

  @override
  String get manageCategoriesTitle => 'Kategorien verwalten';

  @override
  String get renameCategory => 'Kategorie umbenennen';

  @override
  String get newName => 'Neuer Name';

  @override
  String get deleteCategory => 'Kategorie löschen?';

  @override
  String deleteCategoryMessage(String name) {
    return 'Die Kategorie \'$name\' wird aus allen Bookmarks entfernt.';
  }

  @override
  String get aboutDeveloperTitle => 'Über den Entwickler';

  @override
  String get aboutDeveloperText =>
      'Hi, ich bin Eaven! Ich entwickle mit Liebe minimalistische und durchdachte Flutter-Apps. Diese App ist ein kleines Herzensprojekt von mir – danke, dass du sie verwendest!';

  @override
  String get website => 'Website';

  @override
  String get email => 'E-Mail';

  @override
  String get github => 'GitHub';

  @override
  String couldNotOpen(String url) {
    return 'Konnte $url nicht öffnen';
  }

  @override
  String get noCategoriesFound => 'Noch keine Kategorien gefunden.';

  @override
  String get impressumTitle => 'Impressum';

  @override
  String get impressumSubtitle => 'Angaben gemäß § 5 DDG';

  @override
  String get impressumProviderLabel => 'Anbieter';

  @override
  String get impressumRepresentedBy => 'Vertreten durch';

  @override
  String get impressumContact => 'Kontakt';

  @override
  String get impressumPhone => 'Telefon';

  @override
  String get impressumDisputeResolutionTitle =>
      'Verbraucherstreitbeilegung / Universalschlichtungsstelle';

  @override
  String get impressumDisputeResolutionText =>
      'Wir nehmen nicht an Streitbeilegungsverfahren vor einer Verbraucherschlichtungsstelle teil und sind dazu auch nicht verpflichtet.';

  @override
  String get impressumPrivacyPolicyTitle => 'Datenschutzerklärung';

  @override
  String get impressumPrivacyPolicyLink => 'Datenschutzerklärung ansehen';

  @override
  String get impressumGeneratedWith =>
      'Erstellt mit Impressum-Generator.de, dem Tool für Impressum und Datenschutz-Erklärung. Nach einer Vorlage der Kanzlei Hasselbach.';
}
