import 'package:flutter/material.dart';

class ImageUploader extends StatelessWidget {
  const ImageUploader({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.3,
      height: width * 0.3,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.add_a_photo_outlined,
            size: 50,
          ),
          Text('Tap to upload'),
        ],
      ),
    );
  }
}
