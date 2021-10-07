import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/screens/constants.dart';

class CustonInput extends StatelessWidget {
  final String hintText;

  final Function(String) onchanged;
  final Function(String) onSubmitted;
  final TextInputAction textinputaction;
  final bool passwordfeild;
  final Icon icon;

  CustonInput({
    required this.hintText,
    required this.onchanged,
    required this.onSubmitted,
    required this.icon,
    required this.textinputaction,
    this.passwordfeild = false,
  });

  @override
  Widget build(BuildContext context) {
    bool _passwordfield = passwordfeild;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        onChanged: onchanged,
        onSubmitted: onSubmitted,
        textInputAction: textinputaction,
        obscureText: _passwordfield,
        decoration: InputDecoration(
            icon: Padding(
              padding: const EdgeInsets.only(
                left: 14.0,
              ),
              child: new Icon(icon.icon),
            ),
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.0,
            )),
        style: Constant.Regularheading,
      ),
    );
  }
}
