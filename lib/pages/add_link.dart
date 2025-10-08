import 'package:flutter/material.dart';
import 'package:link_directory/widgets/textField.dart';
import 'package:link_directory/model/bookmark.dart';
import 'package:link_directory/boxes.dart';
import 'package:flutter/services.dart';

class AddLink extends StatefulWidget {
  const AddLink({super.key});

  @override
  State<AddLink> createState() => _AddLinkState();
}

class _AddLinkState extends State<AddLink> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  // 🔹 Kategorien nur lokal im Speicher
  List<String> categories = ['Dart', 'Flutter', 'News', 'Tutorial'];
  String? selectedValue;

  void addCategory(String name) {
    if (name.isEmpty) return;
    if (!categories.contains(name)) {
      setState(() {
        categories.add(name);
      });
      categoryController.clear();
    }
  }

  void saveBookmark() {
    final title = titleController.text.trim();
    final link = linkController.text.trim();

    if (title.isEmpty) {
      HapticFeedback.vibrate();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Bitte einen Titel eingeben"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    addBookmark(title, link, false);
    Navigator.pop(context);
  }

  void addBookmark(String title, String link, bool isFavorite) {
    final bookmark = Bookmark(
      title: title,
      link: link,
      isFavorite: isFavorite,
      tags: selectedValue != null ? [selectedValue!] : [],
    );

    final box = Boxes.getBookmarksBox();
    box.add(bookmark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Bookmark"),
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addBookmarkTextField("Titel", titleController),
              addBookmarkTextField("Link", linkController),
              const SizedBox(height: 20),

              // Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Kategorie auswählen",
                  filled: true,
                  fillColor: Colors.white54,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                dropdownColor: Colors.white,
                value: selectedValue,
                items:
                    categories
                        .map(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
              ),
              const SizedBox(height: 15),

              // Neue Kategorie hinzufügen
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: categoryController,
                      decoration: const InputDecoration(
                        labelText: "Neue Kategorie",
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed:
                        () => addCategory(categoryController.text.trim()),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              Center(
                child: ElevatedButton(
                  onPressed: saveBookmark,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    "Speichern",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
