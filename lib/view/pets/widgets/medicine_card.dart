import 'package:flutter/material.dart';
import 'package:pawpal/models/pets/medicine.dart';

class MedicineCard extends StatelessWidget {
  final Medicine medicine;

  const MedicineCard({
    super.key,
    required this.medicine,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: const DecorationImage(
              image: AssetImage('assets/pattern1.jpeg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: const Color.fromRGBO(0, 0, 0, 0.8),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                medicine.name,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                "${medicine.dosage} ml ${medicine.frequency}",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color.fromRGBO(0, 0, 0, 0.8),
                ),
              ),
              Text(
                "${medicine.instruction} at ${medicine.time}",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color.fromRGBO(0, 0, 0, 0.8),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
