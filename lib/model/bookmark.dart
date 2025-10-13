import 'package:hive/hive.dart';

part 'bookmark.g.dart';

@HiveType(typeId: 0)
class Bookmark extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String link;

  @HiveField(2)
  late bool isFavorite;

  @HiveField(3)
  late List<String> tags;

  Bookmark({
    required this.title,
    required this.link,
    required this.isFavorite,
    required this.tags,
  });
}
