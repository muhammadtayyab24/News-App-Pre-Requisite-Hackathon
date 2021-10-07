import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Tabs/fav_tav.dart';
import 'package:news_app/screens/login.dart';
import 'package:news_app/screens/login_signup.dart';

class FavourtieTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, Snapshot) {
          if (Snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error : ${Snapshot.error}"),
              ),
            );
          }
          if (Snapshot.connectionState == ConnectionState.active) {
            Object? _user = Snapshot.data;
            if (_user == null) {
              return LoginSignUp();
            } else {
              return FavTab();
            }
          }
          return Scaffold(
            body: Center(
              child: Text("checking authentication..."),
            ),
          );
        });
  }
}
