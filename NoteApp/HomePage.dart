import 'package:flutter/material.dart';
import 'sqldb.dart';
import 'AddNote.dart';
import 'EditPage.dart';

//there is another way is to use FutureBuilder but this cost that we reload the page cuase of using navigitor.push

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePage();

}
class _HomePage extends State<HomePage>  {
  final SqlDb sqldb = SqlDb();

  List notes =[];
  Future readData() async {
    List<Map> res = await sqldb.ReadData("SELECT * FROM notes");
    notes.addAll(res);
    setState(() {

    });

  }

  @override
  void initState(){
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes"),backgroundColor: Colors.white,),
      backgroundColor: Colors.white,

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // هنا بقى هيشتغل صح لإن الـ context جوه Scaffold
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addnote()),
          );
        },
        child: Icon(Icons.add),
      ),

      body:  ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Editnote(
                          id: notes[index]['id'],
                          note: notes[index]['note'],
                          title: notes[index]['title'],
                          color: notes[index]['color'],
                        ),
                    )
                        );
                  },
                  title: Text("${notes[index]['title']}"),
                  subtitle: Text("${notes[index]['note']}"),
                  trailing: IconButton(
                      onPressed: ()async{
                       int res= await sqldb.DeleteData("DELETE FROM notes WHERE id =${notes[index]['id']}");
                       if(res >0)
                         {
                             notes.removeWhere((element)=>element['id']==notes[index]['id']);
                             setState(() {

                             });
                         }
                       print(res);
                      },
                      icon: Icon(Icons.remove),color: Colors.red[300],),
                ),
              );
            }
          )
    );
  }
}
