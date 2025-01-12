import 'package:flutter/material.dart';
import 'package:pawpal/view/pets/profile.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({
    super.key,
    required this.widget,
    required this.color,
    required this.heading,
    required this.body,
  });

  final Profile widget;
  final Color color;
  final String heading;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              body,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
