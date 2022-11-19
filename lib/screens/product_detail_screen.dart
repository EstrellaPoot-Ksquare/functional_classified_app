import 'package:classified_app/commons/open_url_helper.dart';
import 'package:classified_app/utils/date_calculator.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    print('details: ${data.toJson()}');
    var date = DateTime.now();
    var date2 = DateTime.parse(data.createdAt.toString());
    print('date2 $date2');
    print('date: $date');
    int daysAgo = DateCalculator().daysAgo(data.createdAt.toString());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.title,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              data.price.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (data.images.isEmpty) return;
                      Navigator.pushNamed(context, '/image-viewer',
                          arguments: data.images);
                    },
                    child: Image.network(
                      !data.images.isEmpty
                          ? data.images[0]
                          : 'https://via.placeholder.com/300x400',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // return Text('$error');
                        return Image.network(
                          'http://panther-wheels.net/assets/images/noimage.jpg',
                          // height: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 15,
                        color: Colors.black87,
                      ),
                      Text('${data.authorName}'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.timer_outlined,
                        size: 15,
                        color: Colors.black87,
                      ),
                      Text(
                        '$daysAgo days ago',
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              data.description ?? '',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                UrlHelper.openURL('tel:${data.mobile}');
              },
              child: const Text('Contact Seller'),
            ),
          ],
        ),
      ),
    );
  }
}
