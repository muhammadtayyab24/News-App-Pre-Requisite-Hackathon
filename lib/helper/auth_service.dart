import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/profile_edit.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  getCurrentUID() async {
    var firebasefirstore;
    return (await _firebaseAuth.currentUser).uid;
  }

  getCurrentUser() async {
    return await _firebaseAuth.currentUser;
  }
}
