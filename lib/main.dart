import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Views/Screens/detail_page.dart';
import 'Views/Screens/splaceScreen_page.dart';
import 'Views/components/favourite_Page.dart';
import 'Views/Screens/homePages.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'Splacescreen',
    getPages: [
      GetPage(name: '/', page: () => HomePages()),
      GetPage(name: '/Splacescreen', page: () => Splacescreen()),
      GetPage(name: '/FavouritesPage', page: () => FavouritesPage()),
      GetPage(name: '/DetailPage', page: () => DetailPage()),
    ],
  ));
}
