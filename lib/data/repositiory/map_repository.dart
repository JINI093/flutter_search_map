import 'dart:convert';
import 'package:flutter_search_map/data/model/map.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class MapRepository {
  final Dio _client = Dio(BaseOptions(
    validateStatus: (status) => true,
  ));

  Future<List<Guidance>> searchMap(String query) async {
    final client = http.Client();
    final response = await client.get(
        Uri.parse(
            'https://openapi.naver.com/v1/search/local.json?query=$query&display=10'),
        headers: {
          'X-Naver-Client-Id': 'zVuJ0Fgn2FXhssUNywCe',
          'X-Naver-Client-Secret': 'dgl8Uq9Woy',
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      final List<dynamic> items = map['items'];
      return items.map((e) => Guidance.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<String>> findByName(String query) async {
    try {
      final response = await _client.get(
        'https://api.vworld.kr/req/search',
        queryParameters: {
          'request': 'search',
          'key': '23B7F99C-6E94-3B38-8F2E-D43DFF88ADB5',
          'query': query,
          'type': 'DISTRICT',
          'category': 'L4',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final List<dynamic> items = data['response']['result']['items'];
        return items.map((e) => e['title'].toString()).toList();
      }
    } catch (e) {
      print('Error in findByName: $e');
    }
    return [];
  }

  Future<List<String>> findByLatLng(double lat, double lon) async {
    try {
      final response = await _client.get(
        'https://api.vworld.kr/req/data',
        queryParameters: {
          'request': 'GetFeature',
          'key': '23B7F99C-6E94-3B38-8F2E-D43DFF88ADB5',
          'data': 'LT_C_ADEMD_INFO',
          'geomFilter': 'POINT($lon $lat)',
          'geometry': 'false',
          'size': '100',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['response']['result']['featureCollection'] != null) {
          final features = data['response']['result']['featureCollection']
              ['features'] as List;
          return features
              .map((e) => e['properties']['full_nm'].toString())
              .toList();
        }
      }
    } catch (e) {
      print('Error in findByLatLng: $e');
    }
    return [];
  }

  Future<String?> getAddressFromCoordinates(double lat, double lon) async {
    final String vworldApiKey = '23B7F99C-6E94-3B38-8F2E-D43DFF88ADB5';
    final url = Uri.parse('http://api.vworld.kr/req/address?'
        'service=address&request=getAddress&version=2.0&crs=epsg:4326'
        '&point=$lon,$lat&type=both&format=json&key=$vworldApiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['response']['status'] == 'OK') {
          final result = data['response']['result'][0];
          return result['text'];
        }
      }
    } catch (e) {
      print('Error getting address: $e');
    }
    return null;
  }
}
