import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:book_search/config/theme/app_colors.dart';
import 'package:book_search/features/books/presentation/books.dart';

class BookDetailsScreen extends ConsumerWidget {
  final String isbn13;
  const BookDetailsScreen({super.key, required this.isbn13});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookDetail = ref.watch(bookDetailProvider(isbn13));

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BookDetailsHeader(
              child: bookDetail.when(
                loading:
                    () =>
                        const CircularProgressIndicator(color: AppColors.white),
                error:
                    (error, _) => Text(
                      "$error",
                      style: TextStyle(color: AppColors.white),
                    ),
                data: (book) => Image.network(book.image, height: 300),
              ),
              onPressed: () => context.pop(),
            ),

            bookDetail.when(
              loading: () => SizedBox(),
              error: (error, _) => SizedBox(),
              data:
                  (book) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _header('Title:', book.title),
                          _header('Subtitle:', book.subtitle),
                          _header('Description:', book.desc),
                          _header('Authors:', book.authors),
                          _header('Publisher:', book.publisher),
                          _header('Pages:', book.pages),
                          _header('Year:', book.year),
                          _header('Rating:', book.rating),
                          _header('Price:', book.price),
                          _header('URL:', book.url),
                        ],
                      ),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(String label, String value) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        spacing: 10,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
