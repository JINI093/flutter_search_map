import 'package:flutter_search_map/data/repositiory/map.repository.dart';
import 'package:test/test.dart';

void main() {
  test('MapRepository test', () async {
    final repository = MapRepository();
    final result = await repository.searchMap('harry');
    expect(result.isNotEmpty, true);
  });
}
