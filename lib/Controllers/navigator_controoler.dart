import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class NavigationController extends GetxController {
  RxInt currentIndex = 0.obs;
  PageController pageController = PageController();

  var pages = <Widget>[].obs;
  var destinations = <NavigationDestination>[].obs;

  void addPage(Widget page, NavigationDestination destination) {
    pages.add(page);
    destinations.add(destination);
    update();
  }

  void removePage(int index) {
    if (pages.length > 0 && index < pages.length) {
      pages.removeAt(index);
      destinations.removeAt(index);
      if (currentIndex.value >= pages.length) {
        currentIndex.value = pages.length - 1;
      }
      update();
    }
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void onDestinationSelected(int index) {
    currentIndex.value = index;
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 400), curve: Curves.bounceInOut);
  }
}
