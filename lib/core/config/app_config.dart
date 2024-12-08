import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static const String baseUrl = 'itree.com.vn';

  static const int port = 5000;
  static const String scheme = 'http';

  static const String packageName = 'com.itree.itree.stg';

  //map
  static const String osmUrlTemplate =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String appleMapURILauncher = 'https://maps.apple.com/?q=';
  static const String googleMapURILauncher =
      'https://www.google.com/maps/search/?api=1&query=';

  static final _googleConfig = _GoogleConfig(
    clientIdAndroid: dotenv.get('GOOGLE_CLIENT_ID_AND'),
    clientIdIos: dotenv.get('GOOGLE_CLIENT_ID_IOS'),
  );

  static final _appleConfig = _AppleConfig(
    clientId: dotenv.get('APPLE_CLIENT_ID'),
    redirectUri: dotenv.get('APPLE_REDIRECT_URI'),
  );

  _GoogleConfig get googleConfig => _googleConfig;

  _AppleConfig get appleConfig => _appleConfig;
}

class _GoogleConfig {
  _GoogleConfig({required this.clientIdAndroid, required this.clientIdIos});

  final String clientIdAndroid;
  final String clientIdIos;
}

class _AppleConfig {
  _AppleConfig({required this.clientId, required this.redirectUri});

  final String clientId;
  final String redirectUri;
}
