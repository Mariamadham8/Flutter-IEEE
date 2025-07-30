import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(const MaterialApp(home: HomePage(), debugShowCheckedModeBanner: false));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List items = [
    {
      "image": "https://i.pinimg.com/1200x/fe/f7/b3/fef7b3cbaeb59afc974ab04dd20741e6.jpg",
      "title": "LabTop EliteBook123",
      "price": "120000\$",
    },
    {
      "image": "https://i.pinimg.com/736x/43/15/ae/4315ae69df9daa2550203db798b0d77f.jpg",
      "title": "PlayStation 5",
      "price": "25000\$",
    },
    {
      "image": "https://i.pinimg.com/736x/27/5d/15/275d1500c36432f0c3be886344750d8e.jpg",
      "title": "Wireless Mouse",
      "price": "300\$",
    },
    {
      "image": "https://i.pinimg.com/736x/d9/de/70/d9de70384cbc67fb1ad56980a6dbba64.jpg",
      "title": "Gaming Headset",
      "price": "450\$",
    },
  ];

  @override
  Widget build(BuildContext context) {
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
      drawer: Drawer(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
          child: const Text("Home Page", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            // Search Row
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: "Search",
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: const Icon(Icons.menu, size: 40),
                    ),
                  ),
                ),
              ],
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Categories",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown, fontSize: 25),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  categoryItem(Icons.laptop_chromebook_outlined, "Computer"),
                  categoryItem(Icons.add_a_photo_rounded, "Cameras"),
                  categoryItem(Icons.phone, "Phone", bgColor: Colors.brown),
                  categoryItem(Icons.games, "Games"),
                  categoryItem(Icons.auto_fix_high, "Fix"),
                ],
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Best Seller",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown, fontSize: 20),
              ),
            ),

            Expanded(
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 240,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    child: Column(
                      children: [
                        Image.network(
                          item['image'],
                          width: double.infinity,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SecPage(data:items[index])),
                            );
                          },
                          title: Text(
                            item['title'],
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Price : ${item['price']}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[700],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryItem(IconData icon, String label, {Color? bgColor}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: bgColor ?? Colors.grey[200],
            ),
            child: Icon(icon),
          ),
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}


