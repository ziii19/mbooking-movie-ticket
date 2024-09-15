// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:mbooking/features/auth/data/models/user_model.dart';

abstract interface class UserRepoRemoteDataSource {
  Future<UserModel> createUser(UserModel user);
  Future<UserModel> getUser(String uid);
  Future<UserModel> updateUser(UserModel user);
  Future<String> uploadImage({
    required UserModel user,
    required File image,
  });
}

class UserRepoRemoteDataSourceImpl implements UserRepoRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  UserRepoRemoteDataSourceImpl(this.firebaseFirestore, this.firebaseStorage);
  @override
  Future<UserModel> createUser(UserModel user) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .set(user.toMap());
      return user;
    } on FirebaseException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await firebaseFirestore.collection('users').doc(uid).get();
      return UserModel.fromMap(documentSnapshot.data()!);
    } on FirebaseException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .update(user.toMap());
      return user;
    } on FirebaseException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadImage(
      {required UserModel user, required File image}) async {
    try {
      Reference ref = firebaseStorage.ref().child('users').child(user.uid);
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      return imageUrl;
    } on FirebaseException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
