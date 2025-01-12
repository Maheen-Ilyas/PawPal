import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawpal/controller/home/home_controller.dart';
import 'package:pawpal/models/pets/medicine.dart';
import 'package:pawpal/models/pets/pet.dart';
import 'package:pawpal/view/pets/widgets/medicine_card.dart';
import 'package:pawpal/view/pets/widgets/pet_card.dart';
import 'package:pawpal/view/widgets/custom_title.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(HomeController());
  int currentPage = 0;

  void showSOSDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Emergency Hotline',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'If you need immediate assistance, call the hotline below:',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                const hotlineNumber = 'tel:1962';
                if (await canLaunchUrl(Uri.parse(hotlineNumber))) {
                  await launchUrl(Uri.parse(hotlineNumber));
                } else {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Could not launch phone call.'),
                    ),
                  );
                }
              },
              icon: const Icon(
                Icons.phone,
                color: Colors.white,
                size: 20.0,
              ),
              label: const Text(
                'Call Now',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade900,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.9;
    double cardSpacing = screenWidth * 0.05;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomTitle(screenTitle: "Home"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilledButton(
              onPressed: () {
                showSOSDialog(context);
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size(20.0, 30.0),
                backgroundColor: Colors.red.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Icon(
                Icons.sos_rounded,
                size: 22.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.toNamed('/chat');
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Color(0xfffea417),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.chat_bubble_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  child: SizedBox(
                    width: double.infinity,
                    height: 160.0,
                    child: PageView(
                      controller: controller.pageController,
                      onPageChanged: (page) {
                        setState(() {
                          currentPage = page;
                        });
                      },
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 8.0),
                          child: Image.asset(
                            'assets/header.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 8.0),
                          child: Image.asset(
                            'assets/header1.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Center(
                  child: SmoothPageIndicator(
                    controller: controller.pageController,
                    count: 2,
                    effect: const WormEffect(
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      spacing: 16.0,
                      radius: 16.0,
                      dotColor: Colors.grey,
                      activeDotColor: Color(0xfffea417),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "My Pets",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  height: 140.0,
                  width: double.infinity,
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
                        scrollDirection: Axis.horizontal,
                        itemCount: pets.length,
                        itemBuilder: (context, index) {
                          Pet pet = pets[index];

                          Color cardColor;
                          switch (index % 3) {
                            case 0:
                              cardColor =
                                  const Color.fromRGBO(179, 82, 85, 1.0);
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

                          return Padding(
                            padding: EdgeInsets.only(right: cardSpacing),
                            child: SizedBox(
                              width: cardWidth,
                              child: PetCard(
                                pet: pet,
                                cardColor: cardColor,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  "Medicines",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  height: 160.0,
                  width: double.infinity,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('medicines')
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
                            "Error loading medicines",
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
                            "No medicines found",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }

                      List<Medicine> medicines = snapshot.data!.docs
                          .map((doc) => Medicine.fromJson(
                              doc.data() as Map<String, dynamic>))
                          .toList();

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: medicines.length,
                        itemBuilder: (context, index) {
                          Medicine medicine = medicines[index];

                          return Padding(
                            padding: EdgeInsets.only(right: cardSpacing),
                            child: SizedBox(
                              width: cardWidth,
                              child: MedicineCard(
                                medicine: medicine,
                              ),
                            ),
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
      ),
    );
  }
}
