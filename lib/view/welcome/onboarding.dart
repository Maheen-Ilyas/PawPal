import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawpal/controller/onboarding/onboarding_controller.dart';
import 'package:pawpal/view/welcome/content.dart';
import 'package:pawpal/view/welcome/welcome.dart';
import 'package:pawpal/view/welcome/widgets/build_feature_page.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: controller.pageController,
        itemCount: 4,
        itemBuilder: (context, index) {
          if (index == 3) {
            return const Welcome();
          }
          return buildFeaturePage(
            imagePath: onboardingData[index]['imagePath']!,
            heading: onboardingData[index]['heading']!,
            description: onboardingData[index]['description']!,
            currentIndex: index,
            pageController: controller.pageController,
          );
        },
      ),
    );
  }
}
