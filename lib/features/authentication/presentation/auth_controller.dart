// import 'dart:async';
//
// import 'package:ai_crypto_alert/core/enums/enums.dart';
// import 'package:ai_crypto_alert/core/providers/language_provider.dart';
// import 'package:ai_crypto_alert/core/repositories/authentication/auth_repository.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// part 'auth_controller.g.dart';
//
// @riverpod
// class AuthController extends _$AuthController {
//   @override
//   FutureOr<void> build() async {
//     await _setLanguage();
//     // ok to leave this empty if the return type is FutureOr<void>
//   }
//
//   Future<bool> signInWithGoogle() async {
//     state = const AsyncLoading();
//     try {
//       final authRepository = ref.read(authRepositoryProvider);
//       final isSignedIn = await authRepository.signInWithGoogle();
//       state = const AsyncValue.data(null);
//       return isSignedIn;
//     } catch (e) {
//       state = const AsyncValue.data(null);
//       return false;
//     }
//   }
//
//   Future<bool> signInWithApple() async {
//     state = const AsyncLoading();
//     final authRepository = ref.read(authRepositoryProvider);
//     try {
//       final userCredential = await authRepository.signInWithApple();
//       state = const AsyncValue.data(null);
//       return userCredential;
//     } catch (error) {
//       state = const AsyncValue.data(null);
//       return false;
//     }
//   }
//
//   Future<bool> signInWithEmailAndPassword({
//     required String email,
//     required String password,
//     required EmailPasswordSignInFormType formType,
//   }) async {
//     state = const AsyncValue.loading();
//     try {
//       await _authenticate(email, password, formType);
//       state = const AsyncValue.data(null);
//       return true;
//     } catch (error) {
//       state = AsyncValue.error(error, StackTrace.current);
//       return false;
//     }
//   }
//
//   Future<void> _authenticate(
//       String email, String password, EmailPasswordSignInFormType formType) {
//     final authRepository = ref.read(authRepositoryProvider);
//     switch (formType) {
//       case EmailPasswordSignInFormType.signIn:
//         return authRepository.signInWithEmailAndPassword(email, password);
//       case EmailPasswordSignInFormType.register:
//         return authRepository.createUserWithEmailAndPassword(email, password);
//     }
//   }
//
//   Future<void> sendEmailResetPassword(String email) async {
//     state = const AsyncLoading();
//     final authRepository = ref.read(authRepositoryProvider);
//     try {
//       final userCredential = await authRepository.sendPasswordResetEmail(email);
//
//       state = const AsyncValue.data(null);
//     } catch (e) {
//       state = const AsyncValue.data(null);
//     }
//   }
//
//   Future<void> _setLanguage() async {
//     final authRepository = ref.read(authRepositoryProvider);
//     final languageCode = ref.read(languageProvider);
//     await authRepository.setLanguage(languageCode.value?.languageCode ?? 'en');
//   }
// }
