import 'package:dacn/Model/MessageChatting.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQFLiteService {
  static final SQFLiteService instance = SQFLiteService._init();
  static Database? _database;
  String pathDB = "message.db";

  SQFLiteService._init();

  /// Initialize or get the database instance.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(pathDB);
    return _database!;
  }

  /// Initialize the database and create tables.
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,  // Đặt lại phiên bản cơ sở dữ liệu là 1
      onCreate: _createDB,  // Tạo mới bảng trong version 1
    );
  }

  /// Create the table for storing messages.
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE messages (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      sender TEXT NOT NULL,
      message TEXT NOT NULL,
      timestamp TEXT NOT NULL,
      textColor INTEGER NOT NULL,
      backgroundColor INTEGER NOT NULL
    )
  ''');
  }


  /// Add a new message to the database.
  Future<int> addMessage(MessageChatting message) async {
    final db = await database;
    return await db.insert('messages', message.toJson());
  }

  /// Get all messages from the database.
  Future<List<MessageChatting>> getAllMessages() async {
    final db = await database;
    final result = await db.query('messages');
    return result.map((json) => MessageChatting.fromJson(json)).toList();
  }

  /// Get a single message by ID.
  Future<MessageChatting?> getMessageById(int id) async {
    final db = await database;
    final result = await db.query(
      'messages',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return MessageChatting.fromJson(result.first);
    }
    return null;
  }

  /// Clear all messages from the database.
  Future<int> clearMessages() async {
    final db = await database;
    return await db.delete('messages');
  }

  /// Delete the entire database file.
  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, pathDB);
    await deleteDatabase(path);
    _database = null;
  }
}
