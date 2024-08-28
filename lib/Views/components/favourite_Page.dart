import 'package:db_miner/models/quote_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/db_helper.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  final List<Color> containerColors = [
    Color(0xff004650),
    Color(0xffF24B52),
    Color(0xff313843),
    Color(0xff336AED)
  ];

  get filteredQuotes => null;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Delete AllData"),
                        content: Text("Are you sure delete all data"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text("cancel")),
                          TextButton(
                              onPressed: () {
                                Get.back();
                                DBHelper.dbHelper.removeAllQuote();
                                setState(() {});
                              },
                              child: Text("yes")),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.delete))
        ],
        centerTitle: true,
      ),
      body: FutureBuilder<List<QuoteModel>>(
        future: DBHelper.dbHelper.getFavourites(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error loading favorites"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 6 / 4),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                QuoteModel quote = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed('/DetailPage', arguments: quote);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 14, left: 14),
                    decoration: BoxDecoration(
                        color: containerColors[index % containerColors.length],
                        borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                quote.quote_text,
                                style: TextStyle(color: Colors.white),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "- ${quote.quote_author}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/DetailPage',
                                arguments: quote);
                          },
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  DBHelper.dbHelper
                                      .removequote(quote.quote_id!);
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.copy,
                                  color: Colors.white,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("No favorites added yet.."));
          }
        },
      ),
    );
  }
}
