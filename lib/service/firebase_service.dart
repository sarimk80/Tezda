import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseUserProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final firebaselogout = FutureProvider<void>((ref) {
  return ref.watch(firebaseAuthProvider).signOut();
});

final firebaseCurrentUser = FutureProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).currentUser;
});
