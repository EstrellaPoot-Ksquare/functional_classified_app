import 'package:classified_app/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class ImagesList extends StatelessWidget {
  const ImagesList({
    Key? key,
    this.color,
    required this.images,
  }) : super(key: key);

  final dynamic images;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (_, index) {
          return ImageContainer(image: images[index]);
        },
      ),
    );
  }
}
