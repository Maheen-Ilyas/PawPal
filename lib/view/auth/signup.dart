import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawpal/controller/auth/signup_controller.dart';
import 'package:pawpal/view/widgets/custom_textfield.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffea417),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Column(
            children: [
              const SizedBox(height: 70.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                    "PawPal",
                    style: TextStyle(
                      fontSize: 34.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Your pet's wellness journey starts here. Sign up to get started.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.73,
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                const Text(
                  "Email Address",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10.0),
                CustomTextField(
                  controller: controller.emailController,
                  hintText: "Email",
                  obscureText: false,
                  prefixIcon: const Icon(Icons.email_rounded),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10.0),
                CustomTextField(
                  controller: controller.passwordController,
                  hintText: "Password",
                  obscureText: true,
                  prefixIcon: const Icon(Icons.password_rounded),
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.signup(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfffea417),
                      overlayColor: const Color(0xfffea417),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () => {
                    Get.toNamed('/login'),
                  },
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Already have an account? Login here!",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1.5,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      "or",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                GestureDetector(
                  onTap: () {
                    controller.googleSignUp(context);
                  },
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/google.png',
                          height: 30.0,
                        ),
                        const SizedBox(width: 10.0),
                        const Text(
                          "Sign up using Google",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
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
      ),
    );
  }
}
