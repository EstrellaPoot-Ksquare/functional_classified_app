import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static openURL(url) async {
    url = Uri.parse(url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Error');
    }
  }
}
