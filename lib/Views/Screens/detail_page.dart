import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:db_miner/models/quote_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import '../../utils/helper/db_helper.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkIfFavorite();
  }

  final GlobalKey _globalKey = GlobalKey();

  Future<void> shareImage() async {
    try {
      RenderRepaintBoundary renderRepaintBoundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      var image = await renderRepaintBoundary.toImage(pixelRatio: 5);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List fetchImage = byteData!.buffer.asUint8List();

      Directory directory = await getApplicationDocumentsDirectory();
      String path = directory.path;
      File file = File('$path/screenshot.png');

      await file.writeAsBytes(fetchImage);

      ShareExtend.share(file.path, "image");
    } catch (e) {
      print("Error sharing image: $e");
    }
  }

  void checkIfFavorite() async {
    QuoteModel data = ModalRoute.of(context)!.settings.arguments as QuoteModel;
    List<QuoteModel> favorites = await DBHelper.dbHelper.getFavourites();
    setState(() {
      isFavorite = favorites.any((quote) => quote.quote_id == data.quote_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    QuoteModel data = ModalRoute.of(context)!.settings.arguments as QuoteModel;

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(
          "Quote Details",
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            RepaintBoundary(
              child: RepaintBoundary(
                key: _globalKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  height: 600,
                  width: 340,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.pink,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "”",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 90),
                            ),
                            Text(
                              "${data.quote_text}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "- ${data.quote_author}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: IconButton(
                                  onPressed: () async {
                                    if (isFavorite) {
                                      await DBHelper.dbHelper
                                          .removequote(data.quote_id!);
                                      setState(() {
                                        isFavorite = false;
                                      });
                                      Get.snackbar(
                                        "Removed",
                                        "Removed from Favorites!",
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                    } else {
                                      // Add to favorites
                                      await DBHelper.dbHelper
                                          .insertFavourite(quoteModel: data);
                                      setState(() {
                                        isFavorite = true;
                                      });
                                      Get.snackbar(
                                        "Success",
                                        "Added to Favorites!",
                                        backgroundColor: Colors.green,
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    color: Colors.red,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    shareImage();
                                  },
                                  icon: Icon(
                                    Icons.share,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
