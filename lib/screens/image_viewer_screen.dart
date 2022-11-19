import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageViewerScreen extends StatelessWidget {
  const ImageViewerScreen({super.key, required this.data});
  final List data;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: Container(
          padding: const EdgeInsets.only(
            top: 15,
          ),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            backgroundColor: Colors.black,
            child: const Icon(Icons.close),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: Center(
          child: CarouselSlider(
            options: CarouselOptions(
              height: 500.0,
              viewportFraction: 1,
            ),
            items: data.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.network(
                      image,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          'http://panther-wheels.net/assets/images/noimage.jpg',
                          height: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
