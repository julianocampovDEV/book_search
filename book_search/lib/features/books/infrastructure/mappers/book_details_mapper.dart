import 'package:book_search/features/books/domain/domain.dart';

class BookDetailsMapper {
  static BookDetails jsonToEntity(Map<String, dynamic> json) {
    return BookDetails(
      error: json["error"] ?? '',
      title: _formatData(json["title"]),
      subtitle: _formatData(json["subtitle"]),
      authors: _formatData(json["authors"]),
      publisher: _formatData(json["publisher"]),
      isbn10: _formatData(json["isbn10"]),
      isbn13: _formatData(json["isbn13"]),
      pages: _formatData(json["pages"]),
      year: _formatData(json["year"]),
      rating: _formatData(json["rating"]),
      desc: _formatData(json["desc"]),
      price: _formatData(json["price"]),
      image: json["image"] ?? '',
      url: _formatData(json["url"]),
      pdf: json["pdf"] != null ? Map<String, String>.from(json["pdf"]) : {},
    );
  }

  static Map<String, dynamic> entityToJson(BookDetails entity) {
    return {
      "error": entity.error,
      "title": entity.title,
      "subtitle": entity.subtitle,
      "authors": entity.authors,
      "publisher": entity.publisher,
      "isbn10": entity.isbn10,
      "isbn13": entity.isbn13,
      "pages": entity.pages,
      "year": entity.year,
      "rating": entity.rating,
      "desc": entity.desc,
      "price": entity.price,
      "image": entity.image,
      "url": entity.url,
      "pdf": entity.pdf,
    };
  }

  static String _formatData(String? data) {
    if (data == null || data == '') {
      return 'Unknown';
    } else {
      return data;
    }
  }
}
