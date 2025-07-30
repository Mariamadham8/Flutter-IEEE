import 'package:flutter/material.dart';
import 'sec.dart';
import 'third.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  GlobalKey<ScaffoldState> SCkey =GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key:SCkey,
      appBar: AppBar(
        title: const Text(
          "My First App",
          style: TextStyle(color: Color(0xFF446A87)),
        ),
        elevation: 20.0,
        actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.list)),
        ],
      ),
      drawer:Drawer(
        child:ListView(
         children: [
           Container(
             padding: EdgeInsets.all(20),
          child:  ClipRRect(
          borderRadius:BorderRadius.circular(60),
          child: Image.network(
            "https://i.pinimg.com/736x/3c/21/fc/3c21fcbcefbe7e27dda8a4f7b80de04d.jpg",
            width: 50,
            height: 50,
            fit: BoxFit.cover,
           ),
           ),
        ),
      Align(
          alignment: Alignment.center,
          child: Text(
            "OHHHH YAAAA",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
      ),
           ListTile(
             title: Text("homepage"),
             leading: Icon(Icons.home),
             onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ThirdPage())
                );

             },
           ),

           ListTile(
             title: Text("Gallery"),
             subtitle: Text("Mariam try"),
             leading: Icon(Icons.browse_gallery),
             onTap: (){
               Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => SecondPage())
               );
             },
           ),
         ]
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 600,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://i.pinimg.com/1200x/22/c9/a9/22c9a95b52f5865ef817196256a60124.jpg"),

                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Mariam Adham",
                        style: TextStyle(
                          color: Color(0xFF446A87),
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    Builder(builder: (context) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(45),
                              side: BorderSide(
                                  color: Color(0x33241FFF), width: 2),
                            ),
                            elevation: 10,
                            shadowColor: Colors.brown,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondPage()),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              "Flutter",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),

                      );
                    }),

                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
          
        ],

      ),
    );
  }
}

