import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  Future<String> signUpUser({
    required String email,
    required String password,
    required String bio,
    required String username,
  }) async {
    String res = " Error";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          bio.isNotEmpty &&
          username.isNotEmpty) {
        final user = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await _fireStore.collection('users').add({
          'username': username,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'uid': user.user?.uid,
        });
        //in this method uid will be same for collection and data
        // await _fireStore.collection('users').doc(user.user?.uid).set({
        //   'username': username,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        //   'uid': user.user?.uid,
        // });
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
