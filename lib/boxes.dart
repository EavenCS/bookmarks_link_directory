import 'package:link_directory/model/bookmark.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Bookmark> getBookmarksBox() => Hive.box<Bookmark>('bookmarks');
}
