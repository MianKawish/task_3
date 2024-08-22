import 'package:dio/dio.dart';
import 'package:task_3/model/api_model/news_model.dart';

class ApiServices {
  final String api =
      "https://newsapi.org/v2/top-headlines?country=us&apiKey=45e80b5c18ab478fb5f68cbf221a72d0";
  final Dio dio = Dio();

  Future getData() async {
    var response = await dio.get(api);

    if (response.statusCode == 200) {
      return NewsModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
