import 'package:mevn_app/news/models/category.dart';

class CategoryRes {
  List<Category>? categories;

  CategoryRes({this.categories});

  CategoryRes.fromJson(List<dynamic> json) {
    categories = <Category>[];

    // ignore: avoid_function_literals_in_foreach_calls
    json.forEach((v) {
      categories!.add(Category.fromJson(v as Map<String, dynamic>));
    });
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
