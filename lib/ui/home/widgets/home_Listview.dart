import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_map/data/model/map.dart';
import 'package:flutter_search_map/ui/home/widgets/home_view_model.dart';

final countProvider = StateProvider<int>((ref) => 10);

class HomeListView extends ConsumerWidget {
  const HomeListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: homeState.guidances.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final guidance = homeState.guidances[index];
          return item(context, guidance as Guidance);
        },
      ),
    );
  }
}

Widget item(BuildContext context, Guidance guidance) {
  try {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            guidance.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            guidance.category,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            guidance.address,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  } catch (e) {
    print('Error: $e');
    return Container();
  }
}
