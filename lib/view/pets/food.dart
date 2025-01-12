import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pawpal/constants/api_key.dart';
import 'package:pawpal/models/pets/pet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Food extends StatefulWidget {
  const Food({
    super.key,
    required this.pet,
  });

  final Pet pet;

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  String generatedGuide = "";
  List<String> foodBrands = [
    "Whiskas",
    "Me-o",
    "Pedigree",
  ];

  String? selectedBrand;

  void onChanged(String? newBrand) {
    setState(() {
      selectedBrand = newBrand;
    });
  }

  Future<void> generateGuide() async {
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
                      "A pet weighing ${widget.pet.weight} kg and aged ${widget.pet.age} consumes $selectedBrand. Based on typical nutritional profiles of $selectedBrand products, provide general information on nutritional value and dietary recommendations for this pet. Avoid disclaimers about specific product variants and focus on actionable advice in 250 words."
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
                "Food & Nutrition",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Select your pet's food brand",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
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
                  hintText: "Food Brand",
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
                value: selectedBrand,
                items: foodBrands.map((String brand) {
                  return DropdownMenuItem<String>(
                    value: brand,
                    child: Text(
                      brand,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: GoogleFonts.dmSans().fontFamily,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newBrand) {
                  onChanged(newBrand);
                  if (newBrand != null) {
                    generateGuide();
                  }
                },
              ),
              const SizedBox(height: 20.0),
              if (generatedGuide.isNotEmpty)
                Expanded(
                  child: Markdown(
                    data: generatedGuide,
                    styleSheet: MarkdownStyleSheet(
                      h2: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                      h2Align: WrapAlignment.start,
                      p: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
