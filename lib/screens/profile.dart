import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app/screens/constants.dart';
import 'package:news_app/screens/profile_edit.dart';
import 'package:news_app/screens/signup.dart';
import 'package:news_app/widgets/custom_btn.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:news_app/widgets/user_detail.dart';
import 'package:path/path.dart' as path;

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String imagePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var data;
  _getCurrentUID() async {
    var firstore;

    return (await _firebaseAuth.currentUser).uid;
  }

  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection("users");

  User _user = FirebaseAuth.instance.currentUser;
  late String _imageloading;

  Future<String> _pro() {
    return _userRef.doc(_user.uid).get().then((value) {
      var username = value.get('username');

      return username;
    });
  }

  Future<String> _email() {
    return _userRef.doc(_user.uid).get().then((value) {
      var registeremail = value.get('email');

      return registeremail;
    });
  }

  Future<String> _address() {
    return _userRef.doc(_user.uid).get().then((value) {
      var address = value.get('address');
      return address;
    });
  }

  Future<String> _PhoneNumber() {
    return _userRef.doc(_user.uid).get().then((value) {
      var number = value.get('PhoneNumber');
      return number;
    });
  }

  Future<String> _image() {
    return _userRef.doc(_user.uid).get().then((value) {
      var image = value.get('image');
      return image;
    });
  }

  Widget build(BuildContext context) {
    void editProfile() {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        print(_getCurrentUID());
        return EditProfile();
      }));
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF2b66ad),
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "LAVA",
                  style: Constant.MainStyle,
                ),
                Text(
                  "News",
                  style: Constant.MainNewsStyle,
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: _pro(),
                  builder: (context, AsyncSnapshot) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            FutureBuilder(
                                future: _image(),
                                builder: (context, AsyncSnapshot) {
                                  return Container(
                                    child: SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: CircleAvatar(
                                          radius: 100,
                                          backgroundImage: NetworkImage(
                                              "${AsyncSnapshot.data}")),
                                    ),
                                  );
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 0),
                                child: Text("${AsyncSnapshot.data}",
                                    style: Constant.UserNameStyle),
                              ),
                            ),
                            FutureBuilder(
                                future: _email(),
                                builder: (context, AsyncSnapshot) {
                                  return UserDetail(
                                      title: "Email Address : ",
                                      data: "${AsyncSnapshot.data}");
                                }),
                            FutureBuilder(
                                future: _address(),
                                builder: (context, AsyncSnapshot) {
                                  return UserDetail(
                                      title: "Address : ",
                                      data: "${AsyncSnapshot.data}");
                                }),
                            FutureBuilder(
                                future: _PhoneNumber(),
                                builder: (context, AsyncSnapshot) {
                                  return UserDetail(
                                      title: "Cell Number : ",
                                      data: "${AsyncSnapshot.data}");
                                }),
                            CustomBtn(
                                text: "Lougout",
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                }),
                            CustomBtn(
                                text: "Edit Profile",
                                onPressed: () {
                                  editProfile();
                                })
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
