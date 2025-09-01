import 'package:flutter/material.dart';
import 'fav_Screen.dart';
import 'model/Meal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'model/MealList.dart';



Future<List<Food>> getMeals() async {
  final uri = Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php');
  http.Response res = await http.get(uri);

  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    final List categories = data['categories'];
    return categories.map((item) => Food.fromJson(item)).toList();
  } else {
    throw Exception("Error: ${res.statusCode}");
  }
}



Future<List<Meals>> getMeal(String Catggory) async {
  final uri = Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$Catggory');
  http.Response res = await http.get(uri);

  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    final List meals = data['meals'];
    return meals.map((item) => Meals.fromJson(item)).toList();
  } else {
    throw Exception("Error: ${res.statusCode}");
  }
}