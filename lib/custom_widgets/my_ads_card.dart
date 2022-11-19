import 'package:classified_app/utils/date_calculator.dart';
import 'package:flutter/material.dart';

class MyAdsCard extends StatelessWidget {
  final dynamic data;
  const MyAdsCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    int daysAgo = DateCalculator().daysAgo(data.createdAt.toString());
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black26,
              width: 2.5,
            ),
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            Image.network(
              data.images[0],
              width: width * 0.25,
              height: height * 0.15,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.timer_outlined,
                      size: 15,
                      color: Colors.black45,
                    ),
                    Text(
                      '$daysAgo days ago',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  data.price.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
