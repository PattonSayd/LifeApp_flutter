import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/pages/shopping_list/create/create_shopping_list_controller.dart';
import 'package:lifeapp/pages/shopping_list/create/shopping_list_item.dart';
import 'package:lifeapp/widgets/custom_button.dart';

class CreateShoppingListScreen extends StatefulWidget {
  const CreateShoppingListScreen({Key? key}) : super(key: key);

  @override
  State<CreateShoppingListScreen> createState() =>
      _CreateShoppingListScreenState();
}

class _CreateShoppingListScreenState extends State<CreateShoppingListScreen> {
  final CreateShoppingListController controller =
  Get.put(CreateShoppingListController());

  final TextEditingController nameTec = TextEditingController();
  final TextEditingController countTec = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    Get.delete<CreateShoppingListController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() =>
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.shoppingList.length,
                        itemBuilder: (context, index) {
                          return _buildShoppingListItem(
                              controller.shoppingList[index]);
                        })),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 6,
                          child: TextField(
                            controller: nameTec,
                            decoration: InputDecoration(
                                hintText: Languages.of(context)!.productName,
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 20),
                                border: InputBorder.none),
                          )),
                      Expanded(
                          flex: 3,
                          child: TextField(
                            controller: countTec,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: Languages.of(context)!.count,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: CustomColors.border,
                                  ),
                                )),
                          )),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                              onTap: () {
                                controller.addToList(
                                    nameTec.text, countTec.text);
                              },
                              child:
                              SvgPicture.asset(Assets.addToShoppingList)))
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CustomButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return UsersBottomSheet();
                          });
                    },
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    text: Languages.of(context)!.send)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShoppingListItem(ShoppingListItem shoppingListItem) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery
          .of(context)
          .size
          .width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: CustomColors.primary)),
      child: Row(
        children: [
          Expanded(
              flex: 6,
              child: defaultText(shoppingListItem.name!,
                  color: Color(0xFF251031),
                  fontSize: 16,
                  fontWeight: FontWeight.w400)),
          Expanded(
              flex: 3,
              child: Container(
                height: 38,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: CustomColors.primary)),
                child: Center(
                  child: defaultText(shoppingListItem.count!,
                      color: Color(0xFF251031),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              )),
          Expanded(flex: 1, child: SvgPicture.asset(Assets.done))
        ],
      ),
    );
  }
}

class UsersBottomSheet extends StatefulWidget {
  const UsersBottomSheet({Key? key}) : super(key: key);

  @override
  State<UsersBottomSheet> createState() => _UsersBottomSheetState();
}

class _UsersBottomSheetState extends State<UsersBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8), topLeft: Radius.circular(8))),
      child: Column(
        children: [
          _buildUserItem(),
          _buildUserItem(),
          _buildUserItem(),
        ],
      ),
    );
  }

  Widget _buildUserItem() {
    return Container(
      height: 65,
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                Assets.person,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              )),
          SizedBox(width: 12),
          defaultText('Ata',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: CustomColors.hintText)
        ],
      ),
    );
  }
}
