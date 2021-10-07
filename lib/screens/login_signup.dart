import 'package:flutter/material.dart';
import 'package:news_app/screens/login.dart';
import 'package:news_app/screens/signup.dart';
import 'package:news_app/widgets/custom_btn.dart';

import 'constants.dart';

class LoginSignUp extends StatelessWidget {
  const LoginSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "First You Need TO \n SIGNIN / SIGNUP",
              textAlign: TextAlign.center,
              style: Constant.BoldHeading,
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomBtn(
                      text: "Sign In",
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signin()));
                      }),
                  CustomBtn(
                      text: "Sign Up",
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup()));
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
