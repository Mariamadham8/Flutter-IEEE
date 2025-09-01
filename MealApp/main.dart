import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'fav_Screen.dart';
import 'get.dart';
import 'home.dart';
import 'model/Meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});


  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  Future<List<Food>>?  FoodData;
  @override
  void initState() {
    super.initState();
    FoodData= getMeals();
  }

  int _selectedIndex = 0;


  final List<String> _titles = [
    "Home",
    "Favorite Food",
  ];



  @override
  Widget build(BuildContext context) {

    final List<Widget> _pages = [
      Home(foodData: FoodData,),
      Fav(foodData: FoodData,),
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.barsStaggered,
            color: Colors.tealAccent,
            size: 30,
          ),
          onPressed: () {},
        ),
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.tealAccent,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.tealAccent,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),

      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "Favorites",
          ),
        ],
        selectedItemColor: Colors.tealAccent,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
