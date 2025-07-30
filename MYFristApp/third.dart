import 'package:flutter/material.dart';
import 'main.dart';


class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(

          items:[
            BottomNavigationBarItem(icon:Icon(Icons.home),label:"Home"),
            BottomNavigationBarItem(icon:Icon(Icons.settings),label:"Settings"),
          ],
          currentIndex: selectedIndex,
            selectedItemColor: Colors.blue,// لون العنصر المختار
        unselectedItemColor: Colors.grey,
          onTap: (value) {
              setState(() {
                selectedIndex =value;
              });
              showDialog(
                 barrierDismissible: false,
                  context:context,
                  builder: (context)
                  {
                    return AlertDialog(
                      title: Text("Warning"),
                      content: Text("Are you Sure"),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FirstPage())
                          );
                        }, child: Text("Ok")),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdPage())
                          );
                        }, child: Text("Cancel")),
                      ],

                    );
                  }
              );
          },
        ),
        appBar: AppBar(
          title: Text("My Tabs Page"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Tab 1"),
              Tab(text: "Tab 2"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("Content of Tab 1")),
            Center(child: Text("Content of Tab 2")),
          ],
        ),
      ),
    );
  }
}

/*
here i will give an example of custome widgets  its like concept of function

class custumliststyle extends from statlessWidget{

final String name ;
final String email;

@override
  Widget build(BuildContext context) {
    return Card(
        color :Colors.red,
        child:Row(
            Image.Network(""),
            ListTile(
               title:Text("$name"),
               tile:Text("$email"),

            )
        )

    )



}




 */