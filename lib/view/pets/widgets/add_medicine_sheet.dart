import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawpal/controller/pets/medicine_controller.dart';
import 'package:pawpal/models/pets/pet.dart';
import 'package:pawpal/view/widgets/custom_textfield.dart';

void showAddMedicineDialog(BuildContext context, MedicineController controller,
    Color cardColor, Pet pet) {
  controller.startDateController.text =
      DateFormat('yyyy-MM-dd').format(controller.selectedDate.value);
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.0),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Add Medicine",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Name",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: controller.nameController,
                hintText: "Name",
                obscureText: false,
                prefixIcon: const Icon(Icons.pets_rounded),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Dosage",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: controller.dosageController,
                hintText: "Dosage",
                obscureText: false,
                prefixIcon: const Icon(Icons.medication_rounded),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Frequency",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: controller.frequencyController,
                hintText: "Frequency",
                obscureText: false,
                prefixIcon: const Icon(Icons.repeat_rounded),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Time",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: controller.timeController,
                hintText: "Time",
                obscureText: false,
                prefixIcon: GestureDetector(
                  onTap: () {
                    controller.pickTime(context, cardColor);
                  },
                  child: const Icon(Icons.schedule_rounded),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Start Date",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        CustomTextField(
                          controller: TextEditingController(
                            text: DateFormat('yyyy-MM-dd')
                                .format(controller.selectedDate.value),
                          ),
                          hintText: "Start Date",
                          obscureText: false,
                          prefixIcon: const Icon(Icons.calendar_today_rounded),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "End Date",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        CustomTextField(
                          controller: controller.endDateController,
                          hintText: "End Date",
                          obscureText: false,
                          prefixIcon: GestureDetector(
                            onTap: () {
                              controller.pickEndDate(context, cardColor);
                            },
                            child: const Icon(Icons.calendar_month_rounded),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Instructions",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10.0),
              CustomTextField(
                controller: controller.instructionController,
                hintText: "Instructions",
                obscureText: false,
                prefixIcon: const Icon(Icons.notes),
              ),
              const SizedBox(height: 24.0),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    controller.addMedicine(
                        DateFormat('yyyy-MM-dd')
                            .format(controller.selectedDate.value),
                        pet.name);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cardColor,
                    overlayColor: cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      );
    },
  );
}
