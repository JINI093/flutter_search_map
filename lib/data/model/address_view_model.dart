import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_map/data/repositiory/map_repository.dart';

class AddressViewModel extends StateNotifier<List<String>> {
  AddressViewModel() : super([]);

  final mapRepository = MapRepository();

  Future<void> searchByName(String query) async {
    final address = await mapRepository.findByName(query);
    state = address;
  }

  Future<void> searchByLocation(double lat, double lng) async {
    final address = await mapRepository.findByLocation(lat, lng);
    state = address;
  }
}

final addressViewModelProvider =
    StateNotifierProvider<AddressViewModel, List<String>>((ref) {
  return AddressViewModel();
});
