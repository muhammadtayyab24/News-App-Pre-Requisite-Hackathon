import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/auth_service.dart';
import 'package:news_app/screens/login.dart';
import 'package:news_app/widgets/custom_btn.dart';
import 'package:news_app/widgets/custom_input.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'constants.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool registerlaoding = false;
  String registerusername = "";
  String registeremail = "";
  String registerpassword = "";
  String registernumber = "";
  String registerAddress = "";

  String imagePath = "";
  late FocusNode passwordFocusNode;
  @override
  void initState() {
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    super.dispose();
  }

  Future pickimage() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.getImage(source: ImageSource.gallery);
    String basename = path.basename(image.path);
    setState(() {
      imagePath = image.path;
    });
  }

  void edit() async {
    try {
      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;
      String imagename = path.basename(imagePath);
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('/$imagename');
      File file = File(imagePath);
      await ref.putFile(file);
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      String downloadURl = await ref.getDownloadURL();

      print("done with the image");
      print(downloadURl);
    } catch (e) {
      print(e);
    }
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _alertDialog(String error) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                child: Text("close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection("users");

  Future<String?> createAccount() async {
    try {
      final UserCredential user = await auth.createUserWithEmailAndPassword(
          email: registeremail, password: registerpassword);

      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;
      String imagename = path.basename(imagePath);
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('/$imagename');
      File file = File(imagePath);
      await ref.putFile(file);
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      String downloadURl = await ref.getDownloadURL();

      user.user.updateProfile(displayName: registerusername);
      print("aaa " + registerusername);
      await firestore.collection("users").doc(user.user.uid).set({
        "username": registerusername,
        "email": registeremail,
        "PhoneNumber": registernumber,
        "address": registerAddress,
        "image": downloadURl,
      });

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  User _user = FirebaseAuth.instance.currentUser;

  Future register() async {
    // return _userRef.doc(_user.uid).collection("users").doc();
    setState(() {
      registerlaoding = true;
    });
    String? addUser = await createAccount();
    if (addUser != null) {
      _alertDialog(addUser);
      setState(() {
        registerlaoding = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 20,
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 30.0),
                child: Text(
                  "Welcome To Lava News\nCreate An Account",
                  textAlign: TextAlign.center,
                  style: Constant.BoldHeading,
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Column(
                children: [
                  CustonInput(
                    hintText: "Username",
                    icon: Icon(Icons.person),
                    onchanged: (value) {
                      registerusername = value;
                    },
                    onSubmitted: (value) {
                      passwordFocusNode.requestFocus();
                    },
                    textinputaction: TextInputAction.next,
                  ),
                  CustonInput(
                    icon: Icon(Icons.mail),
                    hintText: "Email",
                    onchanged: (value) {
                      registeremail = value;
                    },
                    onSubmitted: (value) {
                      passwordFocusNode.requestFocus();
                    },
                    textinputaction: TextInputAction.next,
                  ),
                  CustonInput(
                    icon: Icon(Icons.phone),
                    hintText: "Phone Number",
                    onchanged: (value) {
                      registernumber = value;
                    },
                    onSubmitted: (value) {
                      passwordFocusNode.requestFocus();
                    },
                    textinputaction: TextInputAction.next,
                  ),
                  CustonInput(
                    icon: Icon(Icons.home),
                    hintText: "Address",
                    onchanged: (value) {
                      registerAddress = value;
                    },
                    onSubmitted: (value) {
                      passwordFocusNode.requestFocus();
                    },
                    textinputaction: TextInputAction.next,
                  ),
                  CustonInput(
                    icon: Icon(Icons.lock),
                    hintText: "Password",
                    onchanged: (value) {
                      registerpassword = value;
                    },
                    // focusNode: passwordFocusNode,
                    onSubmitted: (value) {
                      register();
                    },
                    passwordfeild: true,
                    textinputaction: TextInputAction.next,
                  ),
                  GestureDetector(
                    onTap: pickimage,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                        vertical: 6.0,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 14.0,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.image),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Choose Profile Picture",
                            style: Constant.Regularheading,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomBtn(
                    text: "Register",
                    onPressed: () async {
                      setState(() async {
                        registerlaoding = true;
                        await register();
                        edit();
                      });
                    },
                    loading: registerlaoding,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              CustomBtn(
                text: "Bck To Login ",
                onPressed: () {
                  Navigator.pop(context);
                },
                outlineBtn: true,
              )
            ],
          ),
        ),
      )),
    );
  }
}
