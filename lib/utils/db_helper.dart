import 'package:db_miner/models/quote_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();

  Database? db;

  Future<void> initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "fav.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE IF NOT EXISTS favourites (id INTEGER PRIMARY KEY AUTOINCREMENT, quote TEXT NOT NULL, author TEXT NOT NULL, category TEXT NOT NULL, image BLOB)";
        db.execute(query);
      },
    );
  }

  Future<int> insertFavourite({required QuoteModel quoteModel}) async {
    if (db == null) {
      await initDb();
    }

    Map<String, dynamic> data = {
      'quote': quoteModel.quote_text,
      'author': quoteModel.quote_author,
      'category': quoteModel.quote_category,
    };

    int id = await db!.insert('favourites', data);
    return id;
  }

  Future<List<QuoteModel>> getFavourites() async {
    if (db == null) {
      await initDb();
    }

    List<Map<String, dynamic>> data = await db!.query('favourites');

    List<QuoteModel> favorites = data.map((item) {
      return QuoteModel(
        quote_id: item['id'],
        quote_text: item['quote'],
        quote_author: item['author'],
        quote_category: item['category'],
      );
    }).toList();

    return favorites;
  }

  Future<void> removequote(int id) async {
    if (db != null) {
      String query = "DELETE FROM favourites WHERE id = ?;";
      await db!.rawDelete(query, [id]);
    } else {
      initDb();
    }
  }

  Future<void> removeAllQuote() async {
    if (db != null) {
      String query = "DELETE FROM favourites;";
      await db!.rawDelete(query);
    } else {
      initDb();
    }
  }
}
