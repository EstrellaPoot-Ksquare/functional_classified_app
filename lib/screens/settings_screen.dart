import 'package:classified_app/models/models.dart';
import 'package:classified_app/services/services.dart';
import 'package:flutter/material.dart';

import '../commons/open_url_helper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    const double profileSize = 40;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: FutureBuilder(
            future: ProfileService().getUserProfile(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var user = snapshot.data!;
                print('user: ${snapshot.data}');
                return ListView(
                  children: [
                    ListTile(
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: user.imgURL == null
                              ? Image.asset(
                                  'images/city-day.png',
                                  width: profileSize,
                                  height: profileSize,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  user.imgURL!,
                                  width: profileSize,
                                  height: profileSize,
                                  fit: BoxFit.cover,
                                )),
                      title: Text(
                        user.name.toString(),
                      ),
                      subtitle: Text(
                        user.mobile.toString(),
                      ),
                      trailing: TextButton(
                        onPressed: () async {
                          final UserModel user =
                              await ProfileService().getUserProfile();
                          Navigator.pushNamed(context, '/edit-profile',
                                  arguments: user)
                              .then((value) => setState(() {}));
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.post_add_rounded),
                      title: const Text(
                        'My Ads',
                      ),
                      onTap: () {
                        var myAds = AdService().getMyAds();
                        print('MY ADS: $myAds');
                        Navigator.pushNamed(context, '/my-ads',
                                arguments: myAds)
                            .then((value) => setState(() {}));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: const Text(
                        'About Us',
                      ),
                      onTap: () {
                        UrlHelper.openURL('https://appmaking.com/about/');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone_outlined),
                      title: const Text(
                        'Contact Us',
                      ),
                      onTap: () {
                        UrlHelper.openURL('https://appmaking.com/contact/');
                      },
                    ),
                  ],
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}
