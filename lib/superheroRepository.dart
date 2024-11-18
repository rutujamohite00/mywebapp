import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mvvm_flutter_app/task_model.dart';


class SuperheroRepository {

  Future<List<SuperHero>> getSuperheroes() async {
    final String apiUrl = "https://www.simplifiedcoding.net/demos/marvel";
    final response=await http.get(Uri.parse(apiUrl));
print("response"+response.statusCode.toString());
    if (response.statusCode == 200) {
      return List<SuperHero>.from(
          json.decode(response.body).map((x) => SuperHero.fromJson(x)));
    } else {
      throw Exception('Failed to load superheroes');
    }
  }
}
