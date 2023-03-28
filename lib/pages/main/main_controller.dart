import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController {
  RxInt pageIndex = 0.obs;

  void onItemTapped(int index) {
    pageIndex.value = index;
    saveLastScreen(index);
  }

  void saveLastScreen(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('lastScreen', index);
  }

  void getLastScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lastPage = prefs.getInt('lastScreen') ?? 0;
    pageIndex.value = lastPage;
  }

  @override
  void onInit() {
    super.onInit();
    getLastScreen();
  }
}
