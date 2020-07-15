import 'package:url_launcher/url_launcher.dart';

openTelegram() async {
  const url = 'http://t.me/delau_notify_bot';
  if (await canLaunch(url)) {
    await launch(url);
  } else {}
}
