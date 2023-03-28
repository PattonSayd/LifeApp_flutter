import 'package:get/get.dart';
import 'package:lifeapp/pages/shopping_list/create/shopping_list_item.dart';

class CreateShoppingListController extends GetxController {
  RxList<ShoppingListItem> shoppingList = RxList();

  void addToList(String name, String count) {
    ShoppingListItem shoppingListItem =
        new ShoppingListItem(name: name, count: count);
    shoppingList.add(shoppingListItem);
    shoppingList.refresh();
  }
}
