import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/login_sigup/model/admin_model.dart';
import 'package:todo_list/login_sigup/model/user_model.dart';

class DBHelper {
  final dbName = 'user.db';
  String tblUser =
      'CREATE TABLE tblUsers (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,username TEXT,password TEXT)';
  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(tblUser);
      },
    );
  }

  Future<int> sigUp(UserModel user) async {
    final Database db = await initDB();
    return db.insert('tblUsers', user.toMap());
  }

  Future<bool> login(UserModel user) async {
    final Database db = await initDB();
    var result = await db.rawQuery(
        "select * from tblUsers where username = '${user.username}' AND password = '${user.password}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

/////////////////////////////////////////////////////ADMIN//////////////////////////////////////////////////////
class DBAdm {
  final dbname = 'adm.db';
  String tblAdmin =
      'CREATE TABLE admin (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,username TEXT,password TEXT)';
  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbname);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(tblAdmin);
      },
    );
  }

  Future<int> sigUp(Admin admin) async {
    final Database db = await initDB();

    return db.insert('admin', admin.toJson());
  }

  Future<bool> login(Admin admin) async {
    final Database db = await initDB();
    var result = await db.query(
        "select * from admin where username = '${admin.username}' AND password = '${admin.password}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
