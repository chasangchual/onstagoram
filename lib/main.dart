import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onstagoram/app_getx_binding.dart';
import 'package:onstagoram/body.dart';
import 'package:onstagoram/controller/bottom_navigation_controller.dart';

void main() {
  Get.put(BottomNavigationController());
  runApp(OnstagoramApp());
}

class OnstagoramApp extends StatelessWidget {
  const OnstagoramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        initialBinding: AppBinding(),
        theme: ThemeData(
            colorScheme: const ColorScheme.light(primary: Colors.white, secondary: Colors.black),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                showSelectedLabels: false, showUnselectedLabels: false, selectedItemColor: Colors.black),
            useMaterial3: true),
        home: Scaffold(
          appBar: BottomNavigationController.to.activeView() == BottomNavigation.home
              ? AppBar(
                  title: Text("Onstagoram", style: GoogleFonts.lobsterTwo(color: Colors.black, fontSize: 24)),
                  centerTitle: false,
                  actions: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline)),
                    IconButton(
                      icon: Icon(CupertinoIcons.paperplane),
                      onPressed: () {},
                    )
                  ],
                )
              : null,
          body: OnstagoramBody(),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 28,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.search, size: 28), label: 'Search')
            ],
            onTap: (index) {
              BottomNavigationController.to.tap(index);
            },
          ),
        ),
      );
    });
  }
}
