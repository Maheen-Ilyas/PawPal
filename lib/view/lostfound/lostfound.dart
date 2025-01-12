import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawpal/controller/lostfound/lostfound_controller.dart';
import 'package:pawpal/view/lostfound/widgets/complaint_card.dart';
import 'package:pawpal/view/widgets/custom_textfield.dart';
import 'package:pawpal/view/widgets/custom_title.dart';

class LostFound extends StatefulWidget {
  const LostFound({super.key});

  @override
  State<LostFound> createState() => _LostFoundState();
}

class _LostFoundState extends State<LostFound> {
  final controller = Get.put(LostFoundController());

  List<String> type = [
    "Lost",
    "Found",
  ];

  String selectedComplaint = "Lost";

  void onChanged(String? complaint) {
    setState(() {
      selectedComplaint = complaint!;
    });
  }

  @override
  void initState() {
    controller.fetchComplaintDetails();
    super.initState();
  }

  void openLostFoundSheet(BuildContext context, LostFoundController controller,
      String selectedComplaint) {
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
                      "Add Complaint",
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Select type of complaint",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "Type of Complaint",
                      hintStyle: const TextStyle(
                        fontSize: 14.0,
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
                    value: selectedComplaint,
                    items: type.map((String complaint) {
                      return DropdownMenuItem<String>(
                        value: complaint,
                        child: Text(
                          complaint,
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: onChanged,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    selectedComplaint == "Found"
                        ? "Finder's Name"
                        : "Owner's Name",
                    style: const TextStyle(
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
                    prefixIcon: const Icon(Icons.person_rounded),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Pet's Name",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                    controller: controller.petNameController,
                    hintText: "Pet's Name",
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
                  Text(
                    selectedComplaint == "Found"
                        ? "Found Location"
                        : "Last Location",
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                    controller: controller.lastLocationController,
                    hintText: selectedComplaint == "Found"
                        ? "Found Location"
                        : "Last Location",
                    obscureText: false,
                    prefixIcon: const Icon(Icons.location_city_rounded),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Phone Number",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                    controller: controller.ownerPhoneNumberController,
                    hintText: "Phone Number",
                    obscureText: false,
                    prefixIcon: const Icon(Icons.phone_rounded),
                  ),
                  selectedComplaint == "Found"
                      ? Container()
                      : const SizedBox(height: 16.0),
                  selectedComplaint == "Found"
                      ? Container()
                      : const Text(
                          "Reward",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  selectedComplaint == "Found"
                      ? Container()
                      : const SizedBox(height: 10.0),
                  selectedComplaint == "Found"
                      ? Container()
                      : CustomTextField(
                          controller: controller.rewardController,
                          hintText: "Reward",
                          obscureText: false,
                          prefixIcon: const Icon(Icons.money_rounded),
                        ),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.addComplaint(selectedComplaint);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomTitle(
          screenTitle: "Lost and Found",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    openLostFoundSheet(context, controller, selectedComplaint);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xfffea417),
                    overlayColor: const Color(0xfffea417),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Register complaint",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Obx(() {
                if (controller.complaints.isEmpty) {
                  return const Center(
                    child: Text('No complaints registered.'),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.complaints.length,
                    itemBuilder: (context, index) {
                      final complaint = controller.complaints[index];
                      return ComplaintCard(complaint: complaint);
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
