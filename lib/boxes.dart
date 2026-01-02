import 'package:hive/hive.dart';
import 'model/bookmark.dart';

class Boxes {
  static Box<Bookmark> getBookmarksBox() {
    return Hive.box<Bookmark>('bookmarks');
  }
}
