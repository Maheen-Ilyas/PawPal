import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/welcome2.json',
                height: 250.0,
              ),
              const SizedBox(height: 40.0),
              Text(
                'PawPal',
                style: TextStyle(
                  fontSize: 36.0,
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0),
              const Text(
                "Your pet's complete care companion. Track, monitor and nurture your pet with confidence.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24.0),
              GestureDetector(
                onTap: () => {
                  Get.toNamed('/login'),
                },
                child: Container(
                  width: 250.0,
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                    border: Border(
                      top: BorderSide(color: Colors.grey, width: 1.0),
                      bottom: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 50.0,
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset('assets/paw.png'),
                      ),
                      const Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
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
