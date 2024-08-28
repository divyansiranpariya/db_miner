import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splacescreen extends StatefulWidget {
  const Splacescreen({super.key});

  @override
  State<Splacescreen> createState() => _SplacescreenState();
}

class _SplacescreenState extends State<Splacescreen> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        Get.offNamed('/');
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://i.pinimg.com/originals/ed/d5/b9/edd5b94e1a62cef8e84ff76dab669d07.jpg"))),
        ),
      ),
    );
  }
}
