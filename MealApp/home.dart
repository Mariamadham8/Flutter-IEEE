import 'package:flutter/material.dart';
import 'MailDetails.dart';
import 'fav_Screen.dart';
import 'get.dart';
import 'model/Meal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'model/MealList.dart';



class Home extends StatefulWidget {
  final Future<List<Food>>? foodData;
  const Home({super.key,  this.foodData});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool is_fav=false;

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<List<Food>>(
    future: widget.foodData,
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Center(child: Text("Error: ${snapshot.error}"));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    return Center(child: Text("No data found"));
    } else {
      final  foods = snapshot.data!;


    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        //childAspectRatio: 3/2,
      ),
      itemCount: foods.length,
      itemBuilder: (context, index) {
        final food = foods[index];
        return InkWell(
          onTap: () {
            Future<List<Meals>> mealsmenu= getMeal(food.strCategory);
            Navigator.push(context, MaterialPageRoute(builder: (context) => Mealdetails(mealsmenu:mealsmenu,foodData: widget.foodData,),));
          },
          child: Card(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      width: 40,
                      padding: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: IconButton(
                        enableFeedback: true,

                        onPressed: () {
                          setState(() {
                            food.isfav=!food.isfav;
                          });

                        },
                        icon: Icon(
                          food.isfav ? Icons.favorite : Icons.favorite_border,
                          color: food.isfav ? Colors.red : Colors.grey,
                        ),
                      )

                  ),
                ),
                Image.network(food.strCategoryThumb, width: 150, height: 100, fit: BoxFit.cover),
                Text(food.strCategory,style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),

          ) ,
        );

      },
    );

    }
    },
    );
  }
}
