//import 'dart:io';
import 'package:flutter_registration_app/models/profile.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ImagesDB {
  static final ImagesDB _imagesDB = ImagesDB._internal();
  factory ImagesDB() => _imagesDB;

  static Database? _database;

  ImagesDB._internal();

  String profilesTable = 'profiles';
  String colId = 'id';
  String colFirstName = 'firstName';
  String colLastName = 'lastName';
  String colEmail = 'email';
  String colImageRef = 'imageRef';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'profiles.db');
    final profilesDb = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return profilesDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $profilesTable(
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colFirstName TEXT,
        $colLastName TEXT,
        $colEmail TEXT,
        $colImageRef TEXT
      )
    ''');
  }

  Future<int> insertProfile(Profile profile) async {
    Database db = await database;
    return await db.insert(profilesTable, profile.toMap());
  }

  Future<List<Profile>> getProfiles() async {
    Database db = await database;

    final List<Map<String, dynamic>> profilesMapList =
        await db.query(profilesTable);
    return List.generate(profilesMapList.length, (index) {
      return Profile.fromMap(profilesMapList[index]);
    });
  }
}
