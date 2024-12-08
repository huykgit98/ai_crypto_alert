// import 'dart:convert';
// import 'dart:math';
//
// import 'package:ai_crypto_alert/core/utils/utils.dart';
// import 'package:crypto/crypto.dart';
// import 'package:flutter/services.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
//
// part 'auth_repository.g.dart';
//
// class AuthRepository {
//   AuthRepository(this._auth);
//
//   final FirebaseAuth _auth;
//
//   Stream<User?> authStateChanges() => _auth.authStateChanges();
//
//   User? get currentUser => _auth.currentUser;
//
//   Future<void> setLanguage(String langCode) async {
//     return _auth.setLanguageCode(langCode);
//   }
//
//   Future<bool> _signUserWithAuthCredential(AuthCredential credential) async {
//     final userCredential = await _auth.signInWithCredential(credential);
//     return userCredential.user != null;
//   }
//
//   Future<bool> signInWithEmailAndPassword(String email, String password) async {
//     final userCredential = await _auth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return userCredential.user != null;
//   }
//
//   Future<bool> createUserWithEmailAndPassword(
//     String email,
//     String password,
//   ) async {
//     final userCredential = await _auth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return userCredential.user != null;
//   }
//
//   Future<void> sendPasswordResetEmail(String email) async {
//     await _auth.sendPasswordResetEmail(email: email);
//   }
//
//   Future<bool> signInWithGoogle() async {
//     final googleUser = await GoogleSignIn().signIn();
//     if (googleUser != null) {
//       final googleAuth = await googleUser.authentication;
//       final credential = GoogleAuthProvider.credential(
//         idToken: googleAuth.idToken,
//         accessToken: googleAuth.accessToken,
//       );
//       return _signUserWithAuthCredential(credential);
//     } else {
//       throw PlatformException(
//         code: 'ERROR_ABORTED_BY_USER',
//         message: 'Sign in aborted by user',
//       );
//     }
//   }
//
//   String _createNonce(int length) {
//     final random = Random();
//     final charCodes = List<int>.generate(length, (_) {
//       late int codeUnit;
//
//       switch (random.nextInt(3)) {
//         case 0:
//           codeUnit = random.nextInt(10) + 48; // Digits 0-9
//           break;
//         case 1:
//           codeUnit = random.nextInt(26) + 65; // Uppercase A-Z
//           break;
//         case 2:
//           codeUnit = random.nextInt(26) + 97; // Lowercase a-z
//           break;
//       }
//
//       return codeUnit;
//     });
//
//     return String.fromCharCodes(charCodes);
//   }
//
//   Future<bool> signInWithApple() async {
//     final nonce = _createNonce(32);
//     final nativeAppleCred = await SignInWithApple.getAppleIDCredential(
//       scopes: [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAuthorizationScopes.fullName,
//       ],
//       nonce: sha256.convert(utf8.encode(nonce)).toString(),
//     );
//     final authCredential = OAuthCredential(
//       providerId: 'apple.com',
//
//       // MUST be "apple.com"
//       signInMethod: 'oauth',
//       // MUST be "oauth"
//       accessToken: nativeAppleCred.identityToken,
//       // propagate Apple ID token to BOTH accessToken and idToken parameters
//       idToken: nativeAppleCred.identityToken,
//       rawNonce: nonce,
//     );
//     return _signUserWithAuthCredential(authCredential);
//   }
//
//   Future<void> signOut() async {
//     try {
//       // await GoogleSignIn().signOut();
//       // return _auth.signOut();
//       await Future.wait([
//         GoogleSignIn().signOut(),
//         _auth.signOut(),
//       ]);
//     } catch (error) {
//       Logger.error('signOut failed: $error');
//     }
//   }
//
//   Future<void> signInAnonymously() async {
//     await _auth.signInAnonymously();
//   }
// }
//
// @Riverpod(keepAlive: true)
// FirebaseAuth firebaseAuth(FirebaseAuthRef ref) => FirebaseAuth.instance;
//
// @Riverpod(keepAlive: true)
// AuthRepository authRepository(AuthRepositoryRef ref) =>
//     AuthRepository(ref.watch(firebaseAuthProvider));
//
// @riverpod
// Stream<User?> authStateChanges(AuthStateChangesRef ref) =>
//     ref.watch(authRepositoryProvider).authStateChanges();
