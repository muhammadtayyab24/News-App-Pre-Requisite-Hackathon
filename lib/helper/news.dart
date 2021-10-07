import 'dart:convert';

import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart' as https;

class News {
  List<ArticleModel> news = [];
  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=6f840308e8bf4d68b8be10df241e5055";
    var response = await https.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            favIcon: false,
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            publishedAt: element["publishedAt"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class GetCategoryNews {
  List<ArticleModel> news = [];
  Future<void> getNews(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?category=$category&country=us&apiKey=6f840308e8bf4d68b8be10df241e5055";
    var response = await https.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            publishedAt: element["publishedAt"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
