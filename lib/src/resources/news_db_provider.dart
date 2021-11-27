import 'package:news_app/src/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import '../models/item_model.dart';

class NewsDbProvider implements Source, Cache {
  late Database db;

  NewsDbProvider(){
    init();
  }

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");
    db = await openDatabase(path, version: 1, onCreate: (Database newDb, int version) {
      newDb.execute("""
      CREATE_TABLE Items
      (
        id INTEGER PRIMARY KEY,
        type TEXT,
        time INTEGER,
        parent INTEGER,
        kids BLOB,
        dead INTEGER,
        deleted = INTEGER,
        score = INTEGER,
        title TEXT,
        descendants INTEGER
      )
      """);
    });
  }

  @override
  Future<List<int>>? fetchTopIds() {
    return null;
  }

  @override
  Future<ItemModel?> fetchItem(int id) async {
    final maps = await db.query(
      "Items",columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  @override
  Future<int> addItem(ItemModel item) {
    return db.insert("Items", item.toMap());
  }
}

final newsDbProvider = NewsDbProvider();
