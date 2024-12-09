import 'package:flutter_search_map/data/repositiory/map.repository.dart';
import 'package:flutter_search_map/data/model/map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 상태 클래스 만들기
class HomeState {
  List<Guidance> guidances;
  HomeState(this.guidances);
}

// 2. 뷰모델 만들기 - Notifier 상속
class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    return HomeState([]);
  }

  Future<void> searchMap(String query) async {
    final mapRepository = MapRepository();
    final guidances = await mapRepository.searchMap(query);
    state = HomeState(guidances.cast<Guidance>());
  }
}

// 3. 뷰모델 관리자 만들기 - NotifireProvider 객체
final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(() {
  return HomeViewModel();
});
