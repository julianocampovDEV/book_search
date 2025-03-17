import 'package:book_search/features/books/domain/domain.dart';

class BookMapper {
  static Book jsonToEntity(Map<String, dynamic> json) {
    return Book(
      title: json["title"],
      subtitle: json["subtitle"],
      isbn13: json["isbn13"],
      price: json["price"],
      image: json["image"],
      url: json["url"],
    );
  }

  static Map<String, dynamic> entityToJson(Book book) {
    return {
      "title": book.title,
      "subtitle": book.subtitle,
      "isbn13": book.isbn13,
      "price": book.price,
      "image": book.image,
      "url": book.url,
    };
  }
}
