import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'fav_Screen.dart';
import 'model/Meal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'model/MealList.dart';
import 'get.dart';




class Mealdetails extends StatefulWidget {
  final Future<List<Meals>> mealsmenu;
  final Future<List<Food>>? foodData;
  const Mealdetails({super.key, required this.mealsmenu, this.foodData});

  @override
  State<Mealdetails> createState() => _MealdetailsState();
}

class _MealdetailsState extends State<Mealdetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor:Colors.white,
        actionsPadding: EdgeInsets.all(10),
        leading: InkWell(
          child:Icon(Icons.arrow_back,color: Colors.tealAccent,),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Icon(Icons.favorite_border),
          Icon(Icons.send_and_archive_outlined),
          Icon(Icons.shopping_cart),
          Icon(Icons.share),

        ],
      ),
      body: FutureBuilder<List<Meals>>(
        future: widget.mealsmenu,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No meals found"));
          } else {
            final meal = snapshot.data![1];

            return Column(
               spacing: 10,
              children: [

                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Image.network(
                    meal.strMealThumb ?? "",
                    fit: BoxFit.cover,
                  ),
                ),

                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(   meal.strMeal ?? "",style: TextStyle(color: Colors.tealAccent,fontWeight: FontWeight.bold,fontSize: 20),),
                ),

                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.star, color: Colors.tealAccent,),
                          Text("Easy"),
                        ],
                      ),
                      VerticalDivider(color: Colors.grey, thickness: 50, width: 10),
                      Column(
                        children: [
                          Icon(Icons.timer, color: Colors.tealAccent,),
                          Text("25 min"),
                        ],
                      ),
                      VerticalDivider(color: Colors.grey, thickness: 1, width: 10),
                      Column(
                        children: [
                          Icon(Icons.restaurant,color: Colors.tealAccent[200],),
                          Text("Ingredients"),

                        ],
                      ),
                    ],
                  ),
                ),
                FutureBuilder<List<Food>>(
                  future: widget.foodData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading description...");
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text("No description found");
                    } else {
                      final food = snapshot.data![0]; // أول عنصر
                      return Text(
                        food.strCategoryDescription ?? "",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      );
                    }
                  },
                ),
              ],
            );
          }
        },
      ),

    );
  }
}
