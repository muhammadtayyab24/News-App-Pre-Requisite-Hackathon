import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/helper/provider_fav.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_models.dart';
import 'package:news_app/screens/articles_view.dart';
import 'package:news_app/screens/category_news.dart';
import 'package:news_app/screens/constants.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: HomeTab(),
  ));
}

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<CategoryModels> categories = <CategoryModels>[];
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
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
            )),
        body: SingleChildScrollView(
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 16,
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Top Categories",
                            style: Constant.TopHeadStyle,
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                imageUrl: categories[index].imageUrl,
                                categoryName: categories[index].categoryName,
                              );
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Top Headlines",
                            style: Constant.MainHeadStyle,
                          ),
                        ),
                      ),
                      Container(
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

class CategoryTile extends StatelessWidget {
  final String imageUrl;
  final String categoryName;
  CategoryTile({required this.categoryName, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CategoryNews(category: categoryName.toLowerCase()),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 12.0,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.asset(
                imageUrl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.black26,
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
            )
          ],
        ),
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
        margin: EdgeInsets.only(top: 10.0),
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
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.published,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
