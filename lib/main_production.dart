import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'bootstrap.dart';
import 'gen/assets.gen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: Assets.envs.aEnv);

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await bootstrap();
}
