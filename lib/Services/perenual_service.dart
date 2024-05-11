import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:plantsnap/models/plant.dart';

class PerenualService {
  String baseURL = "https://perenual.com/api";
  String apiKey = "sk-VfHp663e0f8c9408d5413";

  Future<Plant?> getRandomPlant() async {

    int randomID = Random().nextInt(30) + 1;
    var url = Uri.parse("$baseURL/species/details/$randomID?key=$apiKey");
    Map<String, dynamic> responseData;

    print("Inside getRandomPlant Function");

    try {
      print("Inside Try block");
      final response = await http.get(url);
      int responseCode = response.statusCode;
      final responseBody = response.body;
      // print("ResponseBody: $responseBody");
      // print("ResponseCode: $responseCode ");

      if (response.statusCode == 200) {

        responseData = json.decode(response.body);

        Plant plant = Plant(
          name: responseData["common_name"],
          origin: responseData["origin"][0],
          cycle: responseData["cycle"],
          description: responseData["description"],
          type: responseData["type"],
          sunlight: responseData["sunlight"][0],
          scientificName: responseData["scientific_name"][0],
          images: responseData["default_image"],
          watering: responseData["watering"],
        );
        print("Returning Plant: $plant");
        return plant;
      } else {
        print("Inside exception block");
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error);
    }
  }
}
