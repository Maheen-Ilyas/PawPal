import 'package:flutter/material.dart';
import 'package:pawpal/models/lostfound/lostfound.dart';

class ComplaintCard extends StatelessWidget {
  final Complaint complaint;

  const ComplaintCard({
    super.key,
    required this.complaint,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor =
        complaint.type == 'Lost' ? Colors.red.shade300 : Colors.green.shade300;

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Complaint Type: ${complaint.type}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            complaint.type == "Found"
                ? Text('Finder: ${complaint.name}')
                : Text('Owner: ${complaint.name}'),
            Text('Pet Name: ${complaint.petName}'),
            Text('Breed: ${complaint.breed}'),
            Text('Pet Color: ${complaint.petColor}'),
            complaint.type == "Found"
                ? Text('Found Location: ${complaint.lastLocation}')
                : Text('Lost Location: ${complaint.lastLocation}'),
            Text('Phone: ${complaint.phoneNumber}'),
            complaint.type == "Found"
                ? Container()
                : Text(
                    'Reward: ${complaint.reward.isNotEmpty ? complaint.reward : "None"}',
                  ),
          ],
        ),
      ),
    );
  }
}
