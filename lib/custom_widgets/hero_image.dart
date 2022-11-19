import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.4,
      child: Stack(
        children: [
          Image.asset(
            'images/city-day.png',
            width: double.infinity,
            height: height * 0.40,
            fit: BoxFit.cover,
          ),
          Container(
            height: height * 0.4,
            width: double.infinity,
            color: const Color.fromRGBO(0, 0, 0, 0.75),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'images/Logo.png',
              width: width * 0.6,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
