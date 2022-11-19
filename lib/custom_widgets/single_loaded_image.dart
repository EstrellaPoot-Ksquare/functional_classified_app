import 'dart:io';

import 'package:flutter/material.dart';

class SingleImageLoaded extends StatelessWidget {
  final String image;
  const SingleImageLoaded({
    Key? key,
    required this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 180,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
          ),
          borderRadius: BorderRadius.circular(5)),
      child: Image.file(
        File(image),
        fit: BoxFit.cover,
      ),
    );
  }
}
