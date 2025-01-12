import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawpal/controller/pets/pet_controller.dart';
import 'package:pawpal/models/pets/pet.dart';
import 'package:pawpal/view/pets/widgets/add_pet_sheet.dart';
import 'package:pawpal/view/pets/widgets/pet_card.dart';
import 'package:pawpal/view/widgets/custom_title.dart';

class Pets extends StatefulWidget {
  const Pets({super.key});

  @override
  State<Pets> createState() => _PetsState();
}

class _PetsState extends State<Pets> {
  final controller = Get.put(PetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomTitle(screenTitle: "Pets"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('pets')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('entries')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xffB35255),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          "Error loading pets",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text(
                          "No pets found",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }

                    List<Pet> pets = snapshot.data!.docs
                        .map((doc) =>
                            Pet.fromJson(doc.data() as Map<String, dynamic>))
                        .toList();

                    return ListView.builder(
                      itemCount: pets.length + 1,
                      itemBuilder: (context, index) {
                        if (index == pets.length) {
                          return SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                showAddPetDialog(context, controller);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(255, 117, 120, 1.0),
                                overlayColor: const Color(0xffFF7578),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: const Icon(
                                Icons.add_rounded,
                                color: Colors.white,
                                size: 24.0,
                              ),
                              label: const Text(
                                "Add Pet",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }
                        Pet pet = pets[index];

                        Color cardColor;
                        switch (index % 3) {
                          case 0:
                            cardColor = const Color.fromRGBO(179, 82, 85, 1.0);
                            break;
                          case 1:
                            cardColor =
                                const Color.fromRGBO(255, 171, 117, 1.0);
                            break;
                          case 2:
                            cardColor =
                                const Color.fromRGBO(169, 118, 184, 1.0);
                            break;
                          default:
                            cardColor = Colors.white;
                        }
                        return PetCard(
                          pet: pet,
                          cardColor: cardColor,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
