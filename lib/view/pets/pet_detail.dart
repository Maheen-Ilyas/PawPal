import 'package:flutter/material.dart';
import 'package:pawpal/models/navbar/nav_item.dart';
import 'package:pawpal/models/pets/pet.dart';
import 'package:pawpal/view/pets/emergency_guide.dart';
import 'package:pawpal/view/pets/food.dart';
import 'package:pawpal/view/pets/medicine.dart';
import 'package:pawpal/view/pets/profile.dart';

class PetDetail extends StatefulWidget {
  const PetDetail({
    super.key,
    required this.pet,
    required this.cardColor,
  });

  final Pet pet;
  final Color cardColor;

  @override
  State<PetDetail> createState() => _PetDetailState();
}

class _PetDetailState extends State<PetDetail> {
  int _selectedIndex = 0;
  late final List<NavItem> navItems;

  @override
  void initState() {
    super.initState();
    navItems = [
      NavItem(
        title: "Profile",
        icon: Icons.pets_rounded,
        screen: Profile(pet: widget.pet),
      ),
      NavItem(
        title: "Food",
        icon: Icons.food_bank_rounded,
        screen: Food(pet: widget.pet),
      ),
      NavItem(
        title: "Medicines",
        icon: Icons.medication_liquid_rounded,
        screen: Medicine(
          pet: widget.pet,
          cardColor: widget.cardColor,
        ),
      ),
      NavItem(
        title: "Emergency Guide",
        icon: Icons.emergency_rounded,
        screen: EmergencyGuide(
          pet: widget.pet,
          cardColor: widget.cardColor,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: widget.cardColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: 24.0,
              ),
            ),
            const Spacer(),
            Container(
              height: 50.0,
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset('assets/paw.png'),
            ),
            const SizedBox(width: 10.0),
            Text(
              widget.pet.name,
              style: const TextStyle(
                fontSize: 28.0,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70.0,
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 20.0,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          border: Border(
            top: BorderSide(color: Colors.grey, width: 1.0),
            bottom: BorderSide(color: Colors.grey, width: 1.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(56, 44, 44, 0.3),
              offset: Offset(0, 20.0),
              blurRadius: 20.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            navItems.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _selectedIndex == index
                      ? Colors.black87
                      : Colors.transparent,
                ),
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  navItems[index].icon,
                  color:
                      _selectedIndex == index ? Colors.white : Colors.black87,
                  size: 30.0,
                ),
              ),
            ),
          ),
        ),
      ),
      body: navItems[_selectedIndex].screen,
    );
  }
}
