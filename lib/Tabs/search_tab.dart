import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Tabs/fav_tav.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/helper/search_bloc.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_models.dart';
import 'package:news_app/screens/articles_view.dart';
import 'package:news_app/screens/category_news.dart';
import 'package:news_app/screens/constants.dart';
import 'package:news_app/widgets/custom_input.dart';
import 'package:news_app/widgets/search_widgets.dart';

import 'home_tab.dart';

class SearchTab extends StatefulWidget {
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  TextEditingController searchController = TextEditingController();

  String query = "";
  List<CategoryModels> categories = <CategoryModels>[];
  List<ArticleModel> articles = <ArticleModel>[];
  List<ArticleModel> articleDisplay = <ArticleModel>[];
  bool _loading = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    searchBloc..search("");
    categories = getCategories();
    getNews();
    articleDisplay = articles;
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            )),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 8.0,
            ),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Search",
                    style: Constant.MainHeadStyle,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: TextFormField(
                  textInputAction: TextInputAction.search,
                  onChanged: (text) {
                    text = text.toLowerCase();
                    setState(() {
                      articleDisplay = articles.where((articleModel) {
                        var notetitle = articleModel.title.toLowerCase();
                        return notetitle.contains(text);
                      }).toList();
                    });
                  },
                  decoration: InputDecoration(
                    icon: Padding(
                      padding: const EdgeInsets.only(
                        left: 14.0,
                      ),
                      child: new Icon(Icons.search),
                    ),
                    hintText: "Search Here...",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8.0),
                child: ListView.builder(
                    itemCount: articleDisplay.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BlogTile(
                        imageUrl: articleDisplay[index].urlToImage,
                        published: articleDisplay[index].publishedAt,
                        title: articleDisplay[index].title,
                        desc: articleDisplay[index].description,
                        url: articleDisplay[index].url,
                      );
                    }),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Articles(blogUrl: url),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          )),
        ),
        margin: EdgeInsets.only(bottom: 8.0),
        child: Column(
          children: [
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 100,
                  height: 90,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              title: Text(
                title,
                style: Constant.SearchTitleStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
