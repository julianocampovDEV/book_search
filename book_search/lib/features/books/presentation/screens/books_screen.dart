import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:book_search/config/router/route_name.dart';
import 'package:book_search/config/theme/app_colors.dart';
import 'package:book_search/features/books/presentation/books.dart';
import 'package:book_search/shared/shared.dart';

class BooksScreen extends ConsumerStatefulWidget {
  const BooksScreen({super.key});

  @override
  ConsumerState<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends ConsumerState<BooksScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _onChangedSearchBook() {
    final query = _searchController.text.trim();
    ref.read(booksProvider.notifier).searchBook(query);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final books = ref.watch(booksProvider);
    final searchHistory = ref.watch(searchCacheProvider);

    return Scaffold(
      body: Column(
        children: [
          BooksHeader(
            child: Column(
              spacing: 10,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: SearchInput(
                    searchController: _searchController,
                    onChanged: (_) => _onChangedSearchBook(),
                  ),
                ),
                searchHistory.isEmpty
                    ? SizedBox()
                    : _listSearchHistory(context, searchHistory),
              ],
            ),
          ),

          Expanded(
            child: books.when(
              loading:
                  () => const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
              data:
                  (books) =>
                      books.isEmpty
                          ? const Center(child: Text("No books found."))
                          : ListView.builder(
                            itemCount: books.length,
                            itemBuilder: (context, index) {
                              final book = books[index];
                              return CardBook(
                                book: book,
                                onTap: () => _onTapCardBook(book.isbn13),
                              );
                            },
                          ),
              error: (error, stackTrace) => Center(child: Text("$error")),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onTapCardBook(String isbn13) async {
    await context.push('$bookDetailsRoute/$isbn13');
    ref.read(searchCacheProvider.notifier).addSearch(_searchController.text);
  }

  SizedBox _listSearchHistory(
    BuildContext context,
    List<String> searchHistory,
  ) {
    return SizedBox(
      width: DeviceUtils.getScreenWidth(context),
      height: 40,
      child: ListView.builder(
        itemCount: searchHistory.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,

        itemBuilder: (context, index) {
          final query = searchHistory[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ActionChip(
              labelPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: AppColors.primary, width: 1.5),
              ),
              label: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 10, maxWidth: 100),
                child: IntrinsicWidth(
                  child: Text(
                    query,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              onPressed: () {
                _searchController.text = query;
                _onChangedSearchBook();
              },
            ),
          );
        },
      ),
    );
  }
}
