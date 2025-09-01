import 'package:flutter/material.dart';
import 'MailDetails.dart';
import 'get.dart';
import 'model/Meal.dart';
import 'home.dart';
import 'model/MealList.dart';


class Fav extends StatefulWidget {
  final Future<List<Food>>? foodData;
  const Fav({super.key,  this.foodData});

  @override
  State<Fav> createState() => _FavState();
}

class _FavState extends State<Fav> {


    @override
    Widget build(BuildContext context) {
      return FutureBuilder<List<Food>>(
        future: widget.foodData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final foods = snapshot.data ?? [];
          final favs = foods.where((f) => f.isfav == true).toList();

          if (favs.isEmpty) return const Center(child: Text('No favorites yet'));

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5,
            ),
            itemCount: favs.length,
            itemBuilder: (context, index) {
              final food = favs[index];
              return  InkWell(
                onTap: () {
                  Future<List<Meals>> mealsmenu= getMeal(food.strCategory);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Mealdetails(mealsmenu:mealsmenu,foodData: widget.foodData,),));
                },
                child: Card(
                child: Column(
                  children: [

                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {

                        },
                        icon: Icon(
                          food.isfav ? Icons.favorite : Icons.favorite_border,
                          color: food.isfav ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                    Image.network(food.strCategoryThumb, width: 150, height: 100, fit: BoxFit.cover),
                    Text(food.strCategory, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              );

            },
          );
        },
      );
  }
}


