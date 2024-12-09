import 'dart:convert';
import 'package:flutter_search_map/data/model/map.dart';
import 'package:http/http.dart' as http;

class MapRepository {
  Future<List<Guidance>> searchMap(String query) async {
    final client = http.Client();
    final response = await client.get(
        Uri.parse(
            'https://openapi.naver.com/v1/search/local.json?query=$query'),
        headers: {
          'X-Naver-Client-Id': 'zVuJ0Fgn2FXhssUNywCe',
          'X-Naver-Client-Secret': 'dgl8Uq9Woy',
        });
    // Get 요청 성공 => 200
    // 응답코드가 200일 떄!
    // body 데이터를 jsonDecode 함수를 사용해서 Map으로 변환
    // 응답코드가 200이 아닐 때 빈 리스트 반환

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      final List<dynamic> items = map['items'];
      final Iterable<Guidance> iterable = items.map((e) {
        return Guidance.fromJson(e);
      });

      final list = iterable.toList();
      return list;
    }
    return [];
  }

  Future<String?> getAddressFromCoordinates(double lat, double lon) async {
    final String vworldApiKey = 'YOUR_VWORLD_API_KEY'; // VWORLD API 키를 입력하세요
    final url =
        'http://api.vworld.kr/req/address?service=address&request=getAddress&version=2.0&crs=epsg:4326&point=${lon},${lat}&type=both&format=json&key=$vworldApiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['response']['status'] == 'OK') {
          final result = data['response']['result'][0];
          return result['text']; // 전체 주소 반환
        }
      }
    } catch (e) {
      print('Error getting address: $e');
    }
    return null;
  }
}
