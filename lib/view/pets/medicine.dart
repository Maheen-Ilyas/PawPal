import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pawpal/controller/pets/medicine_controller.dart';
import 'package:pawpal/models/pets/pet.dart';
import 'package:pawpal/view/pets/widgets/add_medicine_sheet.dart';
import 'package:pawpal/view/pets/widgets/medicine_card.dart';

class Medicine extends StatefulWidget {
  const Medicine({
    super.key,
    required this.pet,
    required this.cardColor,
  });

  final Pet pet;
  final Color cardColor;

  @override
  State<Medicine> createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  final controller = Get.put(MedicineController());
  final DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    controller.fetchMedicineDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Medicines",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20.0),
              EasyDateTimeLine(
                activeColor: widget.cardColor,
                initialDate: controller.selectedDate.value,
                onDateChange: (date) {
                  controller.setSelectedDate(date);
                },
                dayProps: const EasyDayProps(
                  inactiveDayStyle: DayStyle(
                    monthStrStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                    dayStrStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    showAddMedicineDialog(
                        context, controller, widget.cardColor, widget.pet);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.cardColor,
                    overlayColor: widget.cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Add Medicine",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: Divider(
                  color: Colors.black54,
                ),
              ),
              Obx(
                () {
                  final filteredMedicines =
                      controller.medicines.where((medicine) {
                    final medicineEndDate =
                        DateFormat('yyyy-MM-dd').parse(medicine.endDate);
                    final medicineStartDate =
                        DateFormat('yyyy-MM-dd').parse(medicine.startDate);
                    return medicine.petName == widget.pet.name &&
                        controller.selectedDate.value.isAfter(medicineStartDate
                            .subtract(const Duration(days: 1))) &&
                        controller.selectedDate.value.isBefore(
                            medicineEndDate.add(const Duration(days: 1)));
                  }).toList();

                  if (filteredMedicines.isEmpty) {
                    return const Center(
                      child: Text('No medicines for this pet.'),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: filteredMedicines.length,
                      itemBuilder: (context, index) {
                        final medicine = filteredMedicines[index];
                        return MedicineCard(
                          medicine: medicine,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
