import 'package:flutter/material.dart';
import 'package:link_directory/boxes.dart';
import 'package:link_directory/model/bookmark.dart';

class ManageCategoriesPage extends StatefulWidget {
  const ManageCategoriesPage({super.key});

  @override
  State<ManageCategoriesPage> createState() => _ManageCategoriesPageState();
}

class _ManageCategoriesPageState extends State<ManageCategoriesPage> {
  late List<String> categories;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    final box = Boxes.getBookmarksBox();
    categories =
        box.values.expand((b) => b.tags).toSet().toList(); // doppelte entfernen
  }

  void _renameCategory(String oldName, String newName) {
    final box = Boxes.getBookmarksBox();
    for (final bookmark in box.values) {
      if (bookmark.tags.contains(oldName)) {
        final newTags =
            List<String>.from(bookmark.tags)
              ..remove(oldName)
              ..add(newName);
        bookmark.tags = newTags;
        bookmark.save();
      }
    }
    setState(() {
      categories[categories.indexOf(oldName)] = newName;
    });
  }

  void _deleteCategory(String name) {
    final box = Boxes.getBookmarksBox();
    for (final bookmark in box.values) {
      if (bookmark.tags.contains(name)) {
        bookmark.tags.remove(name);
        bookmark.save();
      }
    }
    setState(() {
      categories.remove(name);
    });
  }

  void _showRenameDialog(String oldName) {
    final controller = TextEditingController(text: oldName);
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text(
              "Kategorie umbenennen",
              style: TextStyle(fontFamily: "SpaceGrotesk"),
            ),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: "Neuer Name"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Abbrechen"),
              ),
              ElevatedButton(
                onPressed: () {
                  final newName = controller.text.trim();
                  if (newName.isNotEmpty && newName != oldName) {
                    _renameCategory(oldName, newName);
                  }
                  Navigator.pop(context);
                },
                child: const Text("Speichern"),
              ),
            ],
          ),
    );
  }

  void _confirmDelete(String name) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Kategorie löschen?"),
            content: Text(
              "Die Kategorie '$name' wird aus allen Bookmarks entfernt.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Abbrechen"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  _deleteCategory(name);
                  Navigator.pop(context);
                },
                child: const Text("Löschen"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kategorien verwalten",
          style: TextStyle(fontFamily: "SpaceGrotesk"),
        ),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final name = categories[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(
                name,
                style: const TextStyle(
                  fontFamily: "SpaceGrotesk",
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blueAccent),
                    onPressed: () => _showRenameDialog(name),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => _confirmDelete(name),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
