import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onstagoram/controller/bottom_navigation_controller.dart';
import 'package:onstagoram/widget/home.dart';
import 'package:onstagoram/widget/mock_data_provider.dart';
import 'package:onstagoram/widget/search.dart';

class OnstagoramBody extends StatelessWidget {
  final MockDataProvider dataProvider = MockDataProvider(userCount: UserCount);

  OnstagoramBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return switch (BottomNavigationController.to.activeView()) {
        BottomNavigation.home => HomeView(
            dataProvider: dataProvider,
          ),
        BottomNavigation.search => SearchView(dataProvider: dataProvider),
        _ => HomeView(
            dataProvider: dataProvider,
          ),
      };
    });
  }
}
