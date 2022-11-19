import 'package:classified_app/custom_widgets/custom_widgets.dart';
import 'package:classified_app/services/ad_service.dart';
import 'package:flutter/material.dart';

class MyAdsScreen extends StatefulWidget {
  final dynamic data;
  const MyAdsScreen({super.key, required this.data});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Ads'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: FutureBuilder(
          future: AdService().getMyAds(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var myAds = snapshot.data!;
              return ListView.builder(
                itemCount: myAds.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/edit-ad',
                              arguments: myAds[index].toJson())
                          .then((value) => setState(() {}));
                    },
                    child: Row(
                      children: [
                        MyAdsCard(
                          data: myAds[index],
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
            return const Center(
              child: CircularProgressLoading(),
            );
          },
        ),
      ),
    );
  }
}
