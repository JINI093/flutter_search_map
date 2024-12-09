import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_map/ui/home/widgets/home_view_model.dart';
import 'home_Listview.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  void onSearch(String text) {
    ref.read(homeViewModelProvider.notifier).searchMap(text);
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);
    return Scaffold(
      // 검색 바
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            onChanged: onSearch,
            decoration: InputDecoration(
              hintText: '검색어를 입력해 주세요',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(homeViewModelProvider.notifier).searchCurrentLocation();
            },
            icon: const Icon(Icons.gps_fixed),
          ),
        ],
      ),

      // 검색 결과 리스트
      // 검색 결과 리스트
      body: Container(
        child: HomeListView(homeState: homeState),
      ),
    );
  }
}
