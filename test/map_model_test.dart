import 'dart:convert';
import 'package:flutter_search_map/model/map.dart';
import 'package:test/test.dart';

void main() {
  test('Map model test', () {
    {
      String dummyData = '''
      {
        "title": "커피해리902",
        "link": "https://www.instagram.com/coffeeharry902",
        "category": "음식점>카페,디저트",
        "description": "",
        "telephone": "",
        "address": "인천광역시 서구 원당동 1030-8 검단퍼스트 112호",
        "roadAddress": "인천광역시 서구 이음5로 80 검단퍼스트 112호",
        "mapx": "1267163311",
        "mapy": "375953218"
      }
      ''';
      // JSON 문자열을 Map으로 변환
      Map<String, dynamic> map = jsonDecode(dummyData);
      // Map을 Guidance 객체로 변환
      Guidance guidance = Guidance.fromJson(map);
      expect(guidance.title, '커피해리902');
    }
  });
}
