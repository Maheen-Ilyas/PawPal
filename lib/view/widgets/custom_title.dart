import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.screenTitle,
  });

  final String screenTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50.0,
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.8),
            shape: BoxShape.circle,
          ),
          child: Image.asset('assets/paw.png'),
        ),
        const SizedBox(width: 10.0),
        Text(
          screenTitle,
          style: const TextStyle(
            fontSize: 28.0,
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
