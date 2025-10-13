import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:link_directory/model/bookmark.dart';
import 'package:link_directory/boxes.dart';
import 'package:link_directory/widgets/appbar.dart';

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
    // 🔹 Alle Tags aus gespeicherten Bookmarks ableiten
    final box = Boxes.getBookmarksBox();
    categories = box.values.expand((b) => b.tags).toSet().toList();
    categories.sort();
  }

  void _addCategory(String name) {
    if (name.isEmpty) return;
    if (!categories.contains(name)) {
      setState(() {
        categories.add(name);
        categories.sort();
        selectedValue = name; // 🔹 Neue Kategorie automatisch auswählen
      });
      categoryController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Kategorie '$name' hinzugefügt"),
          backgroundColor: Colors.black87,
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "Neues Bookmark",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Titel (Pflichtfeld)
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Titel *",
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontFamily: "SpaceGrotesk"),
                  ),
                  validator:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? "Titel darf nicht leer sein"
                              : null,
                ),
                const SizedBox(height: 16),

                // 🔹 Link (Pflichtfeld)
                TextFormField(
                  controller: linkController,
                  decoration: const InputDecoration(
                    labelText: "Link *",
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontFamily: "SpaceGrotesk"),
                  ),
                  validator:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? "Link darf nicht leer sein"
                              : null,
                ),
                const SizedBox(height: 20),

                // 🔹 Kategorie Dropdown (aus vorhandenen Bookmarks)
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategorie auswählen",
                    labelStyle: const TextStyle(fontFamily: "SpaceGrotesk"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                  value: selectedValue,
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
                          labelText: "Neue Kategorie hinzufügen",
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
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
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

                // 🔹 Speichern-Button
                Center(
                  child: ElevatedButton(
                    onPressed: _saveBookmark,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 26,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Speichern",
                      style: TextStyle(
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
