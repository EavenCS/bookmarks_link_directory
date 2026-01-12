import 'package:hive/hive.dart';
import 'model/bookmark.dart';
import 'model/category.dart';

class Boxes {
  static Box<Bookmark> getBookmarksBox() {
    return Hive.box<Bookmark>('bookmarks');
  }

  static Box<Category> getCategoriesBox() {
    return Hive.box<Category>('categories');
  }
}
