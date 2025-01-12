import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class EmergencyGuideResponse extends StatelessWidget {
  final String generatedGuide;
  final Color cardColor;

  const EmergencyGuideResponse({
    super.key,
    required this.generatedGuide, required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: cardColor,
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
            const Text(
              "Response",
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
      ),
    );
  }
}
