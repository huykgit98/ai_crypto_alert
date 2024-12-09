import 'package:collection/collection.dart';
import 'package:lottie/lottie.dart';

/// Custom Lottie decoder for `.lottie` files with specific filtering logic.
Future<LottieComposition?> customLottieDecoder(List<int> bytes) {
  return LottieComposition.decodeZip(
    bytes,
    filePicker: (files) {
      // Find the first JSON file under the animations directory
      return files.firstWhereOrNull(
        (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'),
      );
    },
  );
}
