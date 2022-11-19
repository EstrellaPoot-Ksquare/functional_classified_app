import 'package:classified_app/custom_widgets/custom_widgets.dart';
import 'package:classified_app/data/ads_list.dart';
import 'package:classified_app/services/services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final dynamic data;
  const HomeScreen({super.key, required this.data});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // await Future<List<AdModel>> adsF = AdService().
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Ads Listing'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/settings')
                  .then((value) => setState(() {}));
            },
            child: FutureBuilder(
              future: ProfileService().getUserProfile(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ProfileCircleAppbar(
                    context: context,
                    data: snapshot.data,
                  );
                }
                return const CircleAvatar(
                  backgroundImage: AssetImage('images/jar-loading.gif'),
                );
              }),
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(
          right: 10,
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/create-ad')
                .then((value) => setState(() {}));
          },
          child: const Icon(Icons.add_a_photo_outlined),
        ),
      ),
      body: FutureBuilder(
        future: AdService().getAllAds(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var allAds = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.75,
              ),
              itemCount: allAds.length,
              itemBuilder: (context, index) {
                List<String> images = allAds[index].images!;
                String? image =
                    images.isEmpty ? null : allAds[index].images![0];
                return GestureDetector(
                  child: CardAd(
                    data: allAds[index],
                    image: image,
                    title: allAds[index].title,
                    price: allAds[index].price,
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/product-detail',
                      arguments: allAds[index],
                    );
                  },
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
    );
  }
}

class SimpleAdGrid extends StatelessWidget {
  const SimpleAdGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GridView.builder(
          padding: const EdgeInsets.all(15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.75,
          ),
          itemCount: ads.length,
          itemBuilder: (context, index) {
            String adImages = ads[index]['images'][0];
            return GestureDetector(
              child: CardAd(
                data: ads[index],
                image: adImages,
                title: ads[index]['title'],
                price: ads[index]['price'],
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/product-detail',
                  arguments: ads[index],
                );
              },
            );
          }),
    );
  }
}
