import 'package:flutter/material.dart';
import 'package:news_app/screens/constants.dart';

class UserDetail extends StatelessWidget {
  String data;
  String title;
  UserDetail({required this.data, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: Constant.TitleUserStyle,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          width: MediaQuery.of(context).size.width,
          height: 55,
          decoration: BoxDecoration(
            color: Color(0XFFdedede),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                data,
                style: Constant.UserStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
