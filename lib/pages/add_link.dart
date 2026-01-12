import 'package:flutter/material.dart';
import '../model/bookmark.dart';
import '../model/category.dart';
import '../boxes.dart';
import '../widgets/appbar.dart';
import '../l10n/app_localizations.dart';

class AddLink extends StatefulWidget {
  const AddLink({super.key});

  @override
  State<AddLink> createState() => _AddLinkState();
}

class _AddLinkState extends State<AddLink> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? selectedValue;
  late List<String> categories;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    final categoriesBox = Boxes.getCategoriesBox();
    categories = categoriesBox.values.map((c) => c.name).toList();
    categories.sort();
  }

  void _addCategory(String name) {
    final l10n = AppLocalizations.of(context)!;
    if (name.isEmpty) return;
    if (!categories.contains(name)) {
      // Kategorie persistent speichern
      final categoriesBox = Boxes.getCategoriesBox();
      final category = Category(name: name);
      categoriesBox.add(category);

      setState(() {
        categories.add(name);
        categories.sort();
        selectedValue = name;
      });
      categoryController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.categoryAdded(name)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _saveBookmark() {
    if (!_formKey.currentState!.validate()) return;

    final title = titleController.text.trim();
    final link = linkController.text.trim();

    final bookmark = Bookmark(
      title: title,
      link: link,
      isFavorite: false,
      tags: selectedValue != null ? [selectedValue!] : [],
    );

    final box = Boxes.getBookmarksBox();
    box.add(bookmark);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.newBookmark,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: l10n.titleRequired,
                    border: const OutlineInputBorder(),
                    labelStyle: const TextStyle(fontFamily: "SpaceGrotesk"),
                  ),
                  validator:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? l10n.titleEmptyError
                              : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: linkController,
                  decoration: InputDecoration(
                    labelText: l10n.linkRequired,
                    border: const OutlineInputBorder(),
                    labelStyle: const TextStyle(fontFamily: "SpaceGrotesk"),
                  ),
                  validator:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? l10n.linkEmptyError
                              : null,
                ),
                const SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: l10n.selectCategoryDropdown,
                    labelStyle: const TextStyle(fontFamily: "SpaceGrotesk"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                  initialValue: selectedValue,
                  items:
                      categories
                          .map(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  fontFamily: "SpaceGrotesk",
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (String? newValue) {
                    setState(() => selectedValue = newValue);
                  },
                ),
                const SizedBox(height: 18),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: categoryController,
                        decoration: InputDecoration(
                          labelText: l10n.addNewCategory,
                          labelStyle: const TextStyle(
                            fontFamily: "SpaceGrotesk",
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed:
                          () => _addCategory(categoryController.text.trim()),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.all(16),
                        minimumSize: const Size(50, 50),
                      ),
                      child: const Icon(Icons.add, size: 22),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Center(
                  child: ElevatedButton(
                    onPressed: _saveBookmark,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 26,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      l10n.save,
                      style: const TextStyle(
                        fontFamily: "SpaceGrotesk",
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
