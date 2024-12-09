import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_map/ui/home/widgets/home_view_model.dart';
import 'package:test/test.dart';

void main() {
  test('HomeViewModel test', () async {
    ProviderContainer container = ProviderContainer();
    addTearDown(container.dispose);
    final viewModel = container.read(homeViewModelProvider.notifier);
    await viewModel.searchMap('harry');
    expect(viewModel.state.guidances.isNotEmpty, true);
  });
}
