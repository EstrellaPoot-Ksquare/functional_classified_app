import 'dart:io';

import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String image;
  const ImageContainer({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scheme = Uri.parse(image).scheme;
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
          ),
          borderRadius: BorderRadius.circular(5)),
      child: scheme != ''
          ? Image.network(
              image,
              fit: BoxFit.cover,
            )
          : Image.file(
              File(image),
              fit: BoxFit.cover,
            ),
    );
  }
}
