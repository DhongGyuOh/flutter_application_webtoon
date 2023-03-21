import 'dart:convert';
import 'package:flutter_application_webtoon/models/webtoon_model.dart';
import 'package:http/http.dart' as http;
//as http 를 사용하면 http.~~~ 를 사용할 수 있음

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodayToons() async {
    //API로부터 웹튠 JSON 정보를 가져오고 가공시킨 값을 List로 반환하는 매소드
    List<WebtoonModel> webtoonIstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    //get을 통해 Future라는 타입의 결과 값을 받을 때까지 응답을 기다리기 위해 awiat과 async을 추가함
    //await, async를 사용할 때는 return 값에도 Future라고 명시해야함
    //Future란 당장 완료될 수 없는 작업을 말함

    if (response.statusCode == 200) {
      //statusCode 는 http 응답코드를 말함 200일 경우 OK(요청이 수행되었음)를 의미함
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonIstances.add(WebtoonModel.fromJson(webtoon));
        //webtoonIstances 리스트에 WebtoonNodel 클래스의 fromJson named 생성자를 통해 webtoon을 가공하여 추가함
      }
      return webtoonIstances;
    }
    throw Error();
  }
}
