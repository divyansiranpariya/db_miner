import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/api_model.dart';
import '../../utils/helper/api_helper.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  List<ApiQuoteModel> apiData = [];
  ApiQuoteModel? randomQuote;

  final List<Color> containerColors = [
    Color(0xff004650),
    Color(0xffF24B52),
    Color(0xff313843),
    Color(0xff336AED)
  ];

  @override
  void initState() {
    super.initState();
    random();
    apiQuotes();
  }

  apiQuotes() async {
    apiData = await ApiHelper.apiHelper.fetch();
    setState(() {});
  }

  random() async {
    randomQuote = await ApiHelper.apiHelper.RandomQuote();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Quotes",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeTheme(
                  Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
            },
            icon: Icon(
              Get.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: width * 0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Random Quote",
                  style: TextStyle(
                    fontSize: width / 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(
                      0xffF24B52,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: width * 0.02),
                  padding: EdgeInsets.all(width * 0.03),
                  child: (randomQuote == null)
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              randomQuote!.quote,
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '- ${randomQuote!.author}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Text(
                "More Quotes",
                style: TextStyle(
                  fontSize: width / 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
              SizedBox(height: height * 0.011),
              ...List.generate(
                apiData.length,
                (index) => (apiData.isEmpty)
                    ? const Center(
                        child: Text("No data available"),
                      )
                    : GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(
                              right: width * .02, bottom: height * .01),
                          decoration: BoxDecoration(
                            color:
                                containerColors[index % containerColors.length],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(width * 0.02),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apiData[index].quote,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '- ${apiData[index].author}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
