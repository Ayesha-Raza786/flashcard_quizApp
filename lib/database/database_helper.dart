import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/flashcard_app_model.dart';
class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'flashcards.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE flashcards(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT NOT NULL,
        answer TEXT NOT NULL,
        tag TEXT NOT NULL
      )
    ''');
  }
  Future<int> insertFlashcard(Flashcard flashcard) async {
    final db = await database;

    return await db.insert(
      'flashcards',
      flashcard.toMap(),
    );
  }
//read all
  Future<List<Flashcard>> getFlashcards() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
    await db.query('flashcards');

    return List.generate(
      maps.length,
          (i) => Flashcard.fromMap(maps[i]),
    );
  }
// update
  Future<int> updateFlashcard(Flashcard flashcard) async {
    final db = await database;

    return await db.update(
      'flashcards',
      flashcard.toMap(),
      where: 'id = ?',
      whereArgs: [flashcard.id],
    );
  }
//delete
  Future<int> deleteFlashcard(int id) async {
    final db = await database;

    return await db.delete(
      'flashcards',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
// insert all
