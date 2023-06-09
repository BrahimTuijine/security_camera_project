

// ignore_for_file: deprecated_member_use

import 'package:url_launcher/url_launcher.dart';

class Methods {
  static openURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw "Could not Launch $url";
  }

  static launchEmail() async {
    if (await canLaunch("mailto:brahimtuijine220@gmail.com")) {
      await launch("mailto:brahimtuijine220@gmail.com");
    } else {
      throw 'Could not launch';
    }
  }
}