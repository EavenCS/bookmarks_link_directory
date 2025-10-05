import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:link_directory/model/bookmark.dart';
import 'package:link_directory/homepage.dart'; // <- hier ist MyWidget drin

void main() async {
  // Flutter Engine initialisieren
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Hive mit explizitem Pfad initialisieren (wichtig für iOS)
    final appDocumentDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);

    // Hive Adapter registrieren
    Hive.registerAdapter(BookmarkAdapter());

    // Box öffnen
    await Hive.openBox<Bookmark>("bookmarks");

    // App starten
    runApp(const MyApp());
  } catch (e, stackTrace) {
    // Falls Hive-Initialisierung fehlschlägt, zeige Fehler
    debugPrint("Fehler beim Initialisieren von Hive: $e");
    debugPrint("StackTrace: $stackTrace");
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
      home: const MyWidget(),
    );
  }
}
