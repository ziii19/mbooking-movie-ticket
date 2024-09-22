import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mbooking/features/auth/data/datasources/user_repo_remote_data_source.dart';

import '../models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<String> googleSignIn();
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final UserRepoRemoteDataSource userRepoRemoteDataSource;
  AuthRemoteDataSourceImpl(this.firebaseAuth, this.userRepoRemoteDataSource);
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
        throw Exception('An unknown exception occurred.');
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

  @override
  Future<String> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw Exception('Failed to sign in with Google.');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final user = await firebaseAuth.signInWithCredential(credential);

      if (user.additionalUserInfo?.isNewUser == true) {
        await userRepoRemoteDataSource.createUser(
          UserModel(
            uid: user.user!.uid,
            name: user.user!.displayName ?? 'No Name',
            email: user.user!.email ?? 'No Email',
            photoUrl: user.user!.photoURL,
            phoneNumber: user.user!.phoneNumber != null &&
                    RegExp(r'^\d+$').hasMatch(user.user!.phoneNumber!)
                ? int.parse(user.user!.phoneNumber!)
                : null,
          ),
        );
      }

      return user.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw Exception('Account already exists with different credential.');
      } else if (e.code == 'invalid-credential') {
        throw Exception('Invalid credential.');
      } else {
        throw Exception('An unknown exception occurred.');
      }
    }
  }
}
