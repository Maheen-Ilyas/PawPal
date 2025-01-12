import 'package:flutter/material.dart';
import 'package:pawpal/controller/pets/pet_controller.dart';
import 'package:pawpal/view/widgets/custom_textfield.dart';

void showAddPetDialog(BuildContext context, PetController controller) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.0),
      ),
    ),
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
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
                    "Add Pet",
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
                  "Breed",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10.0),
                CustomTextField(
                  controller: controller.breedController,
                  hintText: "Breed",
                  obscureText: false,
                  prefixIcon: const Icon(Icons.category_rounded),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Gender (Male/Female)",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10.0),
                CustomTextField(
                  controller: controller.genderController,
                  hintText: "Gender",
                  obscureText: false,
                  prefixIcon: controller.genderController.text == "Male"
                      ? const Icon(Icons.male_rounded)
                      : controller.genderController.text == "Female"
                          ? const Icon(Icons.female_rounded)
                          : const Icon(Icons.question_mark_rounded),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Age",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10.0),
                CustomTextField(
                  controller: controller.ageController,
                  hintText: "Age",
                  obscureText: false,
                  prefixIcon: const Icon(Icons.cake_rounded),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Food Brand",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10.0),
                CustomTextField(
                  controller: controller.dietryHabitController,
                  hintText: "Food Brand",
                  obscureText: false,
                  prefixIcon: const Icon(Icons.food_bank_rounded),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Weight",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10.0),
                CustomTextField(
                  controller: controller.weightController,
                  hintText: "Weight",
                  obscureText: false,
                  prefixIcon: const Icon(Icons.scale_rounded),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Upload an image of your pet",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () => {
                    // controller.pickFile(controller.images),
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      "Upload",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.addPet();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfffea417),
                      overlayColor: const Color(0xfffea417),
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
      });
    },
  );
}
