import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = '${documentsDirectory.path}/todo_app.db';
    final database = await openDatabase(path,
        version: 2, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  Future<void> initDB(Database database, int version) async {
    await database.execute('CREATE TABLE importanceType ( '
        'id   INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
        'type VARCHAR(10) '
        ')');

    await database.execute('CREATE TABLE tasks ( '
        'id               VARCHAR(100) PRIMARY KEY NOT NULL, '
        'text             TEXT, '
        'importance       INTEGER REFERENCES importanceType(importance), '
        'deadline         INTEGER, '
        'done             INTEGER, '
        'color            TEXT, '
        'created_at       INTEGER, '
        'changed_at       INTEGER, '
        'last_updated_by  TEXT '
        ')');
  }
}
