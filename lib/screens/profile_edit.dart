import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/screens/constants.dart';
import 'package:news_app/widgets/custom_input.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool registerlaoding = false;

  String registerpassword = "";
  String registernumber = "";
  String registerAddress = "";

  String imagePath = "";

  late FocusNode passwordFocusNode;

  static get data => null;
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

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  _getCurrentUID() async {
    var firebasefirstore;

    return (await _firebaseAuth.currentUser).uid;
  }

  Future<String> _email() {
    return _userRef.doc(_user.uid).get().then((value) {
      var registeremail = value.get('email');

      return registeremail;
    });
  }

  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection("users");

  User _user = FirebaseAuth.instance.currentUser;

  Future pickimage() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.getImage(source: ImageSource.gallery);
    String basename = path.basename(image.path);
    setState(() {
      imagePath = image.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF2b66ad),
        title: Row(
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
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.favorite),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(),
            Text(
              "Edit Profile",
              style: Constant.BoldHeading,
            ),
            Text(
              "Choose Profile Picture",
              style: Constant.Regularheading,
            ),
            ElevatedButton(onPressed: () {}, child: Text("Done")),
          ],
        ),
      ),
    );
  }
}
