import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class CardAd extends StatelessWidget {
  final dynamic data;
  final String? image;
  final String? title;
  final double? price;
  const CardAd({
    super.key,
    this.image,
    this.title,
    this.price,
    required this.data,
    // required this.title,
    // required this.price,
    // required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.4,
      child: Stack(
        children: [
          Image.network(
            data.images[0],
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // return Text('$error');
              return Image.network(
                'http://panther-wheels.net/assets/images/noimage.jpg',
                height: double.infinity,
                fit: BoxFit.cover,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: !kIsWeb
                  ? const EdgeInsets.all(10)
                  : const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
              color: const Color.fromRGBO(0, 0, 0, 0.6),
              height: 70,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: !kIsWeb
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    data.price.toString(),
                    style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
