import 'package:get/get.dart';
import 'package:onstagoram/log.dart';

enum BottomNavigation { home, search }

class BottomNavigationController extends GetxController {
  static BottomNavigationController get to => Get.find();

  final _index = 0.obs;

  int get index => _index.value;

  void tap(int newIndex) {
    _index.value = newIndex;
    Log.s.d('${BottomNavigation.values[_index.value]} selected');
  }

  BottomNavigation activeView() {
    return BottomNavigation.values[_index.value];
  }
}
