import 'package:flutter/material.dart';
import 'package:pawpal/constants/api_key.dart';
import 'package:pawpal/models/pets/pet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pawpal/view/pets/emergency_guide_response.dart';

class EmergencyGuide extends StatefulWidget {
  const EmergencyGuide({
    super.key,
    required this.pet,
    required this.cardColor,
  });

  final Pet pet;
  final Color cardColor;

  @override
  State<EmergencyGuide> createState() => _EmergencyGuideState();
}

class _EmergencyGuideState extends State<EmergencyGuide> {
  String? generatedGuide;
  final List<String> emergencyScenarios = [
    'Ate something spoiled',
    'Drank something spoiled',
    'Has a fever',
    'Has watery eyes',
    'Has a running nose',
    'Is lethargic',
    'Is shivering or trembling',
    'Has difficulty walking',
    'Ate something poisonous',
    'Has a cut or wound',
    'Is choking',
    'Is having a seizure',
    'Is vomiting or diarrhea',
    'Has trouble breathing',
    'Got stung by an insect',
  ];

  Future<void> generateGuide(String scenario) async {
    const url =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent';
    const apiKey = GEMINI_API_KEY;

    try {
      final response = await http.post(
        Uri.parse('$url?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "contents": [
            {
              "parts": [
                {
                  "text":
                      "Generate a detailed emergency guide for a ${widget.pet.breed} that weighs ${widget.pet.weight} kg and is ${widget.pet.gender}. The scenario is: Pet $scenario. Please include symptoms, actions and vet recommendations. Generate response in 200 words."
                }
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['candidates'] != null &&
            data['candidates'][0]['content'] != null &&
            data['candidates'][0]['content']['parts'] != null &&
            data['candidates'][0]['content']['parts'][0]['text'] != null) {
          setState(() {
            generatedGuide =
                data['candidates'][0]['content']['parts'][0]['text'];
          });
        }
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Emergency Guide",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: ListView.builder(
                  itemCount: emergencyScenarios.length,
                  itemBuilder: (context, index) {
                    final scenario = emergencyScenarios[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black87,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: ListTile(
                        title: Row(
                          children: [
                            const Icon(
                              Icons.sos_rounded,
                              color: Colors.red,
                              size: 26.0,
                            ),
                            const SizedBox(width: 16.0),
                            Text(
                              scenario,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.chevron_right_rounded),
                          ],
                        ),
                        onTap: () async {
                          await generateGuide(scenario);
                          if (!context.mounted) return;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmergencyGuideResponse(
                                generatedGuide:
                                    generatedGuide ?? "No guide available.",
                                cardColor: widget.cardColor,
                              ),
                            ),
                          );
                        },
                      ),
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
