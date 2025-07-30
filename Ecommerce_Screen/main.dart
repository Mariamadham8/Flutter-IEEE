import 'package:flutter/material.dart';
import 'package:rate/rate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double rating = 4;
  int count=1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: const Icon(Icons.arrow_back_ios, color: Colors.white),
          actions: const [
            Icon(Icons.favorite, color: Colors.white),
            SizedBox(width: 10),
            Icon(Icons.shopping_bag_outlined, color: Colors.white),
            SizedBox(width: 10),
          ],
          actionsPadding: const EdgeInsets.all(10),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 20),
                  Image(
                    image: const NetworkImage(
                      "https://i.pinimg.com/736x/8f/aa/52/8faa52785f79c1ec8fda0bc8f0c0f397.jpg",
                    ),
                    width: 200,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 30),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      sizeBox("S"),
                      const SizedBox(height: 20),
                      sizeBox("M"),
                      const SizedBox(height: 20),
                      sizeBox("XL"),
                      const SizedBox(height: 20),
                      sizeBox("2XL"),
                      const SizedBox(height: 20),
                      sizeBox("2XL"),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text(
                "Belguim EURO",
                style: TextStyle(color: Colors.white, fontFamily: 'MyFont',
                  fontSize: 20, ),
              ),

              subtitle: Text(
                "20/21 Away by Adidas",
                style: TextStyle(color: Colors.grey[400], fontFamily: 'MyFont',
                  fontSize: 14, ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Rate(
                  color: Colors.pink,
                  allowHalf: false,
                  allowClear: true,
                  initialValue: rating,
                  iconBuilder: (value, index) {
                    return Icon(
                      Icons.star,
                      color: index < rating ? Colors.pink : Colors.grey,
                    );
                  },
                  onChange: (value) {
                    setState(() {
                      rating = value;
                    });
                  },
                ),
                SizedBox(width: 140,),
                Container(
                  color: Colors.grey[900],
                   height: 30,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                   SizedBox(
                   height: 50,
                   width: 30,
                  child: FloatingActionButton(
                        backgroundColor: Colors.pink,
                     child: Icon(Icons.remove,color: Colors.white,),
                        onPressed: (){
                          setState(() {
                             count--;
                          });
                        },
                      ),
                   ),
                      SizedBox(width: 10,),
                      Text("$count",style: TextStyle(color: Colors.white),),
                      SizedBox(width: 10,),
                    SizedBox(
                      height: 50,
                      width: 30,
                      child: FloatingActionButton(
                        backgroundColor: Colors.pink,
                        child: Icon(Icons.add,color: Colors.white,),
                        onPressed: (){
                          setState(() {
                            count++;
                          });
                        },
                      ),
                    ),
                    ],
                  )
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Column(
                  children: [
                    Row(
                      children:[
                        Text("Details :",style: TextStyle(color: Colors.grey[700],fontFamily: 'MyFont',),),
                        Text("anything",style: TextStyle(color: Colors.grey,fontFamily: 'MyFont',),),
                         ]
                    ),
                    Row(
                        children:[
                          Text("Details :",style: TextStyle(color: Colors.grey[700],fontFamily: 'MyFont',),),
                          Text("anything",style: TextStyle(color: Colors.grey,fontFamily: 'MyFont',),),
                        ]
                    ),
                    Row(
                        children:[
                          Text("Details :",style: TextStyle(color: Colors.grey[700],fontFamily: 'MyFont',),),
                          Text("anything",style: TextStyle(color: Colors.grey,fontFamily: 'MyFont',),),
                        ]
                    ),
                    Row(
                        children:[
                          Text("Details :",style: TextStyle(color: Colors.grey[700],fontFamily: 'MyFont',),),
                          Text("anything",style: TextStyle(color: Colors.grey,fontFamily: 'MyFont',),),
                        ]
                    ),
                  ],
                ),
                SizedBox(width: 130,height: 10,),
                Container(
                  width: 80,
                height: 100,
                child: Card(
                  color: Colors.pink,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Icon(Icons.shopping_bag_outlined),
                      Icon(Icons.monetization_on),
                    ],
                  )
                )
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget sizeBox(String label) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: label == 'XL' ? Colors.pink : Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'MyFont',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
