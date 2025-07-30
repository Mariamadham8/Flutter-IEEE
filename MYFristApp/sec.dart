import 'package:flutter/material.dart';
import 'third.dart';

class SecondPage extends StatefulWidget {
  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final List<String> images = [
    "https://i.pinimg.com/736x/90/2b/c0/902bc03c69bc59e4723fa1c485fa9d0c.jpg",
    "https://i.pinimg.com/736x/c9/18/63/c91863429591c91c0117edd04509c4aa.jpg",
    "https://i.pinimg.com/736x/c4/0f/61/c40f61607cf6987528ad0466f6bf54e7.jpg",
    "https://i.pinimg.com/736x/b4/90/75/b49075580c1b21b30376ab6eac1b8db7.jpg"

  ];
  bool state = true;
  TextEditingController username=TextEditingController();
  TextEditingController outputController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learning Page"),
      ),
      body: ListView(
          children: [
            Card(
                child: Column(
                    children: [

                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ThirdPage())
                          );
                        },
                        title: Text("Mariam's Gallary"),
                        subtitle: Text("Scroll"),
                        trailing: Icon(
                          Icons.star,
                          color: Colors.brown,
                        ),
                      ),
                      //herre we can use page view more simple than this logic to scroll notice to specify container hight  and wigth
                      Container(
                          height: 150,
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: images.length,
                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 150,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(images[index],),
                                          fit: BoxFit.cover
                                      )

                                  ),
                                );
                              })
                      ),

                    ]
                )
            ),

            Switch(value: state, onChanged:(val){

              setState(() {
                state = val;
              });

            }),
            Column(
                children:
                [
                  TextFormField(
                    readOnly: true,
                    controller: outputController,
                    decoration: InputDecoration(
                      prefix:Icon(Icons.person),
                      hintText: "help",
                    ),
                  ),

                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "help",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.red),
                        )
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "required";
                      }
                    },
                  ),
                  MaterialButton(
                      child: Text("Press"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(45)),
                      ),
                      color:Colors.brown,
                      onPressed: (){
                        setState(() {
                          outputController.text = username.text;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Done"),
                          ),
                        );

                      })

                ]
            ),

          ]
      ),
    );
  }
}