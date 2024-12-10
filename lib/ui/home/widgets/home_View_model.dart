import 'package:flutter_search_map/data/model/map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_map/data/repositiory/map_repository.dart';
import 'package:flutter_search_map/data/repositiory/geolocator_helper.dart';

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
      print('Starting searchCurrentLocation...');
      final position = await GeolocatorHelper.getCurrentLocation();
      print('Position received: $position');

      if (position != null) {
        final mapRepository = MapRepository();
        final address = await mapRepository.getAddressFromCoordinates(
          position.latitude,
          position.longitude,
        );
        print('Address received: $address');

        if (address != null && address.isNotEmpty) {
          final guidances = await mapRepository.searchMap(address);
          print('Guidances received: ${guidances.length}');
          state = HomeState(guidances);
        } else {
          print('No address found');
        }
      } else {
        print('No position obtained');
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
