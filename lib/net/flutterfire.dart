import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

// Sign in method
Future<bool> logIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

// Register account
Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print("The password provided is too weak.");
    } else if (e.code == "email-already-in-use") {
      print("The account already exists for that email.");
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> addProfile(
    String firstname,
    String lastname,
    String address,
    String healthNumber,
    String insuranceNumber,
    String conditions,
    String imagefile) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection("Profiles")
        .doc(firstname);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({
          "FirstName": firstname,
          "LastName": lastname,
          "Address": address,
          "HealthNumber": healthNumber,
          "InsuranceNumber": insuranceNumber,
          "Conditions": conditions,
          "Image": imagefile,
        });
        return true;
      }
      // If access
      return true;
    });
  } catch (e) {
    print(e.toString());
    return false;
  }
}
