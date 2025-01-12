import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pawpal/models/lostfound/lostfound.dart';

class LostFoundController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController petColorController = TextEditingController();
  final TextEditingController lastLocationController = TextEditingController();
  final TextEditingController ownerPhoneNumberController =
      TextEditingController();
  final TextEditingController rewardController = TextEditingController();

  final _firestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  var complaints = [].obs;

  Future<void> addComplaint(String selectedComplaint) async {
    Complaint complaint = Complaint(
      type: selectedComplaint,
      name: nameController.text,
      petName: petNameController.text,
      breed: breedController.text,
      petColor: petColorController.text,
      lastLocation: lastLocationController.text,
      phoneNumber: ownerPhoneNumberController.text,
      reward: rewardController.text,
    );
    try {
      await _firestore
          .collection('complaints')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('entries')
          .add(complaint.toJson());
      Get.back();
    } catch (_) {
      rethrow;
    }
    nameController.clear();
    petNameController.clear();
    breedController.clear();
    petColorController.clear();
    lastLocationController.clear();
    ownerPhoneNumberController.clear();
    rewardController.clear();
  }

  Future<void> fetchComplaintDetails() async {
    try {
      String userId = _firebaseAuth.currentUser?.uid ?? '';
      if (userId.isEmpty) {
        throw Exception('User not logged in');
      }

      _firestore
          .collection('complaints')
          .doc(userId)
          .collection('entries')
          .snapshots()
          .listen((snapshot) {
        complaints.assignAll(snapshot.docs
            .map((doc) => Complaint.fromJson(doc.data()))
            .toList());
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    petNameController.dispose();
    breedController.dispose();
    petColorController.dispose();
    lastLocationController.dispose();
    ownerPhoneNumberController.dispose();
    rewardController.dispose();
    super.onClose();
  }
}
