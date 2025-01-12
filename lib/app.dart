import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pawpal/view/auth/login.dart';
import 'package:pawpal/view/auth/signup.dart';
import 'package:pawpal/view/home/chat.dart';
import 'package:pawpal/view/navbar/navbar.dart';
import 'package:pawpal/view/welcome/onboarding.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PawPal',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/login', page: () => const Login()),
        GetPage(name: '/signup', page: () => const Signup()),
        GetPage(name: '/navbar', page: () => const NavBar()),
        GetPage(name: '/chat', page: () => const Chat()),
      ],
      home: const Onboarding(),
    );
  }
}
