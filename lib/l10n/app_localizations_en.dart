// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Bookmarks';

  @override
  String get filter => 'Filter';

  @override
  String get settings => 'Settings';

  @override
  String get noBookmarksFound => 'No bookmarks found.';

  @override
  String linkCopied(String link) {
    return '🔗 Link copied: $link';
  }

  @override
  String get addNewBookmark => 'Add new bookmark';

  @override
  String get filterOptions => 'Filter options';

  @override
  String get showFavoritesOnly => 'Show favorites only';

  @override
  String get selectCategory => 'Select category:';

  @override
  String get all => 'All';

  @override
  String get resetFilters => 'Reset filters';

  @override
  String get editBookmark => 'Edit bookmark';

  @override
  String get title => 'Title';

  @override
  String get link => 'Link';

  @override
  String get category => 'Category';

  @override
  String get none => 'None';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get deleteBookmark => 'Delete bookmark?';

  @override
  String deleteBookmarkMessage(String title) {
    return '\'$title\' will be permanently deleted.';
  }

  @override
  String get delete => 'Delete';

  @override
  String get newBookmark => 'New bookmark';

  @override
  String get titleRequired => 'Title *';

  @override
  String get linkRequired => 'Link *';

  @override
  String get titleEmptyError => 'Title cannot be empty';

  @override
  String get linkEmptyError => 'Link cannot be empty';

  @override
  String get selectCategoryDropdown => 'Select category';

  @override
  String get addNewCategory => 'Add new category';

  @override
  String categoryAdded(String name) {
    return 'Category \'$name\' added';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get categories => 'Categories';

  @override
  String get editOrDeleteCategories => 'Edit or delete existing categories.';

  @override
  String get manageCategories => 'Manage categories';

  @override
  String get aboutApp => 'About the app';

  @override
  String get version => 'Version: 1.0.0';

  @override
  String get developedBy => 'Developed by: Eaven-René Schmalz';

  @override
  String get aboutDeveloper => 'About the developer';

  @override
  String errorInitializingHive(String error) {
    return '❌ Error initializing Hive: $error';
  }

  @override
  String errorStartingApp(String error) {
    return 'Error starting app:\n\n$error';
  }

  @override
  String get manageCategoriesTitle => 'Manage Categories';

  @override
  String get renameCategory => 'Rename Category';

  @override
  String get newName => 'New name';

  @override
  String get deleteCategory => 'Delete category?';

  @override
  String deleteCategoryMessage(String name) {
    return 'The category \'$name\' will be removed from all bookmarks.';
  }

  @override
  String get aboutDeveloperTitle => 'About the Developer';

  @override
  String get aboutDeveloperText =>
      'Hi, I\'m Eaven! I love creating minimalist and thoughtful Flutter apps. This app is a little passion project of mine – thank you for using it!';

  @override
  String get website => 'Website';

  @override
  String get email => 'E-Mail';

  @override
  String get github => 'GitHub';

  @override
  String couldNotOpen(String url) {
    return 'Could not open $url';
  }

  @override
  String get noCategoriesFound => 'No categories found yet.';
}
