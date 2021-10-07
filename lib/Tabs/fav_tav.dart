import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/provider_fav.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/screens/articles_view.dart';
import 'package:news_app/screens/constants.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as https;

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MaterialApp(
    home: FavTab(),
  ));
}

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var favouriteBlock = Provider.of<ArticleModel>(context);
    return ChangeNotifierProvider<FavouriteBloc>(
        create: (BuildContext context) => FavouriteBloc(), child: FavTab());
  }
}

class FavTab extends StatefulWidget {
  @override
  _FavTabState createState() => _FavTabState();
}

class _FavTabState extends State<FavTab> {
  @override
  Widget build(BuildContext context) {
    var favouriteBlock = Provider.of<FavouriteBloc>(context);
    return ChangeNotifierProvider<FavouriteBloc>(
      create: (BuildContext context) => FavouriteBloc(),
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
        body: Container(
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Favourite",
                        style: Constant.MainHeadStyle,
                      ),
                    ),
                  ),
                  ListView.builder(
                      itemCount: favouriteBlock.fav.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BlogTile(
                          imageUrl: favouriteBlock.fav[index].urlToImage,
                          title: favouriteBlock.fav[index].title,
                          desc: favouriteBlock.fav[index].description,
                          url: favouriteBlock.fav[index].url,
                          published: favouriteBlock.fav[index].publishedAt,
                        );
                      }),
                ],
              ),
            )),
      ),
    );
  }
}

class BlogTile extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String desc;
  final String url;
  final String published;
  BlogTile({
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.url,
    required this.published,
  });

  @override
  State<BlogTile> createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {
  Icon _iconCo = Icon(Icons.favorite_border);
  bool selected = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Articles(blogUrl: widget.url),
          ),
        );
      },
      child: Container(
        // decoration: BoxDecoration(border: Border(bottom: )),
        margin: EdgeInsets.only(bottom: 18.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                placeholder: (context, url) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              widget.title,
              style: Constant.TitleStyle,
            ),
            SizedBox(
              height: 6.0,
            ),
            Text(
              widget.desc,
              style: Constant.DescStyle,
            ),
            SizedBox(
              height: 4.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.favorite,
                  color: Color(0XFF2b66ad),
                ),
                Text(
                  widget.published,
                ),
              ],
            ),
          ],
        ),
      ),
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
