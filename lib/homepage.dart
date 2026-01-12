import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';
import 'boxes.dart';
import 'model/bookmark.dart';
import 'pages/add_link.dart';
import 'pages/settings.dart';
import 'widgets/appbar.dart';
import 'l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: l10n.appTitle,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            tooltip: l10n.filter,
            onPressed: () => _showFilterOptions(context),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: l10n.settings,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Settings()),
              );
            },
          ),
        ],
      ),

      body: ValueListenableBuilder<Box<Bookmark>>(
        valueListenable: Boxes.getBookmarksBox().listenable(),
        builder: (context, box, _) {
          final bookmarks = box.values.toList().cast<Bookmark>();

          final filtered =
              bookmarks.where((b) {
                final matchesCategory =
                    selectedCategory == null ||
                    b.tags.contains(selectedCategory);
                final matchesFav = !showFavoritesOnly || b.isFavorite;
                return matchesCategory && matchesFav;
              }).toList();

          if (filtered.isEmpty) {
            return Center(
              child: Text(
                l10n.noBookmarksFound,
                style: const TextStyle(
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
                      backgroundColor: Colors.amber.withValues(alpha: 0.1),
                      foregroundColor: Colors.amber.shade800,
                      icon: b.isFavorite ? Icons.star_border : Icons.star,
                    ),
                  ],
                ),

                endActionPane: ActionPane(
                  motion: const BehindMotion(),
                  extentRatio: 0.4,
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        HapticFeedback.selectionClick();
                        _editBookmark(b);
                      },
                      backgroundColor: Colors.blueAccent.withValues(alpha: 0.1),
                      foregroundColor: Colors.blueAccent,
                      icon: Icons.edit,
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        HapticFeedback.heavyImpact();
                        _confirmDelete(b);
                      },
                      backgroundColor: Colors.redAccent.withValues(alpha: 0.1),
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

                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: b.link));
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.linkCopied(b.link)),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),

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
        tooltip: l10n.addNewBookmark,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
          child: StatefulBuilder(
            builder: (context, setInnerState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.filterOptions,
                    style: const TextStyle(
                      fontFamily: "SpaceGrotesk",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  SwitchListTile(
                    title: Text(
                      l10n.showFavoritesOnly,
                      style: const TextStyle(fontFamily: "SpaceGrotesk"),
                    ),
                    value: showFavoritesOnly,
                    onChanged: (val) {
                      setInnerState(() => showFavoritesOnly = val);
                      setState(() => showFavoritesOnly = val);
                    },
                  ),

                  const Divider(),
                  Text(
                    l10n.selectCategory,
                    style: const TextStyle(
                      fontFamily: "SpaceGrotesk",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),

                  DropdownButtonFormField<String>(
                    initialValue: selectedCategory,
                    hint: Text(
                      l10n.all,
                      style: const TextStyle(fontFamily: "SpaceGrotesk"),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: null,
                        child: Text(
                          l10n.all,
                          style: const TextStyle(fontFamily: "SpaceGrotesk"),
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
                      label: Text(
                        l10n.resetFilters,
                        style: const TextStyle(fontFamily: "SpaceGrotesk"),
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
              );
            },
          ),
        );
      },
    );
  }

  void _editBookmark(Bookmark b) {
    final l10n = AppLocalizations.of(context)!;
    final titleController = TextEditingController(text: b.title);
    final linkController = TextEditingController(text: b.link);
    final allCategories =
        Boxes.getBookmarksBox().values.expand((b) => b.tags).toSet().toList();

    String? selectedCategory = b.tags.isNotEmpty ? b.tags.first : null;

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(
              l10n.editBookmark,
              style: const TextStyle(
                fontFamily: "SpaceGrotesk",
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: l10n.title,
                    labelStyle: const TextStyle(fontFamily: "SpaceGrotesk"),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: linkController,
                  decoration: InputDecoration(
                    labelText: l10n.link,
                    labelStyle: const TextStyle(fontFamily: "SpaceGrotesk"),
                  ),
                ),
                const SizedBox(height: 10),

                // Kategorie im TextField-Stil
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
                        labelText: l10n.category,
                        labelStyle: const TextStyle(fontFamily: "SpaceGrotesk"),
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                        border: const OutlineInputBorder(),
                        hintText: selectedCategory ?? l10n.none,
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
                child: Text(
                  l10n.cancel,
                  style: const TextStyle(fontFamily: "SpaceGrotesk"),
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
                child: Text(
                  l10n.save,
                  style: const TextStyle(fontFamily: "SpaceGrotesk"),
                ),
              ),
            ],
          ),
    );
  }

  void _showCategorySelector(
    BuildContext context,
    List<String> allCategories,
    String? selectedCategory,
    Function(String?) onSelect,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  l10n.selectCategoryDropdown,
                  style: const TextStyle(
                    fontFamily: "SpaceGrotesk",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const Divider(height: 1),
              ListTile(
                title: Text(
                  l10n.none,
                  style: const TextStyle(fontFamily: "SpaceGrotesk"),
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

  void _confirmDelete(Bookmark b) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(
              l10n.deleteBookmark,
              style: const TextStyle(fontFamily: "SpaceGrotesk"),
            ),
            content: Text(
              l10n.deleteBookmarkMessage(b.title),
              style: const TextStyle(fontFamily: "SpaceGrotesk"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  l10n.cancel,
                  style: const TextStyle(fontFamily: "SpaceGrotesk"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  HapticFeedback.heavyImpact();

                  final box = Boxes.getBookmarksBox();
                  box.delete(b.key);

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  l10n.delete,
                  style: const TextStyle(fontFamily: "SpaceGrotesk"),
                ),
              ),
            ],
          ),
    );
  }
}
