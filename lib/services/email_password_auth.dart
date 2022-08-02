import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class EmailPasswordAuth {
  Future<String> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Successfully Login";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'user not registered';
      } else if (e.code == 'wrong-password') {
        return 'wrong password';
      } else {
        return 'invalid email or password';
      }
    }
  }

  Future<String> signUp(String email, String password, String name,
      String f_name, String location) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': name,
        'f_name': f_name,
        'location': location,
        'password': password
      });
      return 'succssfully SignedUp';
    } on FirebaseAuthException catch (e) {
      //print(e);
      if (e.code == 'weak-password') {
        return 'password is too weak';
      } else if (e.code == 'email-already-in-use') {
        return 'user already exist';
      } else {
        return 'something went wrong';
      }
    }
  }

  Future<String> resetPassword(email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return 'check your email inbox';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return 'invalid email';
      } else if (e.code == 'user-not-found') {
        return 'user not registered';
      } else {
        return 'something went wrong';
      }
    }
  }
}