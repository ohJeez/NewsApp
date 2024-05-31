import 'package:hive/hive.dart';

part 'news_article.g.dart'; // Generated file

@HiveType(typeId: 0)
class NewsArticle extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

// Other fields
}
