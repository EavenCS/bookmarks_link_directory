import 'package:hive/hive.dart';

part 'bookmark.g.dart';

@HiveType(typeId: 1)
class Bookmark extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String link;

  @HiveField(2)
  bool isFavorite;

  @HiveField(3)
  List<String> tags;

  Bookmark({
    required this.title,
    required this.link,
    this.isFavorite = false,
    List<String>? tags,
  }) : tags = tags ?? [];
}
