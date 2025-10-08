import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:link_directory/model/bookmark.dart';
import 'package:link_directory/homepage.dart';
import 'package:link_directory/boxes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final appDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDir.path);

    Hive.registerAdapter(BookmarkAdapter());

    await Hive.openBox<Bookmark>('bookmarks');

    final box = Hive.box<Bookmark>('bookmarks');
    for (var b in box.values) {
      if (b.tags == null) {
        b.tags = [];
        await b.save();
      }
    }

    runApp(const MyApp());
  } catch (e, stackTrace) {
    debugPrint("❌ Fehler beim Initialisieren von Hive: $e");
    debugPrint("StackTrace: $stackTrace");

    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Fehler beim Starten der App:\n\n$e",
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Link Directory',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}
