import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_app/helper/provider_fav.dart';
import 'package:news_app/models/article_model.dart';

import 'package:news_app/screens/landing_page.dart';
import 'package:http/http.dart' as https;
import 'package:provider/provider.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
    ChangeNotifierProvider<FavouriteBloc>(
      create: (BuildContext context) => FavouriteBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeData = ThemeData(
      primaryColor: Color(0XFF2b66ad),
      // ignore: deprecated_member_use
      accentColor: Color(0XFF2b66ad),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "LAVA NEWS",
      theme: themeData,
      home: LandingPage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
