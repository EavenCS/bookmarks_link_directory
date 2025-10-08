import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';
import 'package:link_directory/boxes.dart';
import 'package:link_directory/model/bookmark.dart';
import 'package:link_directory/pages/add_link.dart';
import 'package:link_directory/pages/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCategory;
  bool showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        title: const Text(
          "Bookmarks",
          style: TextStyle(
            fontFamily: "SpaceGrotesk",
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // 🔹 Filter (bleibt schwarz, auch bei Favoritenfilter)
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: selectedCategory != null ? Colors.amber : Colors.black,
            ),
            tooltip: "Filtern",
            onPressed: () => _showFilterOptions(context),
          ),

          // 🔹 Einstellungen
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: "Einstellungen",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Settings()),
              );
            },
          ),
        ],
      ),

      // 🔹 Inhalt
      body: ValueListenableBuilder<Box<Bookmark>>(
        valueListenable: Boxes.getBookmarksBox().listenable(),
        builder: (context, box, _) {
          final bookmarks = box.values.toList().cast<Bookmark>();

          final allCategories =
              bookmarks.expand((b) => b.tags).toSet().toList();

          final filtered =
              bookmarks.where((b) {
                final matchesCategory =
                    selectedCategory == null ||
                    b.tags.contains(selectedCategory);
                final matchesFav = !showFavoritesOnly || b.isFavorite;
                return matchesCategory && matchesFav;
              }).toList();

          if (filtered.isEmpty) {
            return const Center(
              child: Text(
                "Keine Bookmarks gefunden.",
                style: TextStyle(
                  fontFamily: "SpaceGrotesk",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            );
          }

          return ListView.separated(
            itemCount: filtered.length,
            separatorBuilder:
                (context, index) => const Divider(
                  height: 1,
                  color: Color(0xFFE5E5E5),
                  indent: 16,
                  endIndent: 16,
                ),
            itemBuilder: (context, index) {
              final b = filtered[index];

              return Slidable(
                key: ValueKey(b.key),

                // Swipe nach rechts → Favorit
                startActionPane: ActionPane(
                  motion: const BehindMotion(),
                  extentRatio: 0.22,
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        HapticFeedback.mediumImpact();
                        setState(() {
                          b.isFavorite = !b.isFavorite;
                          b.save();
                        });
                      },
                      backgroundColor: Colors.amber.withOpacity(0.1),
                      foregroundColor: Colors.amber.shade800,
                      icon: b.isFavorite ? Icons.star_border : Icons.star,
                    ),
                  ],
                ),

                // Swipe nach links → Bearbeiten / Löschen
                endActionPane: ActionPane(
                  motion: const BehindMotion(),
                  extentRatio: 0.4,
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        HapticFeedback.selectionClick();
                        _editBookmark(b);
                      },
                      backgroundColor: Colors.blueAccent.withOpacity(0.1),
                      foregroundColor: Colors.blueAccent,
                      icon: Icons.edit,
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        HapticFeedback.heavyImpact();
                        _confirmDelete(b);
                      },
                      backgroundColor: Colors.redAccent.withOpacity(0.1),
                      foregroundColor: Colors.redAccent,
                      icon: Icons.delete,
                    ),
                  ],
                ),

                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  title: Text(
                    b.title,
                    style: const TextStyle(
                      fontFamily: "SpaceGrotesk",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        b.link,
                        style: const TextStyle(
                          fontFamily: "SpaceGrotesk",
                          color: Colors.blueGrey,
                          fontSize: 13,
                        ),
                      ),
                      if (b.tags.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            "#${b.tags.first}",
                            style: const TextStyle(
                              fontFamily: "SpaceGrotesk",
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      b.isFavorite ? Icons.star : Icons.star_border,
                      color: b.isFavorite ? Colors.amber : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        b.isFavorite = !b.isFavorite;
                        b.save();
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),

      // 🔹 Add Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddLink()),
          );
        },
        tooltip: 'Neues Bookmark hinzufügen',
        child: const Icon(Icons.add),
      ),
    );
  }

  // 🔸 Filter-Optionen unten im ModalSheet
  void _showFilterOptions(BuildContext context) {
    final box = Boxes.getBookmarksBox();
    final allCategories = box.values.expand((b) => b.tags).toSet().toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Filteroptionen",
                  style: TextStyle(
                    fontFamily: "SpaceGrotesk",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // ✅ Lokaler State für flüssige Animation
                StatefulBuilder(
                  builder: (context, setInnerState) {
                    return SwitchListTile(
                      title: const Text(
                        "Nur Favoriten anzeigen",
                        style: TextStyle(fontFamily: "SpaceGrotesk"),
                      ),
                      value: showFavoritesOnly,
                      onChanged: (val) {
                        setInnerState(() => showFavoritesOnly = val);
                        setState(() => showFavoritesOnly = val);
                      },
                    );
                  },
                ),
                const Divider(),

                const Text(
                  "Kategorie auswählen:",
                  style: TextStyle(
                    fontFamily: "SpaceGrotesk",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),

                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  hint: const Text(
                    "Alle",
                    style: TextStyle(fontFamily: "SpaceGrotesk"),
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text(
                        "Alle",
                        style: TextStyle(fontFamily: "SpaceGrotesk"),
                      ),
                    ),
                    ...allCategories.map(
                      (c) => DropdownMenuItem(
                        value: c,
                        child: Text(
                          c,
                          style: const TextStyle(fontFamily: "SpaceGrotesk"),
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() => selectedCategory = value);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.clear),
                    label: const Text(
                      "Filter zurücksetzen",
                      style: TextStyle(fontFamily: "SpaceGrotesk"),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedCategory = null;
                        showFavoritesOnly = false;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 🔹 Bearbeiten-Dialog mit modernem Kategorie-Selector
  void _editBookmark(Bookmark b) {
    final titleController = TextEditingController(text: b.title);
    final linkController = TextEditingController(text: b.link);
    final allCategories =
        Boxes.getBookmarksBox().values.expand((b) => b.tags).toSet().toList();

    String? selectedCategory = b.tags.isNotEmpty ? b.tags.first : null;

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text(
              "Bookmark bearbeiten",
              style: TextStyle(
                fontFamily: "SpaceGrotesk",
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Titel",
                    labelStyle: TextStyle(fontFamily: "SpaceGrotesk"),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: linkController,
                  decoration: const InputDecoration(
                    labelText: "Link",
                    labelStyle: TextStyle(fontFamily: "SpaceGrotesk"),
                  ),
                ),
                const SizedBox(height: 10),

                // 🔹 Kategorie-Button im TextField-Stil
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    _showCategorySelector(
                      context,
                      allCategories,
                      selectedCategory,
                      (val) => selectedCategory = val,
                    );
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Kategorie",
                        labelStyle: const TextStyle(fontFamily: "SpaceGrotesk"),
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                        border: const OutlineInputBorder(),
                        hintText: selectedCategory ?? "Keine",
                      ),
                      controller: TextEditingController(
                        text: selectedCategory ?? "",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Abbrechen",
                  style: TextStyle(fontFamily: "SpaceGrotesk"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    b.title = titleController.text.trim();
                    b.link = linkController.text.trim();
                    b.tags =
                        selectedCategory != null ? [selectedCategory!] : [];
                    b.save();
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "Speichern",
                  style: TextStyle(fontFamily: "SpaceGrotesk"),
                ),
              ),
            ],
          ),
    );
  }

  // 🔹 Kategorieauswahl im BottomSheet
  void _showCategorySelector(
    BuildContext context,
    List<String> allCategories,
    String? selectedCategory,
    Function(String?) onSelect,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Kategorie auswählen",
                  style: TextStyle(
                    fontFamily: "SpaceGrotesk",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text(
                  "Keine",
                  style: TextStyle(fontFamily: "SpaceGrotesk"),
                ),
                onTap: () {
                  onSelect(null);
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              ...allCategories.map(
                (c) => ListTile(
                  title: Text(
                    c,
                    style: const TextStyle(fontFamily: "SpaceGrotesk"),
                  ),
                  trailing:
                      c == selectedCategory
                          ? const Icon(Icons.check, color: Colors.black)
                          : null,
                  onTap: () {
                    onSelect(c);
                    Navigator.pop(context);
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 🔹 Löschen mit Bestätigung
  void _confirmDelete(Bookmark b) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text(
              "Bookmark löschen?",
              style: TextStyle(fontFamily: "SpaceGrotesk"),
            ),
            content: Text(
              "'${b.title}' wird dauerhaft gelöscht.",
              style: const TextStyle(fontFamily: "SpaceGrotesk"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Abbrechen",
                  style: TextStyle(fontFamily: "SpaceGrotesk"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  HapticFeedback.heavyImpact();
                  setState(() => b.delete());
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "Löschen",
                  style: TextStyle(fontFamily: "SpaceGrotesk"),
                ),
              ),
            ],
          ),
    );
  }
}
