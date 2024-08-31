import 'package:e_commerce/models/sneaker_model.dart';
import 'package:e_commerce/services/config.dart';
import 'package:http/http.dart' as http;

// this class fetches data from the json file and return it to the app
class Helper {
  // Male

  static var client = http.Client();
  Future<List<Sneakers>> getMaleSneakers() async {

    var url = Uri.http(Config.apiUrl,Config.sneakers);
    var response = await client.get(url);

    if(response.statusCode==200){
      final list = sneakersFromJson(response.body);
      final maleList = list.where((element)=>element.category == "Men's Running");

      return maleList.toList();
    }else{
      throw Exception("Failed To Get Product");
    }



  }

// Female
  Future<List<Sneakers>> getFemaleSneakers() async {
    var url = Uri.http(Config.apiUrl,Config.sneakers);
    var response = await client.get(url);

    if(response.statusCode==200){
      final list = sneakersFromJson(response.body);
      final femaleList = list.where((element)=>element.category == "Women's Running");
      return femaleList.toList();
    }else{
      throw Exception("Failed To Get Product");
    }
  }

// Kids
  Future<List<Sneakers>> getKidsSneakers() async {
    var url = Uri.http(Config.apiUrl,Config.sneakers);
    var response = await client.get(url);

    if(response.statusCode==200){
      final list = sneakersFromJson(response.body);
      final kidList = list.where((element)=>element.category == "Gujrati");
      return kidList.toList();
    }else{
      throw Exception("Failed To Get Product");
    }
  }

  Future<List<Sneakers>> search(String searchQuery) async {
    var url = Uri.http(Config.apiUrl,"${Config.search}$searchQuery");
    var response = await client.get(url);

    if(response.statusCode==200){
      final result = sneakersFromJson(response.body);
      return result;
    }else{
      throw Exception("Failed To Get Product");
    }
  }
}
