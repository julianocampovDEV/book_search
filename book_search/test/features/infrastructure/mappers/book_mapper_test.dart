import 'package:flutter_test/flutter_test.dart';

import 'package:book_search/features/books/domain/domain.dart';
import 'package:book_search/features/books/infrastructure/infrastructure.dart';

void main() {
  group('BookMapper Tests', () {
    test('Should convert JSON to Book entity', () {
      final Map<String, dynamic> mockJson = {
        "title": "Title 1",
        "subtitle": "Subtitle 1",
        "isbn13": "1234567890123",
        "price": "\$19.99",
        "image": "https://example.com/image_1.png",
        "url": "https://example.com/book_1",
      };

      final book = BookMapper.jsonToEntity(mockJson);

      expect(book.title, "Title 1");
      expect(book.isbn13, "1234567890123");
      expect(book.price, "\$19.99");
      expect(book.image, "https://example.com/image_1.png");
    });

    test('Should convert Book entity to JSON', () {
      final book = Book(
        title: "Title 1",
        subtitle: "Subtitle 1",
        isbn13: "9876543210987",
        price: "\$24.99",
        image: "https://example.com/image_1.png",
        url: "https://example.com/book_1",
      );

      final json = BookMapper.entityToJson(book);

      expect(json["title"], "Title 1");
      expect(json["subtitle"], "Subtitle 1");
      expect(json["isbn13"], "9876543210987");
      expect(json["price"], "\$24.99");
      expect(json["url"], "https://example.com/book_1");
    });
  });
}
