import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_Listview.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // 검색 바
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: '지역을 입력해주세요.',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ),


      // 검색 결과 리스트
      body: Container(
        child: const HomeListView(),
      ),
    );
  }
}
