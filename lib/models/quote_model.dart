class QuoteModel {
  int? quote_id;
  String quote_text;
  String quote_author;
  String quote_category;

  QuoteModel(
      {this.quote_id,
      required this.quote_text,
      required this.quote_author,
      required this.quote_category});

  factory QuoteModel.from(
      {required Map<String, dynamic> data, required String category}) {
    return QuoteModel(
      quote_text: data['quote'],
      quote_author: data['author'],
      quote_category: category,
    );
  }
}
