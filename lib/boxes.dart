import 'package:hive/hive.dart';
import 'package:link_directory/model/bookmark.dart';

class Boxes {
  static Box<Bookmark> getBookmarksBox() => Hive.box<Bookmark>('bookmarks');
}
