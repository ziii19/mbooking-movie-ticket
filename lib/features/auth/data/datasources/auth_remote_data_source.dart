import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  AuthRemoteDataSourceImpl(this.firebaseAuth);
  @override
  Future<String> signIn(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Incorrect email or password.');
      } else {
        throw Exception(e);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> signUp(String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('Please enter a stronger password.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('An account already exists for that email.');
      } else {
        throw Exception('An unknown exception occurred.');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();

      if (firebaseAuth.currentUser == null) {
        return;
      }

      throw Exception('Failed to sign out.');
    } catch (e) {
      throw Exception(e);
    }
  }
}
