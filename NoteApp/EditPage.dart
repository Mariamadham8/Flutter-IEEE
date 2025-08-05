import 'package:flutter/material.dart';
import 'sqldb.dart';
import 'HomePage.dart';

class Editnote extends StatefulWidget {
  final int id;
  final String note;
  final String title;
  final String color;

  Editnote({
    required this.id,
    required this.note,
    required this.title,
    required this.color,
  });
  @override
  State<Editnote> createState() => _Editnote();
}


SqlDb sqldb =new SqlDb();

GlobalKey<FormState> formstate= GlobalKey();
TextEditingController note =TextEditingController();
TextEditingController title =TextEditingController();
TextEditingController color =TextEditingController();

class _Editnote extends State<Editnote> {

  @override
  void initState() {
    super.initState();
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
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
                        int res = await sqldb.UpdataData('''
                         UPDATE notes SET 
                         note = '${note.text}', 
                         title = '${title.text}', 
                         color = '${color.text}' 
                           WHERE id = ${widget.id}
                            ''');
                        print("---------------------------------------------------- :)");
                        print(res);
                        if(res>0)
                        {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),), (route) =>false ,);
                        }
                      },

                      child: Text("Edit Notes"),)
                  ],
                ))

          ],
        ),
      ),
    );
  }
}