import 'package:hive/hive.dart';
import 'model/bookmark.dart';
import 'model/category.dart';
import 'model/settings.dart';

class Boxes {
  static Box<Bookmark> getBookmarksBox() {
    return Hive.box<Bookmark>('bookmarks');
  }

  static Box<Category> getCategoriesBox() {
    return Hive.box<Category>('categories');
  }

  static Box<Settings> getSettingsBox() {
    return Hive.box<Settings>('settings');
  }
}
