import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb{
   static Database? _db;

 Future<Database?> get db async{
    if(_db ==null)
      {
           _db= await inialDb();
           return _db;
      }
    else
      {
        return _db;
      }
   }

  inialDb() async{

    String databasepath =await getDatabasesPath();
    String path =join(databasepath,"sad.db");   //jion add back slash to meet the  path formate :)
    Database mydb = await openDatabase(path,onCreate: _onctreate,version: 2,onUpgrade: _onUpgrade);
    return mydb;
  }

   _onUpgrade(Database db, int oldVersion, int newVersion) async {
     if (oldVersion < 2) {
       await db.execute('ALTER TABLE notes ADD COLUMN title TEXT');
       await db.execute('ALTER TABLE notes ADD COLUMN color TEXT');
       print("Database upgraded to version $newVersion ✅");
     }
   }
  _onctreate(Database db, int version) async{

   //if i have more than one table then i will use Batch.excute and add the tables and in the end add Batch.commit
    await db.execute('''
  CREATE TABLE "notes"(
     "id"  INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
     "note" TEXT NOT NULL,
     "title" TEXT,
     "color" TEXT
  )
   ''');
      print("Create DataBase And Table");


  }

  ReadData(String sql) async{       //Select
   Database? mydb= await db;
   List<Map> res = await  mydb!.rawQuery(sql);
    return res;
  }

   InsertData(String sql) async{       //Insert
     Database? mydb= await db;
     int res = await  mydb!.rawInsert(sql);
     return res;
   }

   UpdataData(String sql) async{       //Update
     Database? mydb= await db;
     int res = await  mydb!.rawUpdate(sql);
     return res;
   }

   DeleteData(String sql) async{       //Delete
     Database? mydb= await db;
     int res = await  mydb!.rawDelete(sql);
     return res;
   }

Deldatabase()async{

  String databasepath =await getDatabasesPath();
  String path =join(databasepath,"sad.db");   //jion add back slash to meet the  path formate :)
  await deleteDatabase(path);
}

//Short cuts
   Read(String table) async{       //Select
     Database? mydb= await db;
     List<Map> res = await  mydb!.query(table);
     return res;
   }

   Insert(String table, Map<String, Object?> values,) async{       //Insert
     Database? mydb= await db;
     int res = await  mydb!.insert(table, values);
     return res;
   }

   Updata(String table, Map<String, Object?> values,String mywhere) async{       //Update
     Database? mydb= await db;
     int res = await  mydb!.update(table, values,where: mywhere);
     return res;
   }

   Delete(String table) async{       //Delete
     Database? mydb= await db;
     int res = await  mydb!.delete(table);
     return res;
   }


}