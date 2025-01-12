import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  RxBool isEditing = false.obs;
  RxString aboutText = ''.obs;  
  TextEditingController aboutController = TextEditingController();

  void loadAboutText(String petName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    aboutText.value = prefs.getString('about_$petName') ?? ''; 
    aboutController.text = aboutText.value;
  }

  void saveAboutText(String petName, String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('about_$petName', text);
    aboutText.value = text;
  }

  void toggleEditing() {
    isEditing.value = !isEditing.value;
  }
}
