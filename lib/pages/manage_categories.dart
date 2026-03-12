import 'package:flutter/material.dart';
import '../boxes.dart';
import '../widgets/appbar.dart';
import '../l10n/app_localizations.dart';
import '../model/category.dart';

class ManageCategoriesPage extends StatefulWidget {
  const ManageCategoriesPage({super.key});

  @override
  State<ManageCategoriesPage> createState() => _ManageCategoriesPageState();
}

class _ManageCategoriesPageState extends State<ManageCategoriesPage> {
  late List<String> categories;
  late Map<String, int> categoryBookmarkCounts;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    final categoriesBox = Boxes.getCategoriesBox();
    categories = categoriesBox.values.map((c) => c.name).toList();
    categories.sort();
    _calculateBookmarkCounts();
  }

  void _calculateBookmarkCounts() {
    categoryBookmarkCounts = {};
    final bookmarksBox = Boxes.getBookmarksBox();

    for (final category in categories) {
      int count = 0;
      for (final bookmark in bookmarksBox.values) {
        if (bookmark.tags.contains(category)) {
          count++;
        }
      }
      categoryBookmarkCounts[category] = count;
    }
  }

  void _addNewCategory(String name) {
    final l10n = AppLocalizations.of(context)!;

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.categoryNameEmpty),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (categories.contains(name)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.categoryAlreadyExists(name)),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final categoriesBox = Boxes.getCategoriesBox();
    final category = Category(name: name);
    categoriesBox.add(category);

    setState(() {
      categories.add(name);
      categories.sort();
      categoryBookmarkCounts[name] = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.categoryAdded(name)),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _renameCategory(String oldName, String newName) {
    // Kategorie in der Kategorien-Box umbenennen
    final categoriesBox = Boxes.getCategoriesBox();
    final categoryToRename = categoriesBox.values.firstWhere(
      (c) => c.name == oldName,
    );
    categoryToRename.name = newName;
    categoryToRename.save();

    // Auch in allen Bookmarks umbenennen
    final bookmarksBox = Boxes.getBookmarksBox();
    for (final bookmark in bookmarksBox.values) {
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
      final index = categories.indexOf(oldName);
      final count = categoryBookmarkCounts[oldName] ?? 0;
      categories[index] = newName;
      categoryBookmarkCounts.remove(oldName);
      categoryBookmarkCounts[newName] = count;
    });
  }

  void _deleteCategory(String name) {
    // Kategorie aus der Kategorien-Box löschen
    final categoriesBox = Boxes.getCategoriesBox();
    final categoryToDelete = categoriesBox.values.firstWhere(
      (c) => c.name == name,
    );
    categoryToDelete.delete();

    // Auch aus allen Bookmarks entfernen
    final bookmarksBox = Boxes.getBookmarksBox();
    for (final bookmark in bookmarksBox.values) {
      if (bookmark.tags.contains(name)) {
        bookmark.tags.remove(name);
        bookmark.save();
      }
    }

    setState(() {
      categories.remove(name);
      categoryBookmarkCounts.remove(name);
    });
  }

  void _showAddCategoryDialog() {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(
              l10n.addNewCategory,
              style: const TextStyle(fontFamily: "SpaceGrotesk"),
            ),
            content: TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                labelText: l10n.categoryName,
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                final name = value.trim();
                _addNewCategory(name);
                Navigator.pop(dialogContext);
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(l10n.cancel),
              ),
              ElevatedButton(
                onPressed: () {
                  final name = controller.text.trim();
                  _addNewCategory(name);
                  Navigator.pop(dialogContext);
                },
                child: Text(l10n.add),
              ),
            ],
          ),
    );
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
      appBar: CustomAppBar(title: l10n.manageCategoriesTitle),
      body:
          categories.isEmpty
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
                  final count = categoryBookmarkCounts[name] ?? 0;
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      title: Text(
                        name,
                        style: const TextStyle(
                          fontFamily: "SpaceGrotesk",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        '$count Bookmark${count != 1 ? 's' : ''}',
                        style: const TextStyle(
                          fontFamily: "SpaceGrotesk",
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () => _showRenameDialog(name),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => _confirmDelete(name),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCategoryDialog,
        tooltip: l10n.addNewCategory,
        child: const Icon(Icons.add),
      ),
    );
  }
}
