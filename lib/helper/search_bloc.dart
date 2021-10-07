import 'package:http/http.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final News _repository = News();
  final BehaviorSubject<ArticleModel> _subject =
      BehaviorSubject<ArticleModel>();

  search(String value) async {
    ArticleModel response = await search(value);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ArticleModel> get subject => _subject;
}

final searchBloc = SearchBloc();
