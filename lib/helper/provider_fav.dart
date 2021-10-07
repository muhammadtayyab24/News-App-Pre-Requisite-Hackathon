import 'package:flutter/cupertino.dart';
import 'package:news_app/models/article_model.dart';

class FavouriteBloc extends ChangeNotifier {
  int _count = 0;
  List<ArticleModel> fav = [];

  void addCount() {
    _count++;
    notifyListeners();
  }

  void addfav(ArticleModel data) {
    fav.add(data);
    notifyListeners();
  }

  int get count {
    return _count;
  }

  List<ArticleModel> get newsList {
    return fav;
  }
}
