import 'package:db_miner/models/quote_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';

import '../../models/api_model.dart';

class ApiHelper {
  ApiHelper._();

  static ApiHelper apiHelper = ApiHelper._();

  fetch() async {
    String Url = "https://dummyjson.com/quotes/";
    http.Response response = await http.get(Uri.parse(Url));

    if (response.statusCode == 200) {
      Map decodedData = jsonDecode(response.body);
      List quote = decodedData['quotes'];
      List data = quote.map((e) => ApiQuoteModel.fromMap(data: e)).toList();
      return data;
    }
  }

  RandomQuote() async {
    String Url = "https://dummyjson.com/quotes/random";
    http.Response response = await http.get(Uri.parse(Url));

    if (response.statusCode == 200) {
      Map decodedData = jsonDecode(response.body);
      log(decodedData.toString());
      ApiQuoteModel randomQuote = ApiQuoteModel.fromMap(
        data: decodedData,
      );
      return randomQuote;
    }
  }
}
