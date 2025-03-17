import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:book_search/config/theme/app_colors.dart';
import 'package:book_search/features/books/domain/domain.dart';

class CardBook extends ConsumerWidget {
  final Book book;
  final VoidCallback onTap;

  const CardBook({super.key, required this.book, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        onTap: onTap,
        leading: Image.network(
          book.image,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(book.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(book.subtitle),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}
