import 'package:flutter/material.dart';
import 'package:db_miner/models/quote_model.dart';
import 'package:db_miner/utils/helper/json_helper.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class categoryComponents extends StatefulWidget {
  const categoryComponents({super.key});

  @override
  State<categoryComponents> createState() => _categoryComponentsState();
}

class _categoryComponentsState extends State<categoryComponents> {
  List<QuoteModel> getQuotes = [];
  List<QuoteModel> filteredQuotes = [];
  List<String> categories = [];
  String selectedCategory = '';
  final List<Color> containerColors = [
    Color(0xff004650),
    Color(0xffF24B52),
    Color(0xff313843),
    Color(0xff336AED)
  ];

  @override
  void initState() {
    super.initState();
    getJsonQuote();
  }

  Future<void> getJsonQuote() async {
    List<QuoteModel> quotes = await JsonHelper.jsonHelper.getJsonData();

    categories = quotes.map((quote) => quote.quote_category).toSet().toList();

    setState(() {
      getQuotes = quotes;
      filteredQuotes = getQuotes;
    });
  }

  void filterQuotesByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category.isEmpty) {
        filteredQuotes = getQuotes;
      } else {
        filteredQuotes = getQuotes
            .where((quote) => quote.quote_category == category)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 14,
          left: 14,
        ),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.07,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  String category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      filterQuotesByCategory(category);
                    },
                    child: Card(
                      elevation: 2,
                      color: selectedCategory == category
                          ? Colors.blueAccent
                          : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            // Display quotes based on selected category
            Expanded(
              child: filteredQuotes.isEmpty
                  ? Center(
                      child: Text(
                        'No quotes available for this category',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 5 / 7,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15),
                      itemCount: filteredQuotes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed('/Detail_page',
                                arguments: filteredQuotes[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: containerColors[
                                    index % containerColors.length],
                                borderRadius: BorderRadius.circular(20)),
                            alignment: Alignment.center,
                            child: ListTile(
                              title: Text(
                                filteredQuotes[index].quote_text,
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                '- ${filteredQuotes[index].quote_author}',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
