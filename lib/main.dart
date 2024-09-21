import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Views/Screens/detail_page.dart';
import 'Views/Screens/splaceScreen_page.dart';
import 'Views/components/favourite_Page.dart';
import 'Views/Screens/homePages.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'Splace_screen',
    getPages: [
      GetPage(name: '/', page: () => HomePages()),
      GetPage(name: '/Splace_screen', page: () => Splacescreen()),
      GetPage(name: '/Favourites_page', page: () => FavouritesPage()),
      GetPage(name: '/Detail_page', page: () => DetailPage()),
    ],
  ));
}
