import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/quote_model.dart';

class JsonHelper {
  JsonHelper._();

  static final JsonHelper jsonHelper = JsonHelper._();
  Future<List<QuoteModel>> getJsonData() async {
    String jsonData =
        await rootBundle.loadString("assets/json/quote_jsondata.json");
    List data = jsonDecode(jsonData);

    List<QuoteModel> getData = [];

    data.map((e) {
      String category = e['name'];
      List<QuoteModel> quote = e['quotes'].map<QuoteModel>((val) {
        return QuoteModel.from(data: val, category: category);
      }).toList();
      getData.addAll(quote);
    }).toList();
    return getData;
  }
}
