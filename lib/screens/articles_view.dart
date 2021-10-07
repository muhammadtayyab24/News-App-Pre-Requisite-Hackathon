import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/screens/constants.dart';

import 'package:webview_flutter/webview_flutter.dart';

class Articles extends StatefulWidget {
  final String blogUrl;
  Articles({required this.blogUrl});

  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: Container(
          child: WebView(
            initialUrl: widget.blogUrl,
            onWebViewCreated: ((WebViewController webViewController) {
              _completer.complete(webViewController);
            }),
          ),
        ),
      ),
    );
  }
}
