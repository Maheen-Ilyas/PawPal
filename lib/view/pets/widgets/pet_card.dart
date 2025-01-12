import 'package:flutter/material.dart';
import 'package:pawpal/models/pets/pet.dart';
import 'package:pawpal/view/pets/pet_detail.dart';

class PetCard extends StatelessWidget {
  const PetCard({
    super.key,
    required this.pet,
    required this.cardColor,
  });

  final Pet pet;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => PetDetail(
              pet: pet,
              cardColor: cardColor,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pet.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  pet.breed,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[50],
                  ),
                ),
                Text(
                  "${pet.age} - ${pet.gender}",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[50],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.scale_rounded,
                    color: Colors.black,
                    size: 20.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    "${pet.weight} kg",
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
