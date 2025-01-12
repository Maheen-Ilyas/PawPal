import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawpal/controller/pets/profile_controller.dart';
import 'package:pawpal/models/pets/pet.dart';
import 'package:pawpal/view/pets/widgets/detail_card.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
    required this.pet,
  });

  final Pet pet;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    controller.loadAboutText(widget.pet.name);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Pet Profile",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailCard(
                      widget: widget,
                      color: const Color.fromRGBO(239, 198, 195, 0.9),
                      heading: "Breed",
                      body: widget.pet.breed,
                    ),
                    const SizedBox(width: 16.0),
                    DetailCard(
                      widget: widget,
                      color: const Color.fromRGBO(169, 118, 184, 0.7),
                      heading: "Gender",
                      body: widget.pet.gender,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailCard(
                      widget: widget,
                      color: const Color.fromRGBO(255, 171, 117, 0.7),
                      heading: "Age",
                      body: widget.pet.age,
                    ),
                    const SizedBox(width: 16.0),
                    DetailCard(
                      widget: widget,
                      color: const Color.fromRGBO(105, 167, 145, 0.7),
                      heading: "Food Brands",
                      body: widget.pet.dietryHabit,
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "About",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.toggleEditing();
                      },
                      child: const Icon(Icons.edit_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Obx(() {
                  return controller.isEditing.value
                      ? TextField(
                          controller: controller.aboutController,
                          maxLines: 5,
                          onChanged: (text) {
                            controller.aboutText.value = text;
                          },
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          cursorColor: Colors.black87,
                          decoration: InputDecoration(
                            hintText: "About ${widget.pet.name}",
                            hintStyle: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.black87,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.black87,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        )
                      : Text(
                          controller.aboutText.value.isEmpty
                              ? 'No details available'
                              : controller.aboutText.value,
                          style: const TextStyle(fontSize: 14.0),
                        );
                }),
                const SizedBox(height: 20.0),
                Obx(() {
                  return controller.isEditing.value
                      ? SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.saveAboutText(
                                widget.pet.name,
                                controller.aboutController.text,
                              );
                              controller.toggleEditing();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(255, 117, 120, 1),
                              overlayColor: const Color(0xffFF7578),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
