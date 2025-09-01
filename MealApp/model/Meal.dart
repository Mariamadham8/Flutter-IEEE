class Food {
  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String  strCategoryDescription;
   bool isfav;

  Food({
   required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
    this.isfav = false,

  });

  // factory constructor to parse JSON
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      idCategory: json['idCategory'] as String,
      strCategory: json['strCategory'] as String,
      strCategoryThumb: json['strCategoryThumb'] as String,
      strCategoryDescription: json['strCategoryDescription'] as String,
    );
  }
}
