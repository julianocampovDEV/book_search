class BookDetails {
  String error;
  String title;
  String subtitle;
  String authors;
  String publisher;
  String isbn10;
  String isbn13;
  String pages;
  String year;
  String rating;
  String desc;
  String price;
  String image;
  String url;
  Map<dynamic, dynamic> pdf;

  BookDetails({
    required this.error,
    required this.title,
    required this.subtitle,
    required this.authors,
    required this.publisher,
    required this.isbn10,
    required this.isbn13,
    required this.pages,
    required this.year,
    required this.rating,
    required this.desc,
    required this.price,
    required this.image,
    required this.url,
    required this.pdf,
  });
}
