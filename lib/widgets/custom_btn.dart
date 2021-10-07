import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool outlineBtn;
  final bool loading;

  CustomBtn({
    required this.text,
    required this.onPressed,
    this.outlineBtn = false,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlineBtn;
    bool _loading = loading;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 55.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: _outlineBtn ? Colors.transparent : Colors.black,
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(12.0)),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          children: [
            Visibility(
              visible: _loading ? false : true,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: _outlineBtn ? Colors.black : Colors.white),
                ),
              ),
            ),
            Visibility(
              visible: _loading,
              child: Center(
                child: SizedBox(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
