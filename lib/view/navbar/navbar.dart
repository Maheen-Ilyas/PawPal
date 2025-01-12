import 'package:flutter/material.dart';
import 'package:pawpal/models/navbar/nav_item.dart';
import 'package:pawpal/view/home/home.dart';
import 'package:pawpal/view/lostfound/lostfound.dart';
import 'package:pawpal/view/pets/pets.dart';
import 'package:pawpal/view/vets/vets.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  List<NavItem> navItems = const [
    NavItem(
      title: "Home",
      icon: Icons.home_rounded,
      screen: Home(),
    ),
    NavItem(
      title: "Pets",
      icon: Icons.pets_rounded,
      screen: Pets(),
    ),
    NavItem(
      title: "Lost and Found",
      icon: Icons.find_in_page_rounded,
      screen: LostFound(),
    ),
    NavItem(
      title: "Vets",
      icon: Icons.local_hospital_rounded,
      screen: Vets(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navItems[_selectedIndex].screen,
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
    );
  }
}
