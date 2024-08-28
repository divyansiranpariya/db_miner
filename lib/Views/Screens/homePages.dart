import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/navigator_controoler.dart';
import '../components/allQuotes.dart';
import '../components/category_page.dart';
import '../components/favourite_Page.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  late NavigationController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(NavigationController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (val) {
          controller.onPageChanged(val);
        },
        children: [
          QuotesPage(),
          categoryComponents(),
          FavouritesPage(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: (val) {
            controller.onDestinationSelected(val);
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.format_quote),
              label: " ",
            ),
            NavigationDestination(
              icon: Icon(Icons.category),
              label: " ",
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite),
              label: " ",
            ),
          ],
          elevation: 3,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.black, width: 2.0),
          ),
          indicatorColor: Colors.grey,
        ),
      ),
    );
  }
}
