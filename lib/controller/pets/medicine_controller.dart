import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pawpal/models/pets/medicine.dart';

class MedicineController extends GetxController {
  var selectedDate = DateTime.now().obs;

  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController frequencyController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController instructionController = TextEditingController();

  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;
  Rx<DateTime> selectedEndDate = DateTime.now().obs;

  void pickTime(BuildContext context, Color cardColor) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.inputOnly,
      initialTime: selectedTime.value,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.white,
              hourMinuteColor: WidgetStateColor.resolveWith(
                (states) => Colors.white,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              confirmButtonStyle: ButtonStyle(
                textStyle: WidgetStateProperty.all(
                  const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                foregroundColor: WidgetStateProperty.all(cardColor),
                overlayColor: WidgetStateProperty.all(Colors.white),
              ),
              cancelButtonStyle: ButtonStyle(
                textStyle: WidgetStateProperty.all(
                  const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                foregroundColor: WidgetStateProperty.all(cardColor),
                overlayColor: WidgetStateProperty.all(Colors.white),
              ),
              helpTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
              inputDecorationTheme: const InputDecorationTheme(
                focusColor: Colors.black,
                contentPadding: EdgeInsets.all(2.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      selectedTime.value = pickedTime;
      if (!context.mounted) return;
      timeController.text = pickedTime.format(context);
    }
  }

  void pickEndDate(BuildContext context, Color cardColor) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2300),
      initialDate: selectedEndDate.value,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: DatePickerThemeData(
              backgroundColor: Colors.white,
              headerForegroundColor: Colors.black,
              todayForegroundColor: WidgetStateProperty.resolveWith(
                (states) => states.contains(WidgetState.selected)
                    ? Colors.white
                    : cardColor,
              ),
              todayBackgroundColor: WidgetStateProperty.resolveWith(
                (states) => states.contains(WidgetState.selected)
                    ? cardColor
                    : Colors.transparent,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              dayStyle: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              yearStyle: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: cardColor,
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      selectedEndDate.value = pickedDate;
      endDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  Future<void> addMedicine(String startDate, String name) async {
    Medicine medicine = Medicine(
      petName: name,
      name: nameController.text,
      dosage: int.tryParse(dosageController.text) ?? 0,
      frequency: frequencyController.text,
      time: timeController.text,
      startDate: startDateController.text,
      endDate: endDateController.text,
      instruction: instructionController.text,
    );

    try {
      await _firestore
          .collection('medicines')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('entries')
          .add(medicine.toJson());
      Get.back();
    } catch (_) {
      rethrow;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    dosageController.dispose();
    frequencyController.dispose();
    timeController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    instructionController.dispose();
    super.onClose();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  var medicines = <Medicine>[].obs;

  Future<void> fetchMedicineDetails() async {
    try {
      String userId = _firebaseAuth.currentUser?.uid ?? '';
      if (userId.isEmpty) {
        throw Exception('User not logged in');
      }

      _firestore
          .collection('medicines')
          .doc(userId)
          .collection('entries')
          .snapshots()
          .listen((snapshot) {
        medicines.assignAll(
            snapshot.docs.map((doc) => Medicine.fromJson(doc.data())).toList());
      });
    } catch (e) {
      rethrow;
    }
  }
}
