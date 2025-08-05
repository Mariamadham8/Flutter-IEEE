import 'package:flutter/material.dart';
import 'sqldb.dart';
import 'HomePage.dart';

class Addnote extends StatefulWidget {
  @override
  State<Addnote> createState() => _Addnote();
}

SqlDb sqldb =new SqlDb();

GlobalKey<FormState> formstate= GlobalKey();
TextEditingController note =TextEditingController();
TextEditingController title =TextEditingController();
TextEditingController color =TextEditingController();

class _Addnote extends State<Addnote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     title: Text("Add Note"),
      ),
      body:Container(
        padding: EdgeInsets.all(30),
        child: ListView(
          children: [
            Form(
              key: formstate,
                child: Column(
              children: [
                TextFormField(
                  controller: note,
                  decoration: InputDecoration(hintText: "notes"),
                ),
                TextFormField(
                  controller: title,
                  decoration: InputDecoration(hintText: "title"),
                ),
                TextFormField(
                  controller: color,
                  decoration: InputDecoration(hintText: "color"),
                ),
                MaterialButton(
                  color: Colors.black54,
                  onPressed: () async {
                    int res = await sqldb.InsertData('''
                     INSERT INTO notes (`note`, `title`, `color`)
                     VALUES ("${note.text}", "${title.text}", "${color.text}")
                     ''');
                     print("---------------------------------------------------- :)");
                     print(res);
                     if(res>0)
                       {
                         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),), (route) =>false ,);
                       }
                  },

                  child: Text("Add Notes"),)
              ],
            ))

          ],
        ),
      ),
    );
  }
}
