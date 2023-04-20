// Import the required packages
import 'package:sqflite/sqflite.dart' as sql;

// Create a Post class with necessary attributes
class Post {
int? id; // nullable integer for id
String title; // required title string
String? desc; // nullable description string
DateTime? createdAt; // nullable DateTime for created date

// Constructor to create a new Post object
Post({
  this.id,
  required this.title,
  this.desc,
  this.createdAt});
}

// Create a SQLHelper class to handle all database related operations
class SQLHelper {
// A helper function to convert a map to a Post object
  static Post fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'], // assign value of 'id' from the map to Post object's 'id' attribute
      title: map['title'], // assign value of 'title' from the map to Post object's 'title' attribute
      desc: map['desc'], // assign value of 'desc' from the map to Post object's 'desc' attribute
      createdAt: DateTime.parse(map['createdAt']), // assign value of 'createdAt' from the map to Post object's 'createdAt' attribute
  );
  }

  // A helper function to convert a Post object to a map
  static Map<String, dynamic> toMap(Post post) {
    return {
      'id': post.id, // assign Post object's 'id' attribute to the 'id' key in the map
      'title': post.title, // assign Post object's 'title' attribute to the 'title' key in the map
      'desc': post.desc, // assign Post object's 'desc' attribute to the 'desc' key in the map
      'createdAt': post.createdAt.toString(), // assign Post object's 'createdAt' attribute to the 'createdAt' key in the map
    };
  }

  // A function to create the required database tables
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""Create TABLE data(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title TEXT,
    desc TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  // A function to open the database and return an instance of the database
  static Future<sql.Database> db() async {
    return sql.openDatabase("Post.db", version: 1,
      onCreate: (sql.Database database, int version) async {
      await createTables(database);
      }
    );
  }

  // A function to create a new data entry in the database
  static Future<int> createData(String title, String?desc) async{
    final db = await SQLHelper.db();
    final data = {'title': title, 'desc': desc}; // Create a map of data
    final id = await db.insert('data', data, conflictAlgorithm: sql.ConflictAlgorithm.replace); // Insert the data into the database and return the id of the new entry

    return id;
  }

  // A function to get all data from the database
  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await SQLHelper.db();
    return db.query('data', orderBy: 'id'); // Return all data from the 'data' table in the database, ordered by id
  }

  // A function to get a single data entry from the database by its id
  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await SQLHelper.db();
    return db.query('data', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateData(int id, String title, String? desc) async {
    final db = await SQLHelper.db();
    final data = {
      'title': title,
      'desc': desc,
      'createdAt': DateTime.now().toString()
    };
    final result = await db.update('data', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<void> deleteData(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('data', where: "id=?", whereArgs: [id]);
    // ignore: empty_catches
    } catch (e) {}
  }

  static Future<void> close() async {
    final db = await SQLHelper.db();
    await db.close();
  }
}
