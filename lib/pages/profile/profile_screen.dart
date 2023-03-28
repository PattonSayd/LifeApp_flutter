import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:lifeapp/pages/profile/profile_controller.dart';
import 'package:lifeapp/pages/profile/user.dart';
import 'package:lifeapp/widgets/custom_button.dart';
import 'package:lifeapp/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/colors.dart';
import '../../localization/languages/languages.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

TextEditingController nameTec = TextEditingController();
TextEditingController addressTec = TextEditingController();
TextEditingController workTec = TextEditingController();
TextEditingController genderTec = TextEditingController();

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    setUser();
  }

  void setUser() async {
    await profileController.getUser();
    nameTec.text = profileController.user.value!.name!;
    addressTec.text = profileController.user.value!.address!;
    workTec.text = profileController.user.value!.work!;
    genderTec.text = profileController.user.value!.gender!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            behavior: HitTestBehavior.opaque,
            child: Icon(Icons.arrow_back_ios)),
        title: defaultText(Languages.of(context)!.profile, color: Colors.white, fontSize: 18),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNameSection(),
              SizedBox(
                height: 20,
              ),
              _buildAddressSection(),
              SizedBox(
                height: 20,
              ),
              _buildWorkSection(),
              SizedBox(
                height: 20,
              ),
              _buildGenderSection(),
              SizedBox(
                height: 40,
              ),
              _buildSave(),
              SizedBox(
                height: 20,
              ),
              _buildLogout(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        defaultText(Languages.of(context)!.enterName, fontWeight: FontWeight.w400),
        SizedBox(
          height: 10,
        ),
        CustomTextField(
          controller: nameTec,
          hint: Languages.of(context)!.name,
          padding: EdgeInsets.symmetric(horizontal: 20),
          hintStyle: TextStyle(
            fontSize: 17.csp,
            fontWeight: FontWeight.w400,
            height: 22.ch / 17.csp,
            color: CustomColors.tertiaryLight,
          ),
          hasBorder: true,
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        defaultText(Languages.of(context)!.enterAddress, fontWeight: FontWeight.w400),
        SizedBox(
          height: 10,
        ),
        CustomTextField(
          controller: addressTec,
          hint: Languages.of(context)!.address,
          hasBorder: true,
          textInputAction: TextInputAction.done,
          padding: EdgeInsets.symmetric(horizontal: 20),
        )
      ],
    );
  }

  Widget _buildWorkSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        defaultText(Languages.of(context)!.enterWork, fontWeight: FontWeight.w400),
        SizedBox(
          height: 10,
        ),
        CustomTextField(
          controller: workTec,
          hint: Languages.of(context)!.work,
          textInputAction: TextInputAction.done,
          padding: EdgeInsets.symmetric(horizontal: 20),
        )
      ],
    );
  }

  Widget _buildGenderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        defaultText(Languages.of(context)!.selectGender, fontWeight: FontWeight.w400),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.5),width: 0.5),
              borderRadius: BorderRadius.circular(8)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              items: [
                new DropdownMenuItem(
                  child: new Text(Languages.of(context)!.male),
                  value: "Male",
                ),
                new DropdownMenuItem(
                  child: new Text(Languages.of(context)!.female),
                  value: "Female",
                ),
              ],
              hint: new Text(Languages.of(context)!.selectGender),
              value: genderTec.text != '' ? genderTec.text : 'Male',
              onChanged: (value) {
                setState(() {
                  genderTec.text = value.toString();
                });
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSave() {
    return Obx(() => CustomButton(
        onPressed: () async {
          User user = User(
              address: addressTec.text,
              work: workTec.text,
              name: nameTec.text,
              gender: genderTec.text);
          profileController.save(user);
        },
        loading: profileController.saveLoading.value,
        width: MediaQuery.of(context).size.width,
        text: Languages.of(context)!.save));
  }

  Widget _buildLogout() {
    return CustomButton(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("logined", false);
          Navigator.pushNamedAndRemoveUntil(
              context, '/pages.login', (route) => false);
        },
        width: MediaQuery.of(context).size.width,
        text: Languages.of(context)!.logout);
  }
}
