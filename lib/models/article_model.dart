class ArticleModel {
  bool favIcon;
  String title;
  String description;
  String url;
  String urlToImage;

  String publishedAt;

  ArticleModel(
      {required this.title,
      required this.description,
      required this.urlToImage,
      required this.publishedAt,
      this.favIcon = false,
      required this.url});
}
