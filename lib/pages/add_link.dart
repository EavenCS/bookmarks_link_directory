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
  // Controller definieren
  final TextEditingController titleController = TextEditingController();
  final TextEditingController linkController = TextEditingController();

  void saveBookmark() {
    final title = titleController.text;
    final link = linkController.text;

    if (title.isEmpty) {
      HapticFeedback.vibrate();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Bitte einen Titel eingeben",
            style: TextStyle(
              fontFamily: "SpaceGrotesk",
              fontWeight: FontWeight.w700,
            ),
          ),
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
    final bookmark = Bookmark(title: title, link: link, isFavorite: isFavorite);
    final box = Boxes.getBookmarksBox();
    box.add(bookmark);
  }

  @override
  void dispose() {
    titleController.dispose();
    linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFF9F1F1),
      appBar: AppBar(
        title: const Text("Add Bookmark"),
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addBookmarkTextField("Titel", titleController),
            addBookmarkTextField("Link", linkController),
            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: saveBookmark,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                    212,
                    255,
                    255,
                    255,
                  ), // Hintergrundfarbe
                  foregroundColor: Colors.black,
                  side: const BorderSide(
                    color: Color.fromARGB(255, 230, 230, 230), // Rahmenfarbe
                    width: 1, // Rahmenbreite
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    // Optional: Innenabstand
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  "Speichern",
                  style: TextStyle(
                    fontFamily: "SpaceGrotesk",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
