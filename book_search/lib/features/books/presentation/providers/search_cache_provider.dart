import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchCacheProvider =
    StateNotifierProvider<SearchCacheNotifier, List<String>>((ref) {
      return SearchCacheNotifier();
    });

class SearchCacheNotifier extends StateNotifier<List<String>> {
  SearchCacheNotifier() : super([]);

  void addSearch(String query) {
    if (query.isEmpty) return;
    state = [query, ...state.where((item) => item != query)].take(5).toList();
  }
}
