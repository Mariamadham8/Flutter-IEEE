import 'package:flutter/material.dart';

class SecPage extends StatefulWidget {
  final dynamic data;
  const SecPage({super.key, this.data});

  @override
  State<SecPage> createState() => _SecPage();
}

class _SecPage extends State<SecPage> {
  @override
  Widget build(BuildContext context) {
    final item = widget.data;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.brown,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.shopping_cart, color: Colors.white),
            Text(" M", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text("Store", style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.network(
              item["image"],
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text(
              item["title"],
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Price: ${item["price"]}",
              style: TextStyle(fontSize: 18, color: Colors.brown[700]),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Color :   "),
                Container(
                  width: 20,
                  height: 20,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey[200],
                  ),
                ),
                Text("grey        "),
                Container(
                  width: 20,
                  height: 20,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black,
                  ),
                ),

                Text("black"),
              ],
            ),
            Text("size  : 32  45   67  89"),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {

              },
              child: const Text("Add to Cart"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),




          ],
        ),
      ),
    );
  }
}
