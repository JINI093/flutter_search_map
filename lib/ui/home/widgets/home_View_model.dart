import 'package:flutter_search_map/data/repositiory/map.repository.dart';
import 'package:flutter_search_map/data/model/map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

// 1. 상태 클래스
class HomeState {
  List<Guidance> guidances;
  HomeState(this.guidances);
}

// 2. 뷰모델 클래스
class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    return HomeState([]);
  }

  Future<void> searchMap(String query) async {
    final mapRepository = MapRepository();
    final guidances = await mapRepository.searchMap(query);
    state = HomeState(guidances);
  }

  Future<void> searchCurrentLocation() async {
    try {
      // 위치 권한 확인
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permission denied');
          return;
        }
      }

      // 현재 위치 가져오기
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print('Current position: ${position.latitude}, ${position.longitude}');

      // VWORLD API로 주소 가져오기
      final mapRepository = MapRepository();
      final address = await mapRepository.getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );
      print('Retrieved address: $address');

      // 주소로 검색
      if (address != null) {
        // 주소에서 검색에 필요한 키워드만 추출 (예: "XX동" 또는 "XX로")
        final searchKeyword = extractSearchKeyword(address);
        print('Searching with keyword: $searchKeyword');
        await searchMap(searchKeyword);
      } else {
        print('No address found');
      }
    } catch (e) {
      print('Error in searchCurrentLocation: $e');
    }
  }

  // 주소에서 검색 키워드 추출
  String extractSearchKeyword(String address) {
    // 주소에서 동/로/가 등을 포함한 부분을 추출
    final RegExp regExp = RegExp(r'[가-힣]+(동|로|길|가)');
    final match = regExp.firstMatch(address);
    if (match != null) {
      return match.group(0) ?? address;
    }
    // 매칭되는 패턴이 없으면 전체 주소 반환
    return address;
  }
}

// 3. Provider 선언
final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(() {
  return HomeViewModel();
});
