import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Tabs/home_tab.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/helper/provider_fav.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/screens/articles_view.dart';
import 'package:news_app/screens/constants.dart';
import 'package:provider/provider.dart';

class CategoryNews extends StatefulWidget {
  String category;
  CategoryNews({required this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    GetCategoryNews newsClass = GetCategoryNews();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var favouriteBlock = Provider.of<FavouriteBloc>(context);
    return ChangeNotifierProvider<FavouriteBloc>(
      create: (BuildContext context) => FavouriteBloc(),
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
        body: _loading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    top: 16,
                    left: 10,
                    right: 10,
                    bottom: 16,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 16.0),
                        child: ListView.builder(
                            itemCount: articles.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  BlogTile(
                                    imageUrl: articles[index].urlToImage,
                                    published: articles[index].publishedAt,
                                    title: articles[index].title,
                                    desc: articles[index].description,
                                    url: articles[index].url,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: GestureDetector(
                                      onTap: () {
                                        favouriteBlock.addCount();
                                        ArticleModel articleModel =
                                            new ArticleModel(
                                                title: articles[index].title,
                                                description:
                                                    articles[index].description,
                                                urlToImage:
                                                    articles[index].urlToImage,
                                                publishedAt:
                                                    articles[index].publishedAt,
                                                url: articles[index].url);

                                        favouriteBlock.addfav(articleModel);

                                        setState(() {
                                          articles[index].favIcon = true;
                                        });
                                      },
                                      child: articles[index].favIcon == false
                                          ? Icon(Icons.favorite_border)
                                          : Icon(
                                              Icons.favorite,
                                              color: Color(0XFF2b66ad),
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
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
        margin: EdgeInsets.only(bottom: 18.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
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
              title,
              style: Constant.TitleStyle,
            ),
            SizedBox(
              height: 6.0,
            ),
            Text(
              desc,
              style: Constant.DescStyle,
            ),
            SizedBox(
              height: 4.0,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                published,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
