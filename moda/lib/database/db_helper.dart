import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:moda/model/kiyafet.dart';

class DbHelper{
  static Database _db;

  Future<Database> get db async{
    print('get db içinde');
    if(_db != null){
      print('database print edecek');
            return _db;

    }
    print('initDb çağırıldı');
    _db =await initDb();
    return _db;
  }

  initDb() async{
    print('initDb içinde');
    var dbFolder = await getDatabasesPath();
    String path = join(dbFolder,"Kombinler.db");

    return openDatabase(path,onCreate: _onCreate,version: 1);
  }
    
  FutureOr<void> _onCreate(Database db, int version) async{
    print('onCreate içinde');
    await db.execute("CREATE TABLE Kiyafet(id INTEGER PRIMARY KEY AUTOINCREMENT, resimBase64 TEXT, bolum TEXT, mevsim TEXT, tarz TEXT)");
  }

  Future<int> insertKiyafet(Kiyafet kiyafet)async{
    print('insert baş kısmı');
    print('kiyafet : ${kiyafet.bolum} .  ${kiyafet.resimBase64}');
    var dbClient =await db;
    print('db client oluşturuldu');
    return await dbClient.insert('Kiyafet', kiyafet.toMap());
  }

  Future<List<Kiyafet>> getKiyafet()async{
    var dbClient =await db;
    var result = await dbClient.query("Kiyafet",orderBy: 'bolum ASC');
    return result.map((data)=>Kiyafet.fromMap(data)).toList();
  }

  Future<int> deleteKiyafet(int id) async{
    final dbClient =await db;
    var result = await dbClient.delete('Kiyafet', where: 'id = ?',whereArgs: [id]);
    return result;
  }

  Future<int> kiyafetCount()async{
    var dbClient =await db;
    var result = await dbClient.query("Kiyafet");
    return result.map((data)=>Kiyafet.fromMap(data)).toList().length;
  }

  Future<List<Kiyafet>> getFilterKiyafet(List<String> filtreleme)async{
    
    var dbClient =await db;
    List<Kiyafet> filtrelenmis = List<Kiyafet>();
    for(int i=0;i<filtreleme.length;i++){
      var result = await dbClient.query("Kiyafet",orderBy: 'bolum ASC');
    }
    return result.map((data)=>Kiyafet.fromMap(data)).toList();
  }

}