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
          return;
        }
      }

      // 현재 위치 가져오기
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // VWORLD API로 주소 가져오기
      final mapRepository = MapRepository();
      final address = await mapRepository.getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // 주소로 검색
      if (address != null) {
        await searchMap(address);
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }
}

// 3. Provider 선언
final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(() {
  return HomeViewModel();
});
