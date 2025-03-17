import 'package:flutter_test/flutter_test.dart';

import 'package:book_search/features/books/domain/domain.dart';
import 'package:book_search/features/books/infrastructure/infrastructure.dart';

void main() {
  group('BookDetailsMapper Tests', () {
    test('Should convert JSON to BookDetails entity', () {
      final Map<String, dynamic> mockJson = {
        "error": "0",
        "title": "Title 1",
        "subtitle": "Subtitle 1",
        "authors": "Authors 1",
        "publisher": "Publisher 1",
        "isbn10": "1234567890",
        "isbn13": "0987654321",
        "pages": "100",
        "year": "2000",
        "rating": "4.5",
        "desc": "Desc 1",
        "price": "\$10.99",
        "image": "https://example.com/image_1.png",
        "url": "https://example.com/book_1",
        "pdf": {
          "Chapter 1": "https://example.com/ch1.pdf",
          "Chapter 2": "https://example.com/ch2.pdf",
        },
      };

      final bookDetails = BookDetailsMapper.jsonToEntity(mockJson);

      expect(bookDetails.title, "Title 1");
      expect(bookDetails.subtitle, "Subtitle 1");
      expect(bookDetails.pdf.length, 2);
      expect(bookDetails.pdf["Chapter 1"], "https://example.com/ch1.pdf");
    });

    test('Should convert BookDetails entity to JSON', () {
      final bookDetails = BookDetails(
        error: "1",
        title: "Title 1",
        subtitle: "Subtitle 1",
        authors: "Authors 1",
        publisher: "Publisher 1",
        isbn10: "1111111111",
        isbn13: "2222222222",
        pages: "450",
        year: "2024",
        rating: "5.0",
        desc: "Desc 1",
        price: "\$39.99",
        image: "https://example.com/image_1.png",
        url: "https://example.com/book_1",
        pdf: {"Chapter 1": "https://example.com/ch1.pdf"},
      );

      final json = BookDetailsMapper.entityToJson(bookDetails);

      expect(json["authors"], "Authors 1");
      expect(json["publisher"], "Publisher 1");
      expect(json["isbn10"], "1111111111");
      expect(json["isbn13"], "2222222222");
      expect(json["pdf"]["Chapter 1"], "https://example.com/ch1.pdf");
    });

    test('Should handle missing or null jsonToEntity()', () {
      final Map<String, dynamic> mockJson = {
        "title": null,
        "subtitle": null,
        "authors": null,
        "publisher": null,
        "image": null,
        "url": null,
        "pdf": null,
      };

      final bookDetails = BookDetailsMapper.jsonToEntity(mockJson);

      expect(bookDetails.title, "Unknown");
      expect(bookDetails.subtitle, "Unknown");
      expect(bookDetails.image, "");
      expect(bookDetails.pdf.isEmpty, isTrue);
    });
  });
}
