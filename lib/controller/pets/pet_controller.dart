import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pawpal/models/pets/pet.dart';

class PetController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController dietryHabitController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final String image = "";

  @override
  void onClose() {
    nameController.dispose();
    breedController.dispose();
    genderController.dispose();
    ageController.dispose();
    dietryHabitController.dispose();
    weightController.dispose();
    super.onClose();
  }

  Future<void> addPet() async {
    Pet pet = Pet(
      name: nameController.text,
      breed: breedController.text,
      gender: genderController.text,
      age: ageController.text,
      dietryHabit: dietryHabitController.text,
      weight: double.tryParse(weightController.text) ?? 0.0,
    );

    try {
      await _firestore
          .collection('pets')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('entries')
          .add(pet.toJson());
      Get.back();
    } catch (_) {
      rethrow;
    }
    nameController.clear();
    breedController.clear();
    genderController.clear();
    ageController.clear();
    dietryHabitController.clear();
    weightController.clear();
  }
}
