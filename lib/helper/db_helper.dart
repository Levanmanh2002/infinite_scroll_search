import 'dart:convert';
import 'package:infinite_scroll_search/models/product_models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'products.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY,
            product_data TEXT
          )
        ''');
      },
    );
  }

  static Future<void> insertProduct(ProductModels product) async {
    final db = await database;
    await db.insert(
      'products',
      {
        'id': product.id,
        'product_data': jsonEncode(product.toJson()),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<ProductModels>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) {
      Map<String, dynamic> productData = json.decode(maps[i]['product_data']);

      if (productData['reviews'] is String) {
        productData['reviews'] = json.decode(productData['reviews']);
      }

      return ProductModels.fromJson(productData);
    });
  }

  static Future<void> deleteProduct(int id) async {
    final db = await database;
    await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteOldDatabase() async {
    String path = join(await getDatabasesPath(), 'products.db');
    await deleteDatabase(path);
  }
}
