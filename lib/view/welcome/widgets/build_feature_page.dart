import 'package:flutter/material.dart';

Widget buildFeaturePage({
  required String imagePath,
  required String heading,
  required String description,
  required int currentIndex,
  required PageController pageController,
}) {
  return Stack(
    children: [
      Positioned.fill(
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 90.0, 16.0, 0.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.4),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    heading,
                    style: const TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: currentIndex == index ? 12.0 : 8.0,
                        height: currentIndex == index ? 12.0 : 8.0,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? Colors.white
                              : const Color.fromRGBO(255, 255, 255, 0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      if (currentIndex < 3)
        Positioned(
          bottom: 48.0,
          right: 0.0,
          child: GestureDetector(
            onTap: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Image.asset(
              'assets/button.png',
              height: 160.0,
            ),
          ),
        ),
    ],
  );
}
