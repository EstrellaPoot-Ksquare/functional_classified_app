import 'package:flutter/material.dart';

class CircularProgressLoading extends StatelessWidget {
  const CircularProgressLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: height - appBarHeight,
      ),
      child: Transform.scale(
        scale: 1.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
