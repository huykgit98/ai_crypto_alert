import 'dart:async';

import 'package:ai_crypto_alert/core/repositories/repositories.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_controller.g.dart';

@riverpod
class SettingsController extends _$SettingsController {
  @override
  FutureOr<void> build() {
    // no op
  }
  Future<void> signOut() async {
    // final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();

    try {
      // await authRepository.signOut();

      state = const AsyncData(null);
    } catch (e) {
      if (kDebugMode) {
        print('Error during sign-out: $e');
      }
      state = AsyncError(e, StackTrace.current);
    }
  }
}
