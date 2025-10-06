import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:link_directory/boxes.dart';
import 'package:link_directory/model/bookmark.dart';
import 'package:link_directory/pages/add_link.dart';
import 'package:link_directory/pages/settings.dart';
import 'package:flutter/services.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  void addBookmark(String title, String link, bool isFavorite) {
    final bookmark = Bookmark(title: title, link: link, isFavorite: isFavorite);
    final box = Boxes.getBookmarksBox();
    box.add(bookmark);
  }

  /// Gibt dir alle Favoriten zurück (für Debug oder Filter-Ansicht)
  void readData() {
    final box = Boxes.getBookmarksBox();
    final favorites = box.values.where((b) => b.isFavorite).toList();
    debugPrint("Favoriten:");
    for (var fav in favorites) {
      debugPrint("⭐ ${fav.title} - ${fav.link}");
    }
  }

  void deleteData() {
    final box = Boxes.getBookmarksBox();
    if (box.isNotEmpty) {
      box.deleteAt(0);
    }
  }

  @override
  void dispose() {
    Hive.box<Bookmark>('bookmarks').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bookmarks",
          style: TextStyle(
            fontFamily: "SpaceGrotesk",
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Open Settings',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (context) => const Settings()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<Box<Bookmark>>(
              valueListenable: Boxes.getBookmarksBox().listenable(),
              builder: (context, box, _) {
                final bookmarks = box.values.toList().cast<Bookmark>();

                if (bookmarks.isEmpty) {
                  return const Center(
                    child: Text(
                      "Keine Bookmarks vorhanden.",
                      style: TextStyle(
                        fontFamily: "SpaceGrotesk",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: bookmarks.length,
                  itemBuilder: (context, index) {
                    final bookmark = bookmarks[index];

                    return Dismissible(
                      key: Key(bookmark.key.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        bookmark.delete();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("'${bookmark.title}' gelöscht"),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(bookmark.title),
                        subtitle: Text(bookmark.link),
                        trailing: IconButton(
                          icon: Icon(
                            bookmark.isFavorite
                                ? Icons.star
                                : Icons.star_border,
                            color: bookmark.isFavorite ? Colors.amber : null,
                          ),
                          onPressed: () {
                            setState(() {
                              bookmark.isFavorite = !bookmark.isFavorite;
                              bookmark.save();
                            });
                          },
                        ),
                        onTap: () async {
                          await Clipboard.setData(
                            ClipboardData(text: bookmark.link),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "🔗 Link kopiert: ${bookmark.link}",
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (context) => const AddLink()),
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Neues Bookmark hinzufügen',
      ),
    );
  }
}
