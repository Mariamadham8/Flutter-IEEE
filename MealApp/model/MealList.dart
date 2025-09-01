class Meals {

  final String strMeal;
  final String strMealThumb;
  final String idMeal;

  Meals({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  factory Meals.fromJson(Map<String, dynamic> json) {
    return Meals(
      strMeal: json['strMeal'] as String,
      strMealThumb: json['strMealThumb'] as String,
      idMeal: json['idMeal'] as String,

    );
  }
}