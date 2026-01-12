import 'package:flutter/material.dart';
import '../boxes.dart';
import '../widgets/appbar.dart';
import '../l10n/app_localizations.dart';

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
    categories = box.values.expand((b) => b.tags).toSet().toList();
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
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: oldName);
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(
              l10n.renameCategory,
              style: const TextStyle(fontFamily: "SpaceGrotesk"),
            ),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(labelText: l10n.newName),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.cancel),
              ),
              ElevatedButton(
                onPressed: () {
                  final newName = controller.text.trim();
                  if (newName.isNotEmpty && newName != oldName) {
                    _renameCategory(oldName, newName);
                  }
                  Navigator.pop(context);
                },
                child: Text(l10n.save),
              ),
            ],
          ),
    );
  }

  void _confirmDelete(String name) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(l10n.deleteCategory),
            content: Text(l10n.deleteCategoryMessage(name)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.cancel),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  _deleteCategory(name);
                  Navigator.pop(context);
                },
                child: Text(l10n.delete),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: l10n.manageCategoriesTitle),
      body: categories.isEmpty
          ? Center(
              child: Text(
                l10n.noCategoriesFound,
                style: const TextStyle(
                  fontFamily: "SpaceGrotesk",
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final name = categories[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                          icon:
                              const Icon(Icons.edit, color: Colors.blueAccent),
                          onPressed: () => _showRenameDialog(name),
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.delete, color: Colors.redAccent),
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
